library(dplyr)
library(XML)
library(data.table)

##Download required data 

# Checking if file already exists.

if(!file.exists("./data")){dir.create("./data")}

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

## Data is read file by file and converted into a single data frame

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"), header = FALSE, sep = ' ')

activity<-read.table("UCI HAR Dataset/activity_labels.txt")

train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

comp_train <-  data.frame(train_subject, train_activity, train_x)
names(comp_train) <- c(c('subject', 'activity'), features)

test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

comp_test <-  data.frame(test_subject, test_activity, test_x)
names(comp_test) <- c(c('subject', 'activity'), features)

#### 1 Merges train and test data 

X<-rbind(test_x, train_x)
Ac <-rbind(test_activity , train_activity)
Subject<-rbind(test_subject, train_activity)

#Dimensions of new datasets
dim(X)
dim(Ac)
dim(Subject)

#Merges the Training and Testing Sets into one data set

comp_dset <- rbind(comp_train, comp_test)

#### 2 Extracts only the mean and standard deviation on each measurement.

Ind<-grep("mean\\(\\)|std\\(\\)", features[,2]) # Indices with mean() and std() in their features
length(Ind) # count of features
X<-X[,Ind] # getting only variables with mean/std.dev
dim(X) # checking dim of subset 

#### 3 Uses descriptive activity names to name the activities in the data set


Ac[,1] <- activity[Ac[,1],2] ## Replacing numeric values with value from activity.txt
head(Ac) 

#### 4 Appropriately labels the data set with descriptive variable names.

  
vrb_names <- features[Ind,2] 

# updating colNames for new dataset

names(X) <- vrb_names 
names(Subject) <- "SubjectID"
names(Ac) <- "Activity"
    
cld_data<-cbind(Subject, Ac, X) # CleanedData
head(cld_data[,c(1:4)]) ## first 5 columns

#### 5 Create a independent tidy data set

cld_data <- data.table(cld_data)
tidy_data <- cld_data[, lapply(.SD, mean), by = 'SubjectID,Activity'] 
dim(tidy_data)

write.table(tidy_data, file = "Tidy.txt", row.names = FALSE)

# first 12 rows and 5 columns in Tidy dataset

head(tidy_data[order(SubjectID)][,c(1:4), with = FALSE],12)