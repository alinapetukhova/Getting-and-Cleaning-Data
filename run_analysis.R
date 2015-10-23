run_analysis <- function() {
 
#get labels
label <- read.table("./features.txt") 
activitylabel <- read.table("./activity_labels.txt") 
  
# testdata
#get data from files
x_test <- read.table("./test/X_test.txt") 
y_test <- read.table("./test/y_test.txt") 
subject_test <- read.table("./test/subject_test.txt")

#change names for initial data
names(x_test) <- label[,2]
names(subject_test) <- gsub("V1", "subject", names(subject_test))

#merge y data with activity name
y_test <- merge(y_test, activitylabel, by = c("V1", "V1"))
names(y_test) <- gsub("V2", "action", names(y_test))

#merge test data
testvalues <- cbind(x_test, y_test, subject_test)

# traindata
#get data from files
x_train <- read.table("./train/X_train.txt") 
y_train <- read.table("./train/y_train.txt") 
subject_train <- read.table("./train/subject_train.txt")

#change names for initial data
names(x_train) <- label[,2]
names(subject_train) <- gsub("V1", "subject", names(subject_train))

#merge y data with activity name
y_train <- merge(y_train, activitylabel, by = c("V1", "V1"))
names(y_train) <- gsub("V2", "action", names(y_train))

#merge train data
trainvalues <- cbind(x_train, y_train, subject_train)

#merge all data
library("plyr")
mergedval <- rbind.fill(testvalues, trainvalues)

#get col with mean() and std()
newdata <- mergedval[,grepl("mean\\(\\)|std\\(\\)|subject|action",names(mergedval))];

#change col names to full
names(newdata) <- gsub("^f", "FFT", names(newdata))
names(newdata) <- gsub("^t", "TimeDomain", names(newdata))
names(newdata) <- gsub("BodyBody", "Body", names(newdata))
names(newdata) <- gsub("Acc", "Acceleration", names(newdata))
names(newdata) <- gsub("std", "StandardDeviation", names(newdata))
names(newdata) <- gsub("mean", "MeanValue", names(newdata))
names(newdata) <- gsub("\\(|\\)", "", names(newdata))
names(newdata) <- gsub("Gyro", "AngularVelocity", names(newdata))
names(newdata) <- gsub("Mag", "Magnitude", names(newdata))
 
#group data by subject, action and get mean
library("dplyr")
finaldata <- newdata %>% group_by(subject, action) %>% summarise_each(funs(mean))

#write tidydata file
write.table(finaldata, "./tidydata.txt", row.name=FALSE)
return("success")

}
