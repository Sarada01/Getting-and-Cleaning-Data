# 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable   names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Download the 
# fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#
# download.file(fileURL,"Dataset.zip")
# extract Dataset compressed data into current directory under "UCI HAR Dataset" directory
# unzip("Dataset.zip")  
# file.remove("Dataset.zip")

dirName <- "UCI HAR Dataset"
features <- read.csv(paste(dirName,"features.txt",sep="/"),head=FALSE,sep="")

activity_labels <- read.csv(paste(dirName,"activity_labels.txt",sep="/"),head=FALSE,sep="")
colnames(activity_labels) <- c("Activity","Activity_Desc")

final_columns <- features[grep(".*mean\\(\\).|.*std\\(\\).", features[,2]),1]

# Add activity and subject columns

train_data <-read.csv(paste(dirName,"train","X_train.txt",sep="/"),head=FALSE,sep="")
train_features <- read.csv(paste(dirName,"train","y_train.txt",sep="/"),head=FALSE,sep="")
train_subjects <- read.csv(paste(dirName,"train","subject_train.txt",sep="/"),head=FALSE,sep="")

    
test_data  <- read.csv(paste(dirName,"test","X_test.txt",sep="/"),head=FALSE,sep="")
test_features <- read.csv(paste(dirName,"test","y_test.txt",sep="/"),head=FALSE,sep="")
test_subjects <- read.csv(paste(dirName,"test","subject_test.txt",sep="/"),head=FALSE,sep="")


combined_data <- combined_data[,c(final_columns,562,563)]
colnames(combined_data) <- c(as.character(features[final_columns,2]),"Activity","Subject")

combined_data <- merge(combined_data,activity_labels)

tidy_data <- aggregate(combined_data, by=list(activity = combined_data$Activity_Desc,subject=combined_data$Subject),mean)

write.table(tidy_data)
