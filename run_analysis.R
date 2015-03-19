# run_analysis.R
library(plyr)
# set the working directory
getwd()
setwd("C:/Users/User/Dropbox/Data Science/Jonhs Hopkins Courses/R coding practice _Ying/Getting and Cleaning data")

if(!file.exists("Gettting-and-Cleaning-the-Data_Course-Project")){
        dir.create("Gettting-and-Cleaning-the-Data_Course-Project")
}

# download data and unzip data in the working directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDest<- "./Gettting-and-Cleaning-the-Data_Course-Project/Dataset.zip"
download.file(fileUrl, destfile =fileDest)
datedownloaded <- date()

unzip("./Gettting-and-Cleaning-the-Data_Course-Project/Dataset.zip", exdir="./Gettting-and-Cleaning-the-Data_Course-Project")

##################################################################
## 1. Merges the training and the test sets to create one data set.
datapath <- file.path("./Gettting-and-Cleaning-the-Data_Course-Project" , "UCI HAR Dataset")
files<-list.files(datapath, recursive=TRUE)
files

# read data
TestData  <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/test/X_test.txt")
TrainData <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/train/X_train.txt")

SubjectTest  <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/test/subject_test.txt")
SubjectTrain <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/train/subject_train.txt")
unique(SubjectTest)
unique(SubjectTrain)

Label_Test  <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/test/y_test.txt")
Label_Train <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/train/y_train.txt")

TestData1  <- cbind(SubjectTest,  Label_Test,  TestData)
TrainData1 <- cbind(SubjectTrain, Label_Train, TrainData)
#name the first two columns properly
names(TestData1)[1:2]  <- c("SubjectID", "activity")
names(TrainData1)[1:2] <- c("SubjectID", "activity")

# merge data
MergedData<-rbind(TestData1, TrainData1)  ## this is the merged data

#name the merged data with Features.txt
FeaturesNames <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/Features.txt")
names(MergedData)[3:ncol(MergedData)] <- as.character(FeaturesNames$V2)

##################################################################
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
SelectedData <- cbind(MergedData[c("SubjectID", "activity")], MergedData[, grep("mean\\(\\)|std\\(\\)", names(MergedData))])
str(SelectedData)

##################################################################
## 3. Uses descriptive activity names to name the activities in the data set
activity_label <- read.table("./Gettting-and-Cleaning-the-Data_Course-Project/UCI HAR Dataset/activity_labels.txt")
MergedData <- mutate(MergedData, activityName = activity_label$V2[MergedData$activity])


##################################################################

# 4. Appropriately labels the data set with descriptive variable names. 

names(MergedData)<-gsub("Acc","Acceleration", names(MergedData)) 
names(MergedData)<-gsub("Gyro","Gyroscope", names(MergedData)) 
names(MergedData)<-gsub("Mag","Magnitude", names(MergedData)) 
names(MergedData)<-gsub("^t","Time", names(MergedData)) 
names(MergedData)<-gsub("^f","Frequency", names(MergedData)) 



# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

TidyData <- ddply(MergedData, .(SubjectID, activity), function(x) colMeans(x[, 1:(length(MergedData)-1)]))
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)


# Alternatively
# Data<-aggregate(. ~SubjectID + activity, MergedData, mean)
# Data<-Data[order(Data$SubjectID,Data$activity),]
library(knitr)
knit2html("codebook.Rmd")

