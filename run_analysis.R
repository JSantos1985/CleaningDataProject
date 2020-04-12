run_analysis <- function (){
  # Dependencies
  library(dplyr)
  library(reshape2)
  
  # Load all the data
  features <- read.table("./UCI HAR Dataset/features.txt")
  activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  # Assigning column names to the datasets
  # THIS IS STEP 4 OF THE ASSIGNMENT
  colnames(x_train) <- features$V2
  colnames(x_test) <- features$V2
  
  # Add the activity column to the datasets, set it to a factor, and add labels based on the activities table
  # THIS IS STEP 3 OF THE ASSIGNMENT
  x_train$activity <- factor(y_train$V1, levels = activities$V1, labels = activities$V2)
  x_test$activity <- factor(y_test$V1, levels = activities$V1, labels = activities$V2)
  
  # Add the subject column to the datasets
  x_train$subject <- subject_train$V1
  x_test$subject <- subject_test$V1
  
  # Merge both training and testing datasets
  # THIS IS STEP 1
  df <- rbind(x_train, x_test)
  
  # Removes duped column names. We don't need those variables and they prevent dplyr.select from working
  df <- df[!duplicated(names(df))]

  # Get only columns with means and standard deviations. Also include activity and subject which we'll need after
  # THIS IS STEP 2
  df <- select(df, contains("mean()") | contains("std()") | "subject" | "activity")
  
  # We're using melt to transpose activity and subject, and then dcasting to arrange the df into the long format
  # THIS IS STEP 5
  melted <- melt(df, id.vars=(c("activity", "subject")))
  df2 <- dcast(melted, activity + subject ~ variable, mean)
  
  write.table(df2, "output.txt", row.names=F, quote=F)
}