library(dplyr)
library(data.table)

# 1. Merges the training and the test sets to create one data set

#read the feature names and activity data
featurenames <- read.table("UCI HAR Dataset/features.txt, header = FALSE")
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#read the data training and test
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt, header = FALSE")
features_train<- read.table("UCI HAR Dataset/train/x_train.txt, header = FALSE")
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt, header = FALSE")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt, header = FALSE")
features_test <- read.table("UCI HAR Dataset/test/X_test.txt, header = FALSE")
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt, header = FALSE")

# create features data 
features_data <- rbind(features_train, features_test)

# create activity data
activity_data <- rbind(activity_train, activity_test)

# create subject data
subject_data <- rbind(subjecttrain, subjecttest)


#add name for trhe column
colnames(features_data) <- t(featurenames[2])
colnames(activity_data) <- "Activity"
colnames(subject_data) <- "Subject"

#merge the data
all_data <- cbind(features_data,activity_data,subject_data)


# 2. Extracts only the measurements on the mean and 
#    standard deviation for each measurement

mean_std_col <- grep(".*Mean.*|.*Std.*", names(all_data), ignore.case=TRUE)
mean_std_col <- c(mean_std_col, 562, 563)
data_extract <- all_data[,mean_std_col]

# 3. Uses descriptive activity names to name the activities in the data set
data_extract$Activity <- as.character(data_extract$Activity)
for (i in 1:6){
  data_extract$Activity[data_extract$Activity == i] <- as.character(activitylabels[i,2])
}
data_extract$Activity <- as.factor(data_extract$Activity)

# 4. Appropriately labels the data set with descriptive variable names
names(data_extract)<-gsub("Acc", "Accelerometer", names(data_extract))
names(data_extract)<-gsub("Gyro", "Gyroscope", names(data_extract))
names(data_extract)<-gsub("BodyBody", "Body", names(data_extract))
names(data_extract)<-gsub("Mag", "Magnitude", names(data_extract))
names(data_extract)<-gsub("^t", "Time", names(data_extract))
names(data_extract)<-gsub("^f", "Frequency", names(data_extract))
names(data_extract)<-gsub("tBody", "TimeBody", names(data_extract))
names(data_extract)<-gsub("-mean()", "Mean", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("-std()", "STD", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("-freq()", "Frequency", names(data_extract), ignore.case = TRUE)
names(data_extract)<-gsub("angle", "Angle", names(data_extract))
names(data_extract)<-gsub("gravity", "Gravity", names(data_extract))

#5. From the data set in step 4, creates a second, 
#   independent tidy data set with the average of each variable 
#   for each activity and each subject
data_extract$Subject <- as.factor(data_extract$Subject)
data_extract <- data.table(data_extract)

tidy_data <- aggregate(. ~Subject + Activity, data_extract, mean)
tidy_data <- tidy_data[order(tidy_data$Subject,tidy_data$Activity),]
write.table(tidy_data, file = "tidy.txt", row.names = FALSE)


