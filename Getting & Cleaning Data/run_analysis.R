# Read a folder of the form 
#
#     |- <folder> -- |-- X_<folder>.txt
#     |              |-- y_<folder>.text
#                    --- subject_<folder>.txt
# 
#  Into a data.frame of the form:
#    
#     subject y 
readfolder<-function(folder, nrows, features) {
  vars<-list("subject", "y", "X")
  result<-do.call(cbind, lapply (vars, function(file) {
    read.table(file.path(folder, paste(file, "_", folder, ".txt", sep="")), sep="", comment.char="")
  }))
  # Add the column names back
  names(result)<-append(vars[1:2], features)
  result
}

# Read the 'features' set, leaving them as strings
features<-read.table("features.txt", header=FALSE, sep="", row.names=1, col.names=c("id", "feature"), stringsAsFactors=FALSE)

# Merge the test and training data sets 
merged<-rbind(readfolder("test", 2947, features$feature), readfolder("train", 7352, features$feature))

# Determine which columns are the 'mean' and 'std' ones that we require
meanAndStd<-features$feature[grep("(mean|std)\\(\\)", features$feature)]

# Drop all the not required columns leaving the subject, activity and mean/std-deviation columns
tidy<-merged[,append(c("subject", "y"), meanAndStd)]
names(tidy)<-sub("\\(\\)", "", tolower(names(tidy)))
rm("merged")

# Read the activity labels
activities<-read.table("activity_labels.txt", header=FALSE, sep="", row.names=1, col.names=c("id", "y"))
activities$y<-as.factor(sub("_", "", tolower(activities$y)))

# Replace the 'y' column with the activity labels
tidy$y<-activities[tidy$y,]

# Now aggregate the mean/std-deviations by the subject and activity
tidy<-aggregate(tidy[,-c(1:2)], by=list(subject=tidy$subject, activity=tidy$y),  FUN=mean)


