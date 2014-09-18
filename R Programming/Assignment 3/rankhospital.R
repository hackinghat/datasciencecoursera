rankhospital<-function(state, outcome, num = "best") {
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
  rank<-if (num == "best") 1 else 
        if (num == "worst") nrow(hospitals) else
	  if (class(num) == "numeric") num 
        else stop("invalid num")
  # We asked for a rank that didn't exist
  if (rank > nrow(hospitals)) 
	NA
  else
	hospitals[order(hospitals[,outcome_name], decreasing=FALSE),c("Hospital.Name",outcome_name)][rank, 1]
}


