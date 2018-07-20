## Data Source
The database was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.  Accelerometer readings from the Samsung Galaxy S smartphone was used to record the data.

The data was originally sourced from ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  

Research is credited to : Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2). 1 - Smartlab - Non-Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain activityrecognition '@' smartlab.ws



## Introduction
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.



## Data and Variables
The dataset was extracted from a zipped file from UCI HAR.  Information about the features is detailed in features_info.txt. Analysis was performed on the following files.

|Filename           |Description  |
|:---|:---|
|features.txt       |feature id and description of each of 561 signals measured |
|activity_labels.txt|activity id and description of each of 6 activities |
|X_train.txt        |561 signals measured for each of 7352 observations in the training set|
|y_train.txt        |activity id of each of 7352 observations in the training set|
|subject_train.txt  |subject id of participant of each of 7352 observations in the training set |
|X_test.txt         |561 signals measured for each of 2947 observations in the test set|
|y_test.txt         |activity id of each of 2947 observations in the test set|
|subject_test.txt   |subject id of participant of each of 2947 observations in the test set |

The analysis did not use the raw signal data contained in the "Inertial Signals" folder.



## Processing steps
1. Reading files into data frames
   * Data from lookup files read into ``feature`` and ``activity``. 
   * Data from training and test files in that order read and merged into a single data set for each of ``subject``, ``label`` and ``signals``. There was no missing or NA data in any of the observations.  
2. Add appropriate header names
   * Header names ``id`` and ``desc`` assigned to data frames for ``feature`` and ``activity``.
   * Header name ``id`` assigned to data frames for ``subject`` and ``label``.
   * Header names for ``signals`` assigned via lookup to ``feature`` description.
3. Manipulating the data
   * Descriptive data from ``activity`` was added via lookup of the ``id`` of ``labels`` data frame.
   * List of ``feature`` descriptions that contained the exact strings "mean" or "std" in ``feature`` was extracted into ``useSignal``.
   * ``tidyData`` subset merges the subject, activity and mean and std dev signal for all observations.  
4. Calculate mean for subset of data
   * ``results`` summary of averages of all observations for each signal was calculated for each activity and each subject.
5. Write data frame to output file ``results.txt``.
