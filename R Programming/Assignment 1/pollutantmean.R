pollutantmean <- function(directory, pollutant, id = 1:332) {
  makepath <- function(x) { 
    sprintf("%s/%03d.csv", directory, x) 
  }
  files  <- vapply(id, makepath, character(1))
  result <- numeric();
  for (monitor in lapply(files, read.csv)) {
    result <- c(result, monitor[[pollutant]]);
  }
  mean(result, na.rm=TRUE)
}