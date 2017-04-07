# DataScience-Getting-and-Cleaning-Data

This is the course project for the Getting and Cleaning Data Coursera course. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set.

###Summary

The R script, run_analysis.R, does the following:

* Download the dataset in the working directory (set working directory accordingly)
* Load the Training,Test dataset and merge them into a single one.
* Extract only the measurements on the mean and standard deviation for each measurement from the combined dataset.
* Loads the activity and subject data for each dataset, and merges those columns with the dataset
* Converts the activity and subject columns into factors
* Appropriately labels the data set with descriptive variable names.
* Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
* The end result is shown in the file tidydata.txt.

Additional information about the variables, data and transformations is available in the CodeBook.MD file.


