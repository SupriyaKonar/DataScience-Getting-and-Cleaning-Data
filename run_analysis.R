library(plyr);

## Set your working directory.
setwd('/Users/konar/desktop/DataScience')

## Download the data file and put it in working directory.

if(!file.exists("./sourcedata")){dir.create("./sourcedata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./sourcedata/AssignmentDataset.zip",method="auto")

##Unzip the file , It should create the DIrectory UCI HAR Dataset in working directory
unzip(zipfile="./sourcedata/AssignmentDataset.zip",exdir="./sourcedata")


##Read Data 

path_var <- file.path("./sourcedata" , "UCI HAR Dataset")

y_test <- read.table(file.path(path_var, "test" , "y_test.txt" ),header = FALSE)
y_train <- read.table(file.path(path_var, "train", "y_train.txt"),header = FALSE)


x_Test  <- read.table(file.path(path_var, "test" , "X_test.txt" ),header = FALSE)
x_Train <- read.table(file.path(path_var, "train", "X_train.txt"),header = FALSE)

Subject_Test  <- read.table(file.path(path_var, "test" , "subject_test.txt"),header = FALSE)
Subject_Train <- read.table(file.path(path_var, "train", "subject_train.txt"),header = FALSE)


FeaturesNames <- read.table(file.path(path_var, "features.txt"),head=FALSE)
activityLabels <- read.table(file.path(path_var, "activity_labels.txt"),header = FALSE)

##Merge the Training and Test dataset

xdata <- rbind(x_Train,x_Test)
ydata <- rbind(y_train,y_test)
subjectdata <- rbind(Subject_Train,Subject_Test)

##Set names
names(subjectdata) <- c("subject")
names(ydata) <- c("activity")
names(xdata) <- FeaturesNames$V2

##Create Final Dataset

combinedata <- cbind(subjectdata, ydata)
data <- cbind(xdata,combinedata)

##Extracts only the measurements on the mean and standard deviation for each measurement.

subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

subsetnames <-c(as.character(subsetFeaturesNames), "subject", "activity" )
data<-subset(data,select=subsetnames)

##Descriptive activity names to name the activities in the data set
data$activity <- factor(data$activity, levels = activityLabels[,1], labels = activityLabels[,2])

##Appropriately labels the data set with descriptive variable names.
names(data)<-gsub("^t", "time", names(data))
names(data)<-gsub("^f", "frequency", names(data))
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
names(data) = gsub('-mean', 'Mean', names(data))
names(data) = gsub('-std', 'Std', names(data))
names(data) <- gsub('[-()]', '', names(data))


##creates a second, independent tidy data set 

resultdata<-aggregate(. ~subject + activity, data, mean)
resultdata<-resultdata[order(resultdata$subject,resultdata$activity),]
write.table(resultdata, file = "tidydata.txt",row.name=FALSE)



