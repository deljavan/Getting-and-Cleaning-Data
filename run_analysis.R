
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./GCDCP-Dataset.zip")
unzip(zipfile="./GCDCP-Dataset.zip")
filepath <- file.path("." , "UCI HAR Dataset")
files<-list.files(filepath, recursive=TRUE)

##Read the Activity files
dataActivityTest  <- read.table(file.path(filepath, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(filepath, "train", "Y_train.txt"),header = FALSE)
##Read the Subject files
dataSubjectTrain <- read.table(file.path(filepath, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(filepath, "test" , "subject_test.txt"),header = FALSE)
##Read Fearures files
dataFeaturesTest  <- read.table(file.path(filepath, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(filepath, "train", "X_train.txt"),header = FALSE)

## Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

##set names to variables and merge data frame
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(filepath, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

dataCombine <- cbind(dataSubject, dataActivity)
Data <- cbind(dataFeatures, dataCombine)

subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]

selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

activityLabels <- read.table(file.path(filepath, "activity_labels.txt"),header = FALSE)

##Names of Feteatures will labelled using descriptive variable names.
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt",row.name=FALSE)

