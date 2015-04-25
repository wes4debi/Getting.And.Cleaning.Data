# Getting.And.Cleaning.Data
Repository for Coursera Getting and Cleaning Data Course

The final tidy data set provided by this process allows identification of the
	original group of subjects, the individual subject ID, and the means of the summarized data, with
	tidy labels.  The activities are in English.  The measurement labels are cleaner, but still contain
	references to the original data columns for tracking purposes.  
	
All data for this project was provided from
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, 
	with reference to the original data at 
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .
	
Data descriptions are based on the ReadMe provided within the data zip file.
Please see CodeBook.md for detailed data information.

	
Copy the run_analysis.R script to your working directory.
Download and Install the dplyr R package, version 0.4.1, http://cran.r-project.org/package=dplyr 
Download and Install the stringr R package, version 0.6.2 , http://cran.r-project.org/package=stringr
Download and Install the utils R package, version 2.0.0 , http://cran.r-project.org/package=R.utils

Source run_analysis.R.
If the UCI HAR Dataset directory and files, as originally structured in the zip are in your working directory,
you can run run_analysis() to create the Tidy data set.
If you wish this process to download those files, run start_analysis() The UCI HAR Dataset directory will be 
created and data saved in the correct format in your working directory.

start_analysis()
	requires no parameters
	creates directories and downloads the course data for use in run_analysis()
	calls run_analysis

run_analysis() 
	requires no parameters
	Writes 2 Tidy data sets to the working directory
	The script:
		1. Calls function CheckForFile() to verify that the data files exist in the correct data structure and
		will not continue if the check fails.
		2. Calls function ConnectFiles() to clean and process the data from each of the test and train directories.
		3. Calls function ConvertActivities() to make Activity information more readable.
		4. Writes the tidy1.txt dataset for programmer validation of the process.
		5. Groups the dataset in order to summarize the data at the activity and subject level.
		6. Writes the Final tidy data set with averages of each measure to tidyAverage.txt located
		in your working directory.
		CheckForFile()
			Parameter: Filepath/name from the working directory level.  This is not user customizable.
			Continues if file is found.  Returns and error if file is not found, and stops the process.
		ConnectFiles()
			Parameter: group type, test or train
			Returns a cleaned table data frame
			1. Reads the files based on the parameters
			2. Adds the "activity" and "subject" columns from each independent file.
			3. Reads features for the column labels
			4. Adjusts the column labels to a more readable format for "tidyness"
				a. Changes "-" to "_", 
				b. Removes "()"
				c. Replaces spaces
				d. Prepends the existing column number with the "Col" description.  This allows any
				reader to validate the process back to original data, should they desire.
				e. Drops all unused columns, keeping only mean and standard deviation columns, per the
				assignment.
				f. Appends a subGroup type to track if the data is test or train data for future independent analysis.
		ConvertActivities()
			Parameters: None
			Returns the Tidy data set with the activity numbers replaces with the readable Activity Types
			
		
License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
