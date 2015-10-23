==================================================================
Script for tidy data of Human Activity Recognition Using Smartphones Dataset
Version 2.0
==================================================================
==================================================================

The dataset includes the following files:
=========================================

- 'README.txt'

- 'run_analysis.R': Creating tidy data from Human Activity Recognition Using Smartphones Dataset

- 'codebook.txt': Describing the variables.


Steps for cleaning data: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- Training and the test sets are merged in the one data set.
- Extracted only the measurements on the mean and standard deviation for each measurement.
- All vectors are named by activity names, abbreviations changed to full names. 
- Final tidy data set created by group of each variable for each activity and each subject with the mean value.
