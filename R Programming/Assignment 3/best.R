
best<-function (state, outcome) {
  outcome_set<-list("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  outcome_index<-outcome_set[[outcome]]
  if (is.null(outcome_index)) {
    stop("invalid outcome")
  }
  outcome<-read.csv("outcome-of-care-measures.csv", colClasses="character")
  outcome_name<-names(outcome)[[outcome_index]]
  # Now subset the outcomes for the required state and outcome
  hospitals <- outcome[outcome["State"] == state & outcome[outcome_name] != "Not Available", c("Hospital.Name", outcome_name)]
  if (nrow(hospitals) == 0) {
    stop("invalid state")
  }
  # Assign the 'character' outcome values to numerics
  hospitals[,outcome_name]<-as.numeric(hospitals[,outcome_name])
  hospitals[order(hospitals[,outcome_name], decreasing=FALSE),c("Hospital.Name",outcome_name)]
}