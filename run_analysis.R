## run_analysis.R
##
## PRECONDITIONS:
## 1) data files are in an unzipped directory 'UCI HAR Dataset'
##    in the current working directory
## 2) reshape2 and plyr libraries are loaded
##
## POSTCONDITION:
## 1) a file 'tidy_data.txt' containing the tidy data set will be
##    written to the current working directory
##

## LOAD DATA

# read feature labels (column names for data)
feature_labels <- read.table('UCI HAR Dataset/features.txt', 
                       col.names=c('feature_code', 'label'))

# read activity labels (text descriptions for activity column)
act_labels <- read.table('UCI HAR Dataset/activity_labels.txt', 
                         col.names=c('activity_code', 'activity'))

# read test subjects, labels and data
test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt', 
                           col.names=c('subject'))
test_labels <- read.table('UCI HAR Dataset/test/y_test.txt', 
                         col.names=c('activity_code'))
test_data <- read.table('UCI HAR Dataset/test/X_test.txt', 
                       col.names=feature_labels$label, check.names=FALSE)

# read train subjects, labels and data
train_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt', 
                           col.names=c('subject'))
train_labels <- read.table('UCI HAR Dataset/train/y_train.txt', 
                          col.names=c('activity_code'))
train_data <- read.table('UCI HAR Dataset/train/X_train.txt', 
                        col.names=feature_labels$label, check.names=FALSE)

## CLEAN DATA

# merge subjects, labels and data tables (test plus train)
subjects <- rbind(test_subjects, train_subjects)
labels <- rbind(test_labels, train_labels)
data <- rbind(test_data, train_data)

# enhance labels table to include text descriptions of activities
labels <- join(labels, act_labels)

# convert data into a data frame object
data_f <- as.data.frame(data)

# extract only features containing 'mean()' or 'std()'
data_f <- data_f[, grep("mean\\(\\)|std\\(\\)", colnames(data_f))]

# combine subjects, labels and data into a single data frame
data_f <- cbind(subjects, labels, data_f)

# melt data on subject and activity (ie, to give one variable per row)
data_m <- melt(data_f, id.vars=c('subject', 'activity'))

# cast the data by taking the mean of each variable for each 
# (subject, activity) pair
data_t <- dcast(data_m, subject + activity ~ variable, mean)

# sort by activity code
data_t <- data_t[with(data_t, order(subject, activity_code)),]

# drop activity code column (since it effectively duplicates activity)
data_t <- subset(data_t, select=-activity_code)

## WRITE DATA

# write tidy data to file (keep subjects as integer, rather than char)
write.table(data_t, file="tidy_data.txt", row.names=FALSE)


