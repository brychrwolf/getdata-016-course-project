# 1. Merges the training and the test sets to create one data set.
# 1.a. Read in tables
X_test <- read.table('X_test.txt')
X_train <- read.table('X_train.txt')
y_test <- read.table('y_test.txt')
y_train <- read.table('y_train.txt')
subject_test <- read.table('subject_test.txt')
subject_train <- read.table('subject_train.txt')
# 1.b. Bind the test and train data together
X <- rbind(X_test, X_train)
y <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
# 1.c. Bind all cols into one table
data <- cbind(subject, y, X)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 2.a. Make vector of column indices for all measurements from X that end with mean() or std() according to features.txt
means_and_stds_rows <- c(
	1:6, 
	41:46, 
	81:86, 
	121:126, 
	161:166, 
	201, 202, 
	214, 215, 
	227, 228, 
	240, 241, 
	253, 254, 
	266:271, 
	345:350, 
	424:429, 
	503, 504, 
	516, 517, 
	529, 530, 
	542, 543)
# 2.b. Subset the subject, labels, and only those extracted means_and_stds_rows columns
#   note: ssData stands for "subset of data"
#	note: the +2 is to account for the cbind that was performed in step 1.c.
ssData <- data[, c(1, 2, means_and_stds_rows+2)] 

# 3. Uses descriptive activity names to name the activities in the data set
# 3.a. Vectorize the names from features.txt which match means_and_stds_rows
means_and_stds_names <- c(
	'tBodyAcc-mean()-X', 'tBodyAcc-mean()-Y', 'tBodyAcc-mean()-Z',
	'tBodyAcc-std()-X', 'tBodyAcc-std()-Y', 'tBodyAcc-std()-Z',
	'tGravityAcc-mean()-X', 'tGravityAcc-mean()-Y', 'tGravityAcc-mean()-Z',
	'tGravityAcc-std()-X', 'tGravityAcc-std()-Y', 'tGravityAcc-std()-Z',
	'tBodyAccJerk-mean()-X', 'tBodyAccJerk-mean()-Y', 'tBodyAccJerk-mean()-Z',
	'tBodyAccJerk-std()-X', 'tBodyAccJerk-std()-Y', 'tBodyAccJerk-std()-Z',
	'tBodyGyro-mean()-X', 'tBodyGyro-mean()-Y', 'tBodyGyro-mean()-Z',
	'tBodyGyro-std()-X', 'tBodyGyro-std()-Y', 'tBodyGyro-std()-Z',
	'tBodyGyroJerk-mean()-X', 'tBodyGyroJerk-mean()-Y', 'tBodyGyroJerk-mean()-Z',
	'tBodyGyroJerk-std()-X', 'tBodyGyroJerk-std()-Y', 'tBodyGyroJerk-std()-Z',
	'tBodyAccMag-mean()', 'tBodyAccMag-std()',
	'tGravityAccMag-mean()', 'tGravityAccMag-std()',
	'tBodyAccJerkMag-mean()', 'tBodyAccJerkMag-std()',
	'tBodyGyroMag-mean()', 'tBodyGyroMag-std()',
	'tBodyGyroJerkMag-mean()', 'tBodyGyroJerkMag-std()',
	'fBodyAcc-mean()-X', 'fBodyAcc-mean()-Y', 'fBodyAcc-mean()-Z', 
	'fBodyAcc-std()-X', 'fBodyAcc-std()-Y', 'fBodyAcc-std()-Z',
	'fBodyAccJerk-mean()-X', 'fBodyAccJerk-mean()-Y', 'fBodyAccJerk-mean()-Z',
	'fBodyAccJerk-std()-X', 'fBodyAccJerk-std()-Y', 'fBodyAccJerk-std()-Z',
	'fBodyGyro-mean()-X', 'fBodyGyro-mean()-Y', 'fBodyGyro-mean()-Z',
	'fBodyGyro-std()-X', 'fBodyGyro-std()-Y', 'fBodyGyro-std()-Z',
	'fBodyAccMag-mean()', 'fBodyAccMag-std()',
	'fBodyBodyAccJerkMag-mean()', 'fBodyBodyAccJerkMag-std()',
	'fBodyBodyGyroMag-mean()', 'fBodyBodyGyroMag-std()',
	'fBodyBodyGyroJerkMag-mean()', 'fBodyBodyGyroJerkMag-std()')
# 3.b. Attach the names for the subject, activity labels, and measurements
names(ssData) <- c('Subject', 'Activity', means_and_stds_names)

# 4. Appropriately labels the data set with descriptive variable names. 
# 4.a. Update the Activity column with a logical vector created for each labels found in activity_labels.txt
ssData$Activity[ssData['Activity'] == 1] <- 'Walking'
ssData$Activity[ssData['Activity'] == 2] <- 'WALKING_UPSTAIRS'
ssData$Activity[ssData['Activity'] == 3] <- 'WALKING_DOWNSTAIRS'
ssData$Activity[ssData['Activity'] == 4] <- 'SITTING'
ssData$Activity[ssData['Activity'] == 5] <- 'STANDING'
ssData$Activity[ssData['Activity'] == 6] <- 'LAYING'

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 5.a. Get vector of unique values of subjects and activities
subs <- unique(ssData[, 1]) # Subjects
acts <- unique(ssData[, 2]) # Activities
# 5.b. Create a vector which can uniquely identify each permutation of subject and activity
perm_inc <- 1 #increment for permutations of subject/activity
perm_vect <- numeric(length(subs) * length(acts)) # a blank numeric vector of the correct length
for(s in subs){
	for(a in acts){
		# Create logical vector of ssData rows for this permutation, 
		want <- ssData["Subject"] == s & ssData["Activity"] == a 
		perm_vect[want] <- perm_inc
		perm_inc <- perm_inc + 1
	}
}
# 5.c. Populate new data.frame
# 5.c.i with columns for each of the Subject and Activity permutations
avg_by_subjectActivty <- data.frame(expand.grid(subs, acts))
# 5.c.ii with columns for each measurement average
for(n in means_and_stds_names){
	avg_by_subjectActivty <- cbind(avg_by_subjectActivty, tapply(ssData[[n]], perm_vect, mean))
}
# 5.c.iii add user-friendly names to the data table
names(avg_by_subjectActivty) <- c('Subject', 'Activity', paste("AVG", means_and_stds_names, sep="_"))

avg_by_subjectActivty



































