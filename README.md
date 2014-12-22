GettingAndCleaningData_project
==============================
#### Short description of "run_analysis.r"

The `"run_analysis.r"` script calculates averages by subject id and activity for the mean and standard deviation (std) variables from the "Human Activity Recognition Using Smartphones Dataset" (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The data is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and should be unpacked into the working directory before the `"run_analysis.r"` script is run. 

The data is in the **UCI HAR Dataset** folder which contains the following files:

        * test folder - containing data files for test sample
        * train folder - containing data files for training sample
        * features_info.txt - containing descriptions of variables
        * README.txt - containing description of the experiment, as well as, description of                
        each data file and the variables (refered to as the "features" in the original files)
        * features.txt - containing the names of variables
        * activity_labels.txt - containing definitions of each of the 6 actvity levels


#### Requirements: 
        
        - folder **"UCI HAR Dataset"** containing the original data files and the "run_analysis
        .r" script need to be in the working directory. 
        - the script requires two R packages: **"car"** and **"dplyr"**


#### script outline

After sourcing the `run_analysis.r` script does the following:

1. Imports pre-processed data for the training and test samples into R. There are 3 pre-processed data files for both the training and the test samples:
        
        * y_test.txt/y_train.txt - contain activity labels for each observation
        * X_test.txt/X_train.txt - contain a set of measurements on 561 variables
        * subject_test.txt/subject_train.txt - contain a vector of subject identifiers for
        each observation
        
2. Imports two additional files into R:

        * features.txt - contains variables names
        * activity_lables.txt - contains full names for each of the 6 activities evaluated
        
3. Adds `subject_id` and `activity` columns to the train and test datasets. The `subject_id` column for the test and train data frames are generated from the `subject_test.txt` and `subject_train.txt` files, respectively. The `activity` columns for the test and train data frames are generated from the `y_test.txt` and `y_train.txt`, respectively. 

4. Merges the train and test data sets into one data frame

5. Assigns variable names as defined in the feature.txt file. 

6. Extracts only variables that represent the means or standard deviations of the measurements as indicated by the presence of "mean" or "std" in the variable name.

7. Changes the numeric activity labels (1 to 6) to descriptive names (such as "walking" or "running") using the `activity_labels.txt` file. 

9. Uses the subset data set containing the mean and std variables to calculate the average of each variable for each activity and each subject. Then saves the resultant by subject and group averages into a text file called `project1_output.txt`within the working directory. This new data frame contains the mean for each of the 79 mean/std variables for each of the 30 subjects and each of the 6 activities. 

