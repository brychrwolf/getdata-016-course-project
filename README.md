getdata-016-course-project
==========================
To obtain the data in *set_5_tidy_data.txt*, run_analysis.R can be sourced.
It does the following steps, assuming that the original data are in the working directory:

1. Merges the training and the test sets to create one data set.

  1. Read in tables
  1. Bind the test and train data together
  1. Bind all columns into one table

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

  2. Make vector of column indices for all measurements from X that end with mean() or std() according to features.txt
  2. Subset the subject, labels, and only those extracted means_and_stds_rows columns

3. Uses descriptive activity names to name the activities in the data set

  3. Vectorize the names from features.txt which match means_and_stds_rows
  3. Attach the names for the subject, activity labels, and measurements

4. Appropriately labels the data set with descriptive variable names. 

  4. Update the Activity column with a logical vector created for each labels found in activity_labels.txt

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  5. Get vector of unique values of subjects and activities
  5. Create a vector which can uniquely identify each permutation of subject and activity
  5. Populate new data.frame
  
      5. with columns for each of the Subject and Activity permutations
      5. with columns for each measurement average
	  
  5. add user-friendly names to the data frame



































