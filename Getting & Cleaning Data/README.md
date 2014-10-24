UCI HAR Dataset Extractor
=========================

Author: <steve@hackinghat.com>

Date:   20/10/2014


Introduction
------------
This script reads the raw data from the UCI HAR DataSet (found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and places an object in the R Environment called 'tidy' which contains the mean of a selected set of summarized variables for further analysis.

Contents
--------

In this folder should be the following files

* run_analysis.R    - a script to extract data from the 
* README.md         - this file
* CodeBook.md       - a file describing the data that the run_analysis.R script produces

Using the script
----------------

   1. Unzip the source data set and place the script 'run_analysis.R' in this folder.    
   2. Use R to source the file 
     `> source("./run_analysis.R")`

How the script works
--------------------

The data was originally split, by the authors, into a set of 'test' and 'train' subjects.   Each part of the data is placed
in a separate folder called 'test' and 'train' with the actual readings and the activity under-taken.   

Because this folder layout is regular, the script has a function that is capable of reading into a column vector all the data 
in these files and binding them into a data.frame.

It then proceeds to tidy up the data by:

   * Dropping unwanted variables;
   * Replacing numeric values with factors;
   * Renaming variables to be more regular.

