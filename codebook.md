**Getting and Cleaning Data Course Project**

This project is an exercise in getting and cleaning data. The project uses data from the UCI Machine Learning Repository: Human Activity Recognition and Smart Phone Data site: [links] http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data for the project can be downloaded here: [links] https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This code book relies on the source code book listed in the README.txt of the zip archive and available at the UCI link for definitions and descriptions.

**Initial Processing**

Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

Read the data extracted from zipfile

- features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
- activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
- subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
- x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
- y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
- subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
- x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
- y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

**Step 1: Merge training and test sets to create one data set**
- x (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
- y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
- subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
- merged_dataset (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

**Step 2: Extract only measurements on mean and standard deviation**
A clean dataset tidy_dataset (10299 rows, 88 columns) is created by subsetting merged_dataset by selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

**Step 3: Use descriptive activities names for activity measurements**
Entire numbers in code column of the tidy_dataset is replaced with corresponding activity taken from second column of the activities variable

**Step 4: Appropriately Label the Dataset with Descriptive Variable Names**
- code column in tidy_dataset renamed into activities
- All Acc in column’s name replaced by Accelerometer
- All Gyro in column’s name replaced by Gyroscope
- All BodyBody in column’s name replaced by Body
- All Mag in column’s name replaced by Magnitude
- All start with character f in column’s name replaced by Frequency
- All start with character t in column’s name replaced by Time

**Step 5: Create tidy data set with average of each variable, by activity, by subject**
The final data final_dataset (180 rows, 88 columns) is created by sumarizing tidy_dataset by taking the average of each variable for each activity and each subject, after grouped by subject and activity.

Export final_dataset into FinalData.txt file.