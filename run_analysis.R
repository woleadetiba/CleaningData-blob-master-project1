library(chron)
install.packages("dyplr")
library(dyplr)


if (!file.exists("data")) {
  print("Creating data directory.")
  dir.create("data")
}

# Data from the UC Irvine Machine Learning Repository. In particular, the
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipRL <- "./data/UCI-HAR-Dataset.zip"
# Only download the data if we don't already have it.
if (!file.exists(zipRL) & !file.exists(fileRL)) {
  download.file(dataURL, destfile=zipRL, method="curl")
} else {
  print("Data already exists. Skipping fetch from internet.")
}
# Unzip the data if we haven't already.
fileRL <- "./data/UCI HAR Dataset/README.txt"
if (!file.exists(fileRL)) {
  unzip(zipRL, exdir="./data/.")
} else {
  print("Data already unzipped.")
}



x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X <- rbind(x_train, x_test)


subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
S <- rbind(subject_train, subject_test)

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
Y <- rbind(y_train, y_test)

# 2. Extracts only the mean and standard deviation
#Need more work from me
features <- read.table("./data/UCI HAR Dataset/features.txt")
X <- X[, grep("-mean\\(\\)|-std\\(\\)", features[, 2])]
names(X) <- features[indices_of_good_features, 2]

#remove "|" from the table labels, then convert them to lower case
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. get the activity from and use that to label the data set
# Remove the "_" from the labels

activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. column bind all the data
names(S) <- "subject"
merged_and_cleaned <- cbind(S, Y, X)
write.table(merged_and_cleaned, "merged_and_cleaned.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

#Get the unique activity and subjects
activities = unique(merged_and_cleaned$activity)
subjects = unique(merged_and_cleaned$subject)

#Temporarily intial result_with_mean from merged_and_cleaned 
result_with_mean = merged_and_cleaned[1:(length(subjects)*length(activities)), ]
numCols = dim(merged_and_cleaned)[2]
row = 1
for (i in subjects){ 
  result_with_mean[row, 1] = i
  for (j in activities){ 
    activity_by_sub = filter(filter(merged_and_cleaned, subject==i), activity==j);
    result_with_mean[row, 2] = j
    result_with_mean[row, 3:numCols] <- colMeans(activity_by_sub[, 3:numCols])
  }
  row = row+1
}

write.table(result_with_mean, "data_set_with_the_averages.txt")
