The script has the following dependencies:
dplyr
reshape2

Note that the assignment steps were done out of order. I find this to be simpler since when we merged the dataset,
everything is ready to go. Otherwise, we'd have to cross-reference indices from the key tables or merge those as well adding overhead
to the script.

The script operates in the following manner:

1. Loads all the .txt files from the UCI Har Dataset.

2. Assings column names to the training and testing dataset, based on the features table (STEP 4 OF THE ASSIGNMENT).

3. Adds an "activity" column to the datasets, set as factor, and adds labels based on the activities table (STEP 3 OF THE ASSIGNMENT.

4. Adds the subject column to the datasets, based on the subject IDs on the subjects tables.

5. Merges both the training and testing datasets (STEP 1 OF THE ASSIGNMENT).

6. Removes duped column names, otherwise we cannot use select(). We don't need that data anyway.

7. Filter columns, selecting only column names which contain the string "mean()" OR "std()" OR "subject", OR "activity". (STEP 2 OF THE ASSIGNMENT)

8. Use melt() to transpose activity and subject, and then dcast() to rearrange the data in the long format. (THIS IS STEP 5 OF THE ASSIGNMENT)

All done!