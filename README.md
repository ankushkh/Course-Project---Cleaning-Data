# Course-Project---Cleaning-Data
# Course project submission for module 3 of specialization

The code consists of following steps:

1. Installation of required packages - plyr (using for joining data frames) and rephase2 (used for melt/cast functions)

2. Reading the features and activity tables and changing names to understandable terms

3. Reading the test data and performing following functions:
 a) Renaming column names to those in feastures table
 b) Selecting only those names that have reference to either mean or std
 c) Assigning names to activity id
 d) Assigning unique ids to each table
 d) Merging following three tables: a) measurements (x_test); b) y_test (activity); c) test_subject (subject id)
 e) Once merged table (test_fdata) is formed, remove all other tables to minimize memory use
 
4. Repeat all the steps in #3 for train data
 
5. Merge test and train data into a single table fdata. Once merged remove references to all other tables to minimize more use
 
6. Perform melt and cast operations to:
 a) First create a long form of data table with all the variables in a single column (with corresponding columns in next)
 b) Secondly create a summary table (using mean function) to create a wide form of table summarizing all the variables for each id combination
 
7. Finally write the output of the summary table function 
