## import files into R

test.files <- list.files("./UCI HAR Dataset/test/", full.names = TRUE)
train.files <- list.files("./UCI HAR Dataset/train/", full.names = TRUE)
test.dat <- read.table(test.files[3])
train.dat <- read.table(train.files[3])
test.ids <- read.table(test.files[2])
train.ids <- read.table(train.files[2])
test.lab <- read.table(test.files[4])
train.lab <- read.table(train.files[4])

### add id and activity columns to data
test.dat$subject_id <- test.ids[, 1]
train.dat$subject_id <- train.ids[, 1]
rm(train.ids, test.ids)

test.dat$activity <- test.lab[,1]
train.dat$activity <- train.lab[,1]
rm(test.lab, train.lab)

#### Merge the training and the test sets into one data set.
dat <- rbind(train.dat, test.dat)
rm(test.dat, train.dat)

#### give variables better names
var.names <- read.table("./UCI HAR Dataset/features.txt", colClasses="character")
names(dat) <- var.names[, 2]
names(dat)[562]  <- "subject_id"
names(dat)[563] <- "activity"
rm(var.names)

#### Extract only the measurements on the mean and standard deviation for each measurement. 

nDat <- dat[, c(grep("mean()", names(dat)), grep("std()", names(dat)))]
nDat$subject_id <- dat$subject_id
nDat$activity <- dat$activity
rm(dat)

#### Use descriptive activity names to name the activities in the data set
activityLabs <- read.table("./UCI HAR Dataset/activity_labels.txt")
library(car)
nDat$activity <- recode(nDat$activity, "1 = 'WALKING'; 2 = 'WALKING_UP'; 3 = 'WALKING_DOWN'; 4 = 'SITTING'; 5 = 'STANDING'; 6 = 'LAYING'", as.factor.result = TRUE)
rm(activityLabs)

### Appropriately label the data set with descriptive variable names.
names(nDat) <- gsub(pattern = "()", replacement = "", names(nDat), fixed = T)
names(nDat) <- gsub(pattern = "-", replacement = ".", names(nDat), fixed = T)

### From the data set in step 4, creates a second, independent tidy data set with 
### the average of each variable for each activity and each subject

library(dplyr)

myDat <- tbl_df(nDat)
rm(nDat)
avgByGrp <- group_by(myDat, subject_id, activity) %>% summarise_each(funs(mean))
rm(myDat)
head(avgByGrp, 5)
write.table(avgByGrp, file="project1_output.txt", row.name=FALSE, col.name=TRUE)
rm(test.files, train.files, avgByGrp)