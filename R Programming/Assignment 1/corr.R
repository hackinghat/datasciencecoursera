source("complete.R")
corr <- function(directory, threshold = 0) {
  all_monitors<-vapply(dir(directory), function(x) { as.numeric(substr(x, 1, 3)) }, numeric(1))
  valid<-complete(directory, all_monitors)
  id<-valid$id[valid$nobs>=threshold]
  
  makepath <- function(x) { 
    sprintf("%s/%03d.csv", directory, x) 
  }
  monitors<-lapply(vapply(id, makepath, character(1)), read.csv)
  data <- lapply(monitors, function(s) { subset(s, !is.na(sulfate) & !is.na(nitrate)) })
  reading_matrix <-lapply(data, function(x) { x[c("sulfate", "nitrate")] } )
  sapply(reading_matrix, function(x) { cor(x$sulfate, x$nitrate) })
}