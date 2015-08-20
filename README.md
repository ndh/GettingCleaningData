# GettingCleaningData

## Project Instructions

From the coursera class website:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

 You should create one R script called run_analysis.R that does the following. 
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!

## Data Files

The following datafiles were loaded to complete this project:

- features.txt: name of each measurement.
- activity_labels.txt: lookup table of numeric ID and human readable activity description.
- X_test.txt and X_train.txt: raw training and testing measurements
- subject_test.txt and subject_train.txt: subject ID correlating to each measurement in the X_test and X_train datafiles.
- y_test.txt and y_train.txt: activity ID correlating to each measurement in the X_test and X_train datafiles.

## Methodology

To complete this project, the following steps were coded:

1. Load the feature names and activity lookup data from the raw datafiles. Process feature names to remove unwanted "()" characters.
1. Load the test and train measurement data and the related subject and activity data for each measurement file into separate data frames.
1. Add the test subject ID and the descriptive activity label to the test and train data frames.
1. Create subsets of the test and train data frames to only pull columns that contain "mean" or "std" in them. 
1. Combine the test and train data into one data frame.
1. Melt the combined test and train data frame, with subject and activity ID columns and all of the mean and std columns as the measurements.
1. dcast() the melted data frame, first for subject, next for activity. Take the mean of each variable column.
1. Rename the key column in each dcast data frame to ActivityOrSubject, and convert them to character data. Now that they are identical names and data types,
1. Combine the subject and activity data frames into the final tidy data frame. 
1. Write that data frame to a text file.



