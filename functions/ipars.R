# To remove effects on injection

ipars <- function(p, rpars) {
  rmv <- gsub('\\.[rf][012345]$', '', rpars)
  rmp <- substr(rpars, nchar(rpars) - 2, nchar(rpars))
  for (i in 1:length(rpars)) {
    p[paste0(rmv[i], '.app.mthd.inj', rmp[i])] <- - p[rpars[i]]
  }

  return(p)
}

