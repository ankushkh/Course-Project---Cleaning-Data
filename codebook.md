
Following are the variables (V) and transformation steps (T) performed for the data

(V) features # contains raw data from feastures.txt
(T) names(features) <- c("feature_id", "feature") # modifies the names of the variables to readable format
(V) activity # contain raw data from activity_lables. txt
(T) names(activity) <- c("activity_id", "activity") # modifies the names of the variables to readable format

# read test_data
(T) x_test <- x_test[,c(grep("std", names(x_test)),grep("mean", names(x_test)))] # only selects columns that either have mean or std in their names (79 variables)

# merge test table
(V) id # no. of rows; used later for mering
(T) test_y_merge <- merge(y_test, activity, all = TRUE, sort = FALSE) # mergeds y_test with activity names
(T) dfList <- list(test_y_merge,test_subject,x_test) # creates a list for future joining
(T) test_fdata <- join_all(dfList, by = "id") # joins the data frames in the list
(T) remove(dfList, x_test, y_test, test_subject, test_y_merge, id) # removes frames not being used from memory to minimize usage

# merge test and train tables
(T) fdata <- rbind(test_fdata, train_fdata) # rbinds the test and train data frames

# melt and cast
(T) fdataMelt <- melt(fdata, id = c("activity_id", "activity", "subject_id")) # melts data to create a long form
(T) fdataCast <- dcast(fdataMelt, activity_id + activity + subject_id  ~ variable, mean) # creates summary table using mean funciton
(T) write.csv(fdataCast, file = "./UCI HAR Dataset/fdata.csv", row.names = FALSE) # writes the output of summary table onto a file



