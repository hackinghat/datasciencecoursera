accumulate<-function(x, f, mf, r) {
  for (v in x) {
    r<-mf(r, f(v))
  }
  r
}

rankall<-function(outcome, num = "best") {
  outcome_set<-list("heart attack"=11, "heart failure"=17, "pneumonia"=23)
  outcome_index<-outcome_set[[outcome]]
  if (is.null(outcome_index)) {
    stop("invalid outcome")
  }
  outcome<-read.csv("outcome-of-care-measures.csv", colClasses="character")
  outcome_name<-names(outcome)[[outcome_index]]
  # Now subset the outcomes for the required state and outcome
  hospitals <- outcome[outcome[outcome_name] != "Not Available", c("State", "Hospital.Name", outcome_name)]
  if (nrow(hospitals) == 0) {
    stop("invalid state")
  }
  # Assign the 'character' outcome values to numerics
  hospitals[,outcome_name]<-as.numeric(hospitals[,outcome_name])
  hospitals[,"State"]<-as.factor(hospitals[,"State"])
  hospitals_by_state<-split(hospitals, hospitals$State)
  result<-accumulate(hospitals_by_state, function(state) {
    mnemonic<-unique(state$State)
    if (num == "best") index = 1
    else if (num == "worst") index = nrow(state)
    else index = num
    if (index < 1 | index > nrow(state))
      data.frame(hospital=NA, state=mnemonic)
    else {
      state_rank<-state[order(state[,outcome_name], state[,"Hospital.Name"]), c("Hospital.Name", "State")]
      data.frame(hospital=state_rank[[index, "Hospital.Name"]], state=mnemonic)
    }
  }, rbind, data.frame())
  attr(result, "row.names")<-as.character(result$state)
  result
}

