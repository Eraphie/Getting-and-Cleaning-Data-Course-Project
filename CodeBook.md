# Getting and Cleaning Data Course Project CodeBook

A code book that describes the variables, the data, and any transformations or work that were performed to clean up the data.

## Original Data
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


## Overview of the Human Activity Recognition Using Smartphones Dataset
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


## R script
run_analysis.R decribes the steps in converting raw data to processed/tidy data

## Step1:Merges the training and the test sets to create one data set.
Clean and set up working directory using setwd()
Read the following using read.table
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Assign column names and merge to create one data set.


## Step2.Extracts only the measurements on the mean and standard deviation for each measurement.
extract column indices with either mean and standard deviation using pattern matching and replacement, grep()
Subset this data to keep only the necessary/required columns.

## Step3.Use descriptive activity names to name the activities in the data set
change the class from numeric to character usign as.character() and the activityLabels 
Coerce activity as factor using as.factor()


## Step4.Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

## Step5.Create a second, independent tidy data set with the average of each variable for each activity and each subject.
generate a tidy data set with the average of each measurement for each activity and each subject using aggregate(), order , write.table()









