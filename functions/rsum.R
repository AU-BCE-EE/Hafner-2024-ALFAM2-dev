# Add a row of sums to data frame
# Set vals to NA for those that should not be filled in
# Rows must be integer for now
rsum <- function(x, rows = 1:nrow(x), vals) {
  s <- rep(NA, ncol(x))
  for(i in 1:ncol(x)) { 
    if(class(x[, i]) %in% c('integer', 'numeric')) {
      s[i] <- sum(x[rows, i])
    } else {
      s[i] <- length(unique(x[rows, i]))
    }
  }
  names(s) <- names(x)
  x <- rbind(x, s)
  if(!missing(vals)) x[nrow(x), which(!is.na(vals))] <- vals
  return(x)
}
