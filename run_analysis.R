library(data.table)

#Download the data from the web unless it has already been downloaded.
fileurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

#Retrieve all features
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

#Load the train data
data.train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data.train.activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data.train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
data.train <-  data.frame(data.train.subject, data.train.activity, data.train.x)
names(data.train) <- c(c('subject', 'activity'), features)


#Laod the test data
data.test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')
data.test <-  data.frame(data.test.subject, data.test.activity, data.test.x)
names(data.test) <- c(c('subject', 'activity'), features)

#Merge the test and train data
data.all <- rbind(data.train, data.test)

#Get all features that are the mean or standard dedviation of the measurements and subset over these fields
mean_std.select <- grep('mean|std', features)
data.sub <- data.all[,c(1,2,mean_std.select + 2)]

#Get all the labels
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
data.sub$activity <- activity.labels[data.sub$activity]

#Rename colu,nms appropriately
name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new

#Group by activity and subect and get the mean for all values.
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)


#Write the tidy data in csv.
write.csv(data.tidy, file = "data_tidy.csv", row.names = FALSE)
