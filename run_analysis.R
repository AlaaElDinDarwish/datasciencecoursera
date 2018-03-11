## reading data and assing the column names:

## activity lables:
activity_lables<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
colnames(activity_lables)<-c("activityId","activity_name")

## features:
features<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/features.txt")

## Reading test data:
xtest<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
ytest<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
subjecttest<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

##colomnames for test data:
colnames(xtest)<-features[,2]
colnames(ytest) <- "activityId"
colnames(subjecttest) <- "subjectId"

## Reading train data:

ytrain<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
xtrain<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
subjecttrain<-read.table("./getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")

##colomnames for train data:
colnames(xtrain)<-features[,2]
colnames(ytrain) <- "activityId"
colnames(subjecttrain) <- "subjectId"



##combining test data:
testcombined<- cbind(subjecttest,ytest,xtest)


##combining train data:
traincombined<- cbind(subjecttrain,ytrain,xtrain)


##making the final data set:
test_train_combined<-rbind(testcombined,traincombined)


##Extracting only the measurements on the mean and standard deviation for each measurement

meanANDstd <- (grepl("activityId" , colnames(test_train_combined)) | grepl("subjectId" , colnames(test_train_combined)) | grepl("mean.." , colnames(test_train_combined)) | grepl("std.." , colnames(test_train_combined)) )

setForMeanAndStd<-test_train_combined[,meanANDstd==TRUE]


##Using descriptive activity names to name the activities in the data set:
NamesOfsetForMeanAndStd<- merge(setForMeanAndStd,activity_lables,by="activityId"





##Creating a second, independent tidy data set with the average of each variable for each activity and each subject

secTidySet <- aggregate(. ~subjectId + activityId, NamesOfsetForMeanAndStd, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

