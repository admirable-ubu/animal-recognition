This folder contains the MATLAB code for feature extraction from images. The function `get_rgb_features.m` splits the images into a number of $N$ blocks, where $N$ is a square number, e.g., 1, 4, 9, 16. For each block, the function calculates the average red, green and blue, as well as their standard deviations. The values are returned as an 1-by-[6 $\times$ $N$] vector row arranged as: $[mr_1, sr_1, mg_1, sg_1, mb_1, sb_1, mr_2, sr_2, mg_2,…]$, where $m$ stands for mean, s stands for standard deviation and the tag is the block number.

Script `PrepareData.m` is an example of feature extraction using `get_rgb_features.m`, as well as the MATLAB functions ` get_rgb_features` for shape features and ` extractLBPFeatures` for texture features.

Finally, script `Extract_AE_Features.m` is an example of using MATLAB functions `trainAutoencoder` and `encode` for extracting features using an autoencoder.

All MATLAB functions are used with their default parameters. Note that the example scripts use domain files and folders and are not suitable as stand-alone demos. 
