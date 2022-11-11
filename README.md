An Experiment on Animal Re-Identification from Video
===


## 1. Data
---

The data is from repository: [LucyKuncheva/Animal-Identification-from-Video](https://github.com/LucyKuncheva/Animal-Identification-from-Video).

## 2. Code
---
The code is divided in two parts, the first is in **MATLAB** with the feature extractions, the second is in **Python** with more feature extraction, the deeplearning and `lazypredict`.

### 2.1 MATLAB

* **AE (autoencoder) features**:
* **HOG features**:
* **LBP features**:
* **RGB features**: 

### 2.2 Python

* **MN2 (ImageNetV2) features**: In the file `functions.py` it is the `extractMobilNetfeatures` function. Recives the output of the `select_half_video` and return the dataset with *MobileNetV2* features.
* **Deeplearning**: In the *Jupyter Notebook* `DeepLearningClassification` the Convolutional Neural Network (CNN) and the Transfer Learning with *MobileNetV2* can be executed. The variable `training_fold` choose which half of the video will be used as training. 
* **`lazypredict`**:


## Acknowledgement
---
This work is supported by the UKRI Centre for Doctoral Training in Artificial Intelligence, Machine Learning and Advanced Computing (AIMLAC), funded by grant EP/S023992/1. This work is also supported by the Junta de Castilla  León under project BU055P20 (JCyL/FEDER, UE), the Ministry of Science and Innovation under project PID2020-119894GB-I00 co-financed through European Union FEDER funds, and the Ministry of Universities under mobility grant PRX21/00638. J.L. Garrido-Labrador is supported through Consejería de Educación of the Junta de Castilla y León and the European Social Fund through a pre-doctoral grant (EDU/875/2021). I. Ramos-Perez is supported by the predoctoral grant (BDNS 510149) awarded by the Universidad de Burgos, Spain.
