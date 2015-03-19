#This code book describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 

## Data Set Information:

Raw data is provided by Human Activity Recognition Using Smartphones Data Set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

For each record in the dataset it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope.
* A 561-feature vector with time and frequency domain variables. (obtained from "Features.txt")
* Its activity label. (named "activity" in the R script)
* An identifier of the subject who carried out the experiment. (named "SubjectiveID" in the R script)

## Variables created in "run_analysis.R"
* TestData: data from testing group, read from "x_test.txt"
* TrainData: data from training group, read from "x_train.txt"
* SubjectTest: Subjective ID of testing group, read from "subject_test.txt"
* SubjectTrain: Subjective ID of training group, read from "subjecti_train.txt"
* Label_Test: activity type (1-6) of testing group, read from "y_test.txt"
* Label_Train: activity type (1-6) of training group, read from "y_train.txt"
* TestData1: merged data set with SubjectTest, Label_Test, and TestData
* TrainData1: merged data set with SubjectTrain, Label_Train, and TrainData
* MergedData: merged data set of testing and training group (TestData1 and TrainData1)
* FeaturesNames: names of all the features, read from "Features.txt"
* SelectedData: data with only the measurements on the mean and standard deviation for each measurement.
* activity_label: descriptive names of 6 activities
* MergedData1: new merged data set with descriptive activity names
* TidyData:  a second, independent tidy data set with the average of each variable for each activity and each subject.

## Steps and transformations performed to clean up the data
1. download the compressed raw data from [link to raw data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip), unzip the raw data in the working directory
2. read the data from the data directory (use "read.table()")
3. merges the training and the testing sets to create one data set.
   * The data directory ("UCI HAR Dataset") contains datasets ("X_train.txt" and "X_test.txt"), subjects ID ("subject_test.txt" and "subject_train.txt"), activity types ("y_test.txt" and "y_train.txt"), and list of all features ("Features.txt") for both testing group and training group separately.
   * merge subject ID, activity types, and datasets for both testing and training group (use "cbind()")
   * merge testing and traning data sets (use "rbind()")
   * name the merged data with list of all features 
4. extracts only the measurements on the mean and standard deviation for each measurement. 
5. uses descriptive activity names to name the activities in the data set
6. appropriately labels the data set with descriptive variable names. 
7. creates a second, independent tidy data set with the average of each variable for each activity and each subject, "tidydata.txt"

