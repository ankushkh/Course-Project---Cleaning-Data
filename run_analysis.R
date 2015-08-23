# install packages
install.packages("plyr")
library(plyr)
install.packages("reshape2")
library(reshape2)

# read features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt", sep = "")
names(features) <- c("feature_id", "feature")
activity <- read.table("./UCI HAR Dataset/activity_labels.txt", sep = "")
names(activity) <- c("activity_id", "activity")

# read test_data
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", sep = "")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", sep = "")
names(x_test) <- as.character(features[,2])
x_test <- x_test[,c(grep("std", names(x_test)),grep("mean", names(x_test)))]
y_test <- read.table("./UCI HAR Dataset/test/Y_test.txt", sep = "")
names(test_subject) <- "subject_id"
names(y_test) <-  "activity_id"
    
# merge test table
id <- 1:2947
x_test<- cbind(id,x_test)
test_subject$id <- id
y_test$id <- id
test_y_merge <- merge(y_test, activity, all = TRUE, sort = FALSE)
dfList <- list(test_y_merge,test_subject,x_test)
test_fdata <- join_all(dfList, by = "id")
remove(dfList, x_test, y_test, test_subject, test_y_merge, id)

# read train_data
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", sep = "")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", sep = "")
names(x_train) <- as.character(features[,2])
x_train <- x_train[,c(grep("std", names(x_train)),grep("mean", names(x_train)))]
y_train <- read.table("./UCI HAR Dataset/train/Y_train.txt", sep = "")
names(train_subject) <- "subject_id"
names(y_train) <-  "activity_id"

# merge train table
id <- 1:7352
x_train <- cbind(id,x_train)
train_subject$id <- id
y_train$id <- id
train_y_merge <- merge(y_train, activity, all = TRUE, sort = FALSE)
dfList <- list(train_y_merge,train_subject,x_train)
train_fdata <- join_all(dfList, by = "id")
remove(dfList, x_train, y_train, train_subject, train_y_merge, id)

# merge test and train tables
fdata <- rbind(test_fdata, train_fdata)
fdata <- fdata[,-2]
remove(test_fdata,train_fdata)

# melt and cast
fdataMelt <- melt(fdata, id = c("activity_id", "activity", "subject_id"))
fdataCast <- dcast(fdataMelt, activity_id + activity + subject_id  ~ variable, mean)
write.csv(fdataCast, file = "./UCI HAR Dataset/fdata.csv", row.names = FALSE)



