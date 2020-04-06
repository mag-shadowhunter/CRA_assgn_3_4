The file run_analysis.R is a script that performs data preparation and the 5 steps as described in the course project’s reqirement.
  
  1.	Download the required dataset
        o	Dataset downloaded and extracted under the folder called UCI HAR Dataset
        
  2.	Assign each data to variables
  
        o	features <- features.txt 
            The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
        o	activity <- activity_labels.txt 
            List of activities performed when the corresponding measurements were taken and its codes (labels)
        o	train_x <- test/X_train.txt 
            contains recorded features train data
        o	train_activity <- test/y_train.txt 
            contains train data of activities’code labels
        o	train_subject <- test/subject_train.txt 
            contains train data of 21/30 volunteer subjects being observed
        o	test_x <- test/X_test.txt 
            contains recorded features test data
        o	test_activity <- test/y_test.txt
            contains test data of activities’code labels
        o	test_subject <- test/subject_test.txt
            contains test data of 9/30 volunteer test subjects being observed

        
3.	Merges the training and the test sets to create one data set

        o	X is created by merging x_train and x_test using rbind() function
        o	Ac is created by merging y_train and y_test using rbind() function
        o	Subject is created by merging subject_train and subject_test using rbind() function
        o	comp_dset is created by merging Subject, Ac and X of train and test parameters by comp_train, comp_test using rbind() function

4.	Extracts only the measurements on the mean and standard deviation for each measurement
        o	TidyData is created by subsetting the merged data, selecting only columns (i.e.,) subject, code and the measurements on the mean and standard deviation (std) for each measurement

5.	Uses descriptive activity names to name the activities in the data set
        o	Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable

6.	Labels the data set with descriptive variable names
        o	Updated column names for new dataset


7.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject
        o	Cleaned data (cld_data) is created by sumarizing TidyData after being groupped by subject and activity.
        o	Export Tidy Data into Tidy.txt file.
