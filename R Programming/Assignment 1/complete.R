complete <- function(directory, id = 1:332) {
  makepath <- function(x) { 
    sprintf("%s/%03d.csv", directory, x) 
  }
  countobs <- function(f) {
    sum(apply(vapply(f, function (x) { !is.na(x)  }, logical(nrow(f))), 1, prod))
  }
  monitors <- lapply(vapply(id, makepath, character(1)), read.csv)
  data.frame(id = id, nobs = vapply(monitors, countobs, numeric(length(1))))
}