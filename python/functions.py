## Preparing Image Data for Assignment 1
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import tensorflow as tf
from skimage.transform import resize


##############################################
# FUNCTIONS
#---------------------------------------------------------
def convert_to_binary(y,n):
    """Convert to binary the labels of the dataset

    Parameters
    ----------
    y : array
        Labels of the dataset.
    n : int
        Number of classes.

    Returns
    -------
    y, u: array, array
        y: binary labels of the dataset.
    """    
    u = list(np.unique(y))
    y = np.zeros((len(y),n))
    for i in range(len(y)):
        y[i,u.index(y[i])] = 1
    return y,u
        
#---------------------------------------------------------
def select_half_video(folder,bb_file,part = 1):
    """Select half of the video frames.

    Parameters
    ----------
    folder : str
        Path to the folder containing the video frames.
    bb_file : str
        Path to the file containing the bounding boxes.
    part : int, optional
        The half of the video to load, by default 1

    Returns
    -------
    images, labels: array, array
        images: array containing the video frames.
        labels: array containing the labels of the video frames.
    """    
    
    bb = pd.read_csv(bb_file,header = None)    
    bb = bb.to_numpy()
   
    # Find the number of frames in the video
    lasf_file_name = bb[-1,5]
    f = np.int(lasf_file_name[5:10]) 
    half_f = np.floor(f/2).astype(int)
    
    images, labels = [],[]
    for i in range(len(bb)):
        z = bb[i,5] # take the file name
        nn = np.int(z[5:10]) # convert to numeric
        flag = ((part == 1) & (nn <= half_f)) | \
            ((part == 2) & (nn > half_f)) 
        if flag:
            label = bb[i,0] # take the string label
            label = label.replace(' ','') # trim the blanks
            filename = bb[i,5] 
            fn = label+'/'+ label + '_frame_' + filename[5:10] + '.jpg'
            img = plt.imread(folder+'/'+fn)
            if img is not None:
                images.append(img)
                labels.append(label)
            else:
                print(folder+'/'+fn)     
            
    return images, labels

def extractMobilNetfeatures(imds, labels, r=56):
    """Extract features from the MobileNet model.

    Parameters
    ----------
    imds : array
        Array containing the images.
    labels : array
        Array containing the labels of the images.
    r : int, optional
        Resize the images to r x r, by default 56

    Returns
    -------
    X-y: array
        Array containing the features and labels. Labels are in the last columns.
    """    

    ll = list(np.sort(np.unique(labels)))

    X_im = []
    X = []
    y_num = []
    for i in range(len(imds)):
        y_num.append(ll.index(labels[i]))
        X.append(resize(imds[i], (r, r)))
        X_im.append(imds[i])
    X = np.array(X)/255  

    base_model = tf.keras.applications.MobileNetV2(input_shape = \
                (r, r, 3), include_top = False, weights = "imagenet")

    xx = base_model(X,training = False)
    xx_shaped = tf.keras.layers.GlobalAveragePooling2D()(xx)

    return np.hstack((xx_shaped, np.array(y_num).reshape(-1,1)))