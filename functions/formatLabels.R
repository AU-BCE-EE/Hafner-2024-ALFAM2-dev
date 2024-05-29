formatLabels <- function(x) {
 # Identify the first and last label positions
 first <- x[1]
 last <- x[length(x)]
  
 # Format the labels
 formatted_labels <- sapply(x, function(value) {
  # Check if the value is the first or last
  if (value == first || value == last) {
   # Round to desired number of decimals for first and last labels
   return(formatC(value, format = "f", digits = 1))
  } else {
   # Leave other labels unchanged
   return(value)
  }
 })
  
 return(formatted_labels)
}
