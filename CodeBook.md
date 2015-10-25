Project uses https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip dataset. first, code download
the data set and name itGCDCP-Dataset.zip in root folder.
then code read all files inside UCI HAR Dataset folder recursively. then read Y_test.txt, Y_train.txt for activity, subject_train.txt
and subject_test.txt for subjects, X_test.txt and X_train.txt for Fearures into

dataActivityTest , dataActivityTrain, dataSubjectTrain, dataSubjectTest, dataFeaturesTest, dataFeaturesTrain variables.

dataSubject, dataActivity dataFeatures are the concatination of each set. Data variable will be merge result of all the three set of data.
subdataFeaturesNames is subset Name of Features by measurements on the mean and standard deviation.
selectedNames stores subset of the data frame Data by seleted names of Features
activityLabels read descriptive activity names from “activity_labels.txt”
Names of Feteatures will labelled using descriptive variable names (e.g. names(Data)<-gsub("^t", "time", names(Data)))

    prefix t is replaced by time
    Acc is replaced by Accelerometer
    Gyro is replaced by Gyroscope
    prefix f is replaced by frequency
    Mag is replaced by Magnitude
    BodyBody is replaced by Body

independent tidy data set will be created in Data2 and will be written in tidydata.txt file with the average of each variable for each activity and each subject based on the data set based on
previous step
