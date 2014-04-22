run_analysis.R
==============

Getting and Cleaning Data Project

This script processes accelerometers from the Samsung Galaxy S smartphone data obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Further details of data are available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Preconditions
-------------

1. data files are downloaded and unzipped into the directory 'UCI HAR Dataset' in the current working directory
2. reshape2 and plyr libraries are loaded into the R environment

Postcondition
-------------

1. a file 'tidy_data.txt' containing the tidy data set is written to the current working directory
2. the tidy data set is available as 'data_t'

Cleaning steps
--------------

1. The original test and training sets are combined
2. Numerical activity codes are replaced with text descriptions
3. Mean and standard deviation fields are extracted (all other fields are excluded)
4. Means and standard deviation values are averaged for each activity and subject (NB: original column labels are retained)
5. Tidied data is sorted by (a) subject number and (b) activity type

Tidied data fields
------------------

* subject: the subject ID
* activity: the type of activity
* all remaining columns contain averages of the original values for that subject and activity
