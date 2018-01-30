##Getting and Cleaning Data Course Project
## R script description
# You should create one R script called run_analysis.R that does the following.

#1.Merges the training and the test sets to create one data set.
#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#3.Uses descriptive activity names to name the activities in the data set
#4.Appropriately labels the data set with descriptive variable names.
#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##########################################################################################################


# clean and set up working directory
rm(list=ls())
setwd("C:/Users/Eraphie/Desktop/DATA SCIENCE/Module 3 Getting and Cleaning Data/Programming assignment/UCI HAR Dataset")

#Read supporting data (List of all features and Links the class labels with their activity name)
featureNames <- read.table('./features.txt', header = FALSE)
activityLabels <- read.table('./activity_labels.txt', header = FALSE)

#Read training and test data
subjectTrain <- read.table('./train/subject_train.txt', header = FALSE)
y_Train <- read.table('./train/y_train.txt', header = FALSE)
x_Train <- read.table('./train/X_train.txt', header = FALSE)

subjectTest <- read.table('./test/subject_test.txt', header = FALSE)
y_Test <- read.table('./test/y_test.txt', header = FALSE)
x_Test <- read.table('.//test/X_test.txt', header = FALSE)




#TASK1 MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA.

#Combine data
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(y_Train, y_Test)
features <- rbind(x_Train, x_Test)

#Name the columns of features data using featureNames
colnames(features) <- t(featureNames[2])

#Merge the data
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)



#TASK2 EXTRACTS ONLY THE MEASUREMENT ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT

#extract column indices with either mean and standard deviation

columns_meanSD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)


# add activity and subject column to the list
requiredColumns <- c(columns_meanSD, 562, 563)
dim(completeData)


#Create extarcted data using requiredColumns
extractedData <- completeData[,requiredColumns]
dim(extractedData)



#TASK3 USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

#change the class from numeric to character

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
    extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

#factor the activity
extractedData$Activity <- as.factor(extractedData$Activity)



#TASK4 APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES

names(extractedData)

#replace the acronyms

names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "Stdev", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))


#TASK5 FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE

# Set the subject as the factor
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

#create final dataset with the average for each activity and subject

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)