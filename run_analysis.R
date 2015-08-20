library(plyr)
library(reshape2)

# read the feature and activity descriptive data
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# features use names such as mean() and std(), which results in ugly column names. Remove the ().
features$V2 <- gsub("\\(\\)", '', features$V2)

# build the TEST dataset
testd <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$V2)
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities <- read.table("UCI HAR Dataset/test/y_test.txt")

# add subject id and human readable activities to the dataset
testd$subject <- test_subjects$V1
testd$activity <- join(test_activities, activities, by="V1")$V2

# build the TRAIN dataset
traind <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$V2)
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities <- read.table("UCI HAR Dataset/train/y_train.txt")

# add subject id and human readable activities to the dataset
traind$subject <- train_subjects$V1
traind$activity <- join(train_activities, activities, by="V1")$V2

# Column names with "mean" or "std" in the names are mean or standard deviation columns.
# Find all mean and standard deviation columns and save them.
mean_columns <- grep("mean", names(traind), value=TRUE)
std_columns <- grep("std", names(traind), value=TRUE)

# create a dataset that consists of only those columns from the testd and traind 
# full dataset with mean or std in them, as well as our subject and activity columns.
test_mean_std <- subset(testd, select=c(mean_columns, std_columns, "subject", "activity"))
train_mean_std <- subset(traind, select=c(mean_columns, std_columns, "subject", "activity"))

# identify test or train dataset in the data, just in case.
test_mean_std$type <- "TEST"
train_mean_std$type <- "TRAIN"

# build the full dataset by combining the train and test data.
ds <- rbind(train_mean_std, test_mean_std)

# melt the full dataset into something we can more easily calculate mean values of the
# columns in question.
melts <- melt(ds, id=c("subject", "activity"), measure.vars=c(mean_columns, std_columns))

# create first-pass tidy datasets. Average of all variables by subject, and by activity.
tidy_subject_summary <- dcast(melts, subject ~ variable,mean)
tidy_activity_summary <- dcast(melts, activity ~ variable,mean)

# rename the key column to be the same in both datasets.
tidy_activity_summary <- rename(tidy_activity_summary, c("activity" = "ActivityOrSubject"))
tidy_subject_summary <- rename(tidy_subject_summary, c("subject" = "ActivityOrSubject"))

# ensure data type consistency in the key column.
tidy_activity_summary$ActivityOrSubject <- as.character(tidy_activity_summary$ActivityOrSubject)
tidy_subject_summary$ActivityOrSubject <- as.character(tidy_subject_summary$ActivityOrSubject)

# combine the activity and subject datasets to generate the final, tidy dataset
tidy <- rbind(tidy_activity_summary, tidy_subject_summary)

write.table(tidy, file="tidy.txt", row.name=FALSE)