## This R program was created to fulfil the requirements for the Course Project for the
## Johns Hopkins University Coursera "Getting and Cleaning Data" Course in the
## Data Science Specialization.
##
## Author: Debra Wells
## Created: April, 2015
## Data supplied via the Assignment Notes.  Please see the ReadMe and CodeBook supplied in the repo for additional
## details.
##
## Data must be referenced in the Working Directory, structured, and named exactly as originally supplied
## for the course.  Any discrepancies will call an error.
## 
## The main code in this file will create the Tidy data set, as referenced in the Assignment, as well as the second
## dependent Tidy data set created for upload.  Further comments and descriptions are included in the code.
##
## To run this code:
## 1. Set your working directory to the location of the "data, so that the ICI Har Dataset is in the
##      Working Directory.
## 2. source(./run_analysis.R)
## 3. run_analysis()
## As an alternative, if you don't already have the data the following function will bring it download
## then run_analysis for you
## start_analysis()

start_analysis<- function (){
    library("dplyr")
    library("stringr")
    library("utils")
    temp <- tempfile()
    
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
    
    unzip(temp)
    
    unlink(temp)
    run_analysis()
}


run_analysis <- function () {
#    setwd( "C:/Users/Deb/Documents/Coursera/Tidy/UCI_HAR_Dataset")
    library("dplyr")
    library("stringr")
    library("utils")
## This R program was created to fulfill the requirements for the Course Project for the
## Johns Hopkins University Coursera "Getting and Cleaning Data" Course in the
## Data Science Specialization.
##
## Author: Debra Wells
## Created: April, 2015
## Data supplied via the Assignment Notes.  Please see the ReadMe and CodeBook supplied in the repo for additional
## details.
##
## Data must be referenced in the Working Directory, structured, and named exactly as originally supplied
## for the course.  Any discripancies will call an error.
## 
## The main code in this file will create the Tidy data set, as referenced in the Assignment, as well as the second
## dependent Tidy data set created for upload.  Further comments and descriptions are included in the code.
##
## To run this code:
## 1. Set your working directory to the location of the "data, so that the "test" and "train" directories are in the
##      Working Directory.
## 2. source(./run_analysis.R)
## 3. submit()
## 
## First verify that all of the files exist in the correct locations and exit with a message if they are not found.
    message("Verifying file loads")
    CheckForFile("UCI HAR Dataset/features.txt")
    CheckForFile("UCI HAR Dataset/activity_labels.txt")
    CheckForFile("UCI HAR Dataset/test/subject_test.txt")
    CheckForFile("UCI HAR Dataset/test/X_test.txt")
    CheckForFile("UCI HAR Dataset/test/y_test.txt")
    CheckForFile("UCI HAR Dataset/train/subject_train.txt")
    CheckForFile("UCI HAR Dataset/train/X_train.txt")
    CheckForFile("UCI HAR Dataset/train/y_train.txt")
    

    testGrouptbl <- ConnectFiles("test")
    trainGrouptbl <-ConnectFiles("train")
    TidySet<-rbind(testGrouptbl,trainGrouptbl)
    
    ## cleanup
    rm(testGrouptbl)
    rm(trainGrouptbl)

    ## Convert the Activities
    answer<-ConvertActivities(TidySet)   
    write.table(answer,"tidy1.txt",row.name=FALSE)
    ## get the averages for second Tidy Data Set
    message("building and writing the final Tidy Dataset")
    Tidyset2<- group_by(answer,activityType,subject,subGroup)
    #summarize to get the averages (means)
#         suppressWarnings(Tidyset2<- summarize(Tidyset2,mean(col1_tBodyAcc_mean_X:col543_fBodyBodyGyroJerkMag_std)))
        Tidyset2<- summarize(Tidyset2,mean(col1_tBodyAcc_mean_X),    mean(col2_tBodyAcc_mean_Y),	mean(col3_tBodyAcc_mean_Z),
                mean(col41_tGravityAcc_mean_X),	mean(col42_tGravityAcc_mean_Y),	mean(col43_tGravityAcc_mean_Z),	
                mean(col81_tBodyAccJerk_mean_X),	mean(col82_tBodyAccJerk_mean_Y),	mean(col83_tBodyAccJerk_mean_Z),	
                mean(col121_tBodyGyro_mean_X),	mean(col122_tBodyGyro_mean_Y),	mean(col123_tBodyGyro_mean_Z),	
                mean(col161_tBodyGyroJerk_mean_X),	mean(col162_tBodyGyroJerk_mean_Y),	mean(col163_tBodyGyroJerk_mean_Z),	
                mean(col201_tBodyAccMag_mean),	mean(col214_tGravityAccMag_mean),	mean(col227_tBodyAccJerkMag_mean),	
                mean(col240_tBodyGyroMag_mean),	mean(col253_tBodyGyroJerkMag_mean),	mean(col266_fBodyAcc_mean_X),	
                mean(col267_fBodyAcc_mean_Y),	mean(col268_fBodyAcc_mean_Z),	mean(col345_fBodyAccJerk_mean_X),	
                mean(col346_fBodyAccJerk_mean_Y),	mean(col347_fBodyAccJerk_mean_Z),	mean(col424_fBodyGyro_mean_X),
                mean(col425_fBodyGyro_mean_Y),	mean(col426_fBodyGyro_mean_Z),	mean(col503_fBodyAccMag_mean),	
                mean(col516_fBodyBodyAccJerkMag_mean),	mean(col529_fBodyBodyGyroMag_mean),	
                mean(col542_fBodyBodyGyroJerkMag_mean),	mean(col4_tBodyAcc_std_X),	
                mean(col5_tBodyAcc_std_Y),	mean(col6_tBodyAcc_std_Z),	mean(col44_tGravityAcc_std_X),	
                mean(col45_tGravityAcc_std_Y),	mean(col46_tGravityAcc_std_Z),	mean(col84_tBodyAccJerk_std_X),	
                mean(col85_tBodyAccJerk_std_Y),	mean(col86_tBodyAccJerk_std_Z),	mean(col124_tBodyGyro_std_X),
                mean(col125_tBodyGyro_std_Y),	mean(col126_tBodyGyro_std_Z),	mean(col164_tBodyGyroJerk_std_X),
                mean(col165_tBodyGyroJerk_std_Y),	mean(col166_tBodyGyroJerk_std_Z),	mean(col202_tBodyAccMag_std),	
                mean(col215_tGravityAccMag_std),	mean(col228_tBodyAccJerkMag_std),	mean(col241_tBodyGyroMag_std),	
                mean(col254_tBodyGyroJerkMag_std),	mean(col269_fBodyAcc_std_X),	mean(col270_fBodyAcc_std_Y),	
                mean(col271_fBodyAcc_std_Z),	mean(col348_fBodyAccJerk_std_X),	mean(col349_fBodyAccJerk_std_Y),
                mean(col350_fBodyAccJerk_std_Z),	mean(col427_fBodyGyro_std_X),	mean(col428_fBodyGyro_std_Y),
                mean(col429_fBodyGyro_std_Z),	mean(col504_fBodyAccMag_std),	mean(col517_fBodyBodyAccJerkMag_std),
                mean(col530_fBodyBodyGyroMag_std),	mean(col543_fBodyBodyGyroJerkMag_std)
)
    names(Tidyset2)<-str_replace_all(names(Tidyset2),"mean\\(", "avg_")
    names(Tidyset2)<-str_replace_all(names(Tidyset2),"\\)", "")
  
    write.table(Tidyset2,"tidyAverage.txt",row.name=FALSE)
    message("Process Complete.  Look for the tidyAverage.txt data set in your working directory.")
}
##
## The CheckForFile Function takes a file name passed in from the call, and verifies existance.  If the exact file
## name and location does not exist, a STOP error is thrown to stop the process with explanation.

CheckForFile <- function (fileName="FileNotFound") {
    
    filePath <- paste("./", fileName,sep="")
    stopMessage <- paste("File ", fileName, " is not in your working directory: ", getwd(),  
                         ".  Run start_analysis() to download the data as needed, or update your working directory.", sep="")
    if(!file.exists(filePath)) {
         stop(stopMessage)
    }  
} 
#
## The ConnectFiles function will take 3 data files from the test and train directories, 
## and connect them together into a single data set

ConnectFiles <- function (location = "test") {
    # test and train are subdirectories of the working directory.  We need to find them based on the location input.
    dataPath <- paste("./UCI HAR Dataset/", location, "/X_", location, ".txt", sep="")
    activityPath <- paste("./UCI HAR Dataset/", location, "/y_", location, ".txt", sep="")
#    message(activityPath)
    subjectPath <- paste("./UCI HAR Dataset/", location, "/subject_", location, ".txt", sep="")
    message(paste("Reading stored data files for",location,"location" ))
    # Open the data files as a data frame, and covert activity and subject to vectors for binding
    activity <- read.table(activityPath)[,1]
    subject <- read.table(subjectPath)[,1]
    df_data <- read.table(dataPath)
    
    df_data<-cbind( activity, df_data)
    df_data<-cbind(subject, df_data)
    
    # Open the headers supplied in features.txt and prepend headers for activity and subject
    #open a connection to get the headers
    con<-file("./UCI HAR Dataset/features.txt")
    features<-readLines(con)
    close(con)
    ## Create the headers vector by and start the cleanup by changing - to _.  We cannot remove numbers from the
    ## original set because that creates duplicate column names.
    getHeaders <- c("subject", "activity",str_replace_all(features,"-","_"))
    ## remove pararenthesis
    getHeaders <- str_replace_all(getHeaders,"\\(\\)","")
    ##convert space
    getHeaders <- str_replace_all(getHeaders," ", "_")
    ## Set the columns names
    names(df_data)<-str_c("col",getHeaders,sep="")
    ## Convert to TBL_df for ease of print, and select only 
    ## means and standard deviation columns to limit df size before returning.
    dfmean<-select(df_data,contains("_mean"))
    dfstd<-select(df_data,contains("_std"))
    ## cleanup
    rm(df_data)
    ## recombine
    df_data<-cbind(activity,subject,dfmean,dfstd)
    df_data<-select(df_data,-contains("meanFreq"))
    ##add subGroup(test or train) to track subject group 
    df_data<-mutate(df_data,subGroup=location)
    
    ## convert for print    
    tbl_df_data <-tbl_df(df_data)
    return(tbl_df_data)
  # head(df_data)
}
## ConvertActivities takes the incoming tbl_df and joins to the label names, to make the data more readable
    ConvertActivities<- function (Tidydata){
        activity <-read.table("./UCI HAR Dataset/activity_labels.txt")
        Act_Tidy<- Tidydata %>% 
            inner_join(activity, by=c("activity"="V1")) %>% 
            select(-activity) %>% 
            rename(activityType=V2)
        
        return(Act_Tidy)
    }