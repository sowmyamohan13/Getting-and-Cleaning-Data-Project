##Load required packages

library(dplyr)

##Downloaded files

filename= "getdata_projectfiles_UCI HAR Dataset.zip"

if(!file.exists(filename)){
  fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, "filename")
}

if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

## Read data
features<-read.table("./UCI HAR Dataset/features.txt" , col.names = c("n","functions"))
activities <-read.table("./UCI HAR Dataset/activity_labels.txt" ,col.names = c("code", "activity"))

## Read Training set
x_train <-read.table("./UCI HAR Dataset/train/X_train.txt" ,col.names= features$functions)
y_train<- read.table("./UCI HAR Dataset/train/y_train.txt" ,col.names= "code")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

##Read Test set
x_test <-read.table("./UCI HAR Dataset/test/X_test.txt" ,col.names= features$functions)
y_test<- read.table("./UCI HAR Dataset/test/y_test.txt" ,col.names= "code")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

##Merges the training and the test sets to create one data set.

x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
subject<-rbind(subject_train,subject_test)

merged_dataset<-cbind(subject,y,x)

## Extracts only the measurements on the mean and standard deviation for each measurement
tidy_dataset <- merged_dataset %>% select(subject, code, contains("mean"), contains("std"))

##Uses descriptive activity names to name the activities in the data set
tidy_dataset$code<-activities[tidy_dataset$code,2]

##Appropriately labels the data set with descriptive variable names

names(tidy_dataset)[2] = "activity"
names(tidy_dataset)<-gsub("Acc", "Accelerometer", names(tidy_dataset))
names(tidy_dataset)<-gsub("Gyro", "Gyroscope", names(tidy_dataset))
names(tidy_dataset)<-gsub("BodyBody", "Body", names(tidy_dataset))
names(tidy_dataset)<-gsub("Mag", "Magnitude", names(tidy_dataset))
names(tidy_dataset)<-gsub("^t", "Time", names(tidy_dataset))
names(tidy_dataset)<-gsub("^f", "Frequency", names(tidy_dataset))
names(tidy_dataset)<-gsub("tBody", "TimeBody", names(tidy_dataset))
names(tidy_dataset)<-gsub("-mean()", "Mean", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("-std()", "STD", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("-freq()", "Frequency", names(tidy_dataset), ignore.case = TRUE)
names(tidy_dataset)<-gsub("angle", "Angle", names(tidy_dataset))
names(tidy_dataset)<-gsub("gravity", "Gravity", names(tidy_dataset))

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity 
##and each subject
 
final_dataset <-tidy_dataset %>% 
  group_by(subject,activity) %>%
  summarise_all(funs(mean))

##Write the final dataset to a csv file
write.table(final_dataset, "FinalData.txt",row.name=FALSE)
