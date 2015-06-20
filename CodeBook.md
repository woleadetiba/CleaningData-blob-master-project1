#CodeBook.md

Here is the project task:

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


Project1 of the CleaningData Course on Coursera

Getting and Cleaning Data This is a repository the project1 for the "Getting and Cleaning Data" Coursera course from JHU.

Course Project

Here is the description of the orcessing done in the "run_analysis.R"

The data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is imported locally for processing. 

X_Train and X_Text data are read and merged together using rbind function. Subject and Y data are treated same way. For the headers for X data, they are extracted from the features file, and only the standard deveiation and mean feautures are considered.

cbind is used to merge X, Y and S data together. The merged record is written to the output file (merged_and_cleaned.txt), as required by the project.

Dyplr package feature is used for further proceesing of merged records to obtain the mean for each of the columns of the observations. The output of this is written to the file, (data_set_with_the_averages.txt)
