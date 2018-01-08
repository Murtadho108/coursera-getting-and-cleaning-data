# **Code Book**
# **Getting aand Cleaning Data Project**

## The Files
  
   * activity_labels.txt: Names and IDs for each of the activities
   * features.txt: Names of the 561 features
   * X_train.txt: 7352 observations of the 561 features
   * y_train.txt: A vector of 7352 integers, related to each of the observations in X_train.txt
   * subject_train.txt: A vector of 7352 integers, related to each of the observations in X_train.txt.
   * X_test.txt: 2947 observations of the 561 features
   * y_test.txt: A vector of 2947 integers, drelated to each of the observations in X_test.txt
   * subject_test.txt: A vector of 2947 integers, related to each of the observations in X_test.txt
  
  ## Processing Steps
  1. Read the data test and training into data frame
  2. combine the respective data in training and test data sets corresponding to subject, activity and features, add name
     column, and merge the data in to one set data
  3. Extract the column indices that have either mean or std in them
  4. A tidy data set was created containing the mean of each feature for each subject and each activity
  5. The tidy data set was output to a [tidy.txt](https://github.com/Murtadho108/coursera-getting-and-cleaning-data/blob/master/tidy.txt)        file
