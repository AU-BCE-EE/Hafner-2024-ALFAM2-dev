# Function for calculating residuals

resCalc <- function(p, dat, weights = 1, app.name, group = NULL, time.name = 'ct', to = 'j', fixed, method = 'TAE', time.incorp = NULL, flatout = FALSE, prog = TRUE, browseNA = FALSE) {

  #cat(p, '\n')

  if(!all(is.numeric(weights) | length(weights) > 0 | !all(is.na(weights)))) stop('Problem with weights argument.')
  if(!to%in%c('j', 'e', 'e.int', 'er')) stop('to argument must be "j", "e", "er", or "e.int" but is ', to)
  if(any(is.na(weights)) || any(is.null(weights))) stop('weights are NA or NULL')
  if(!missing(fixed)) p <- c(p, fixed)

  obs <- dat[[to]]
  if(length(weights) == 1) weights <- rep(weights, nrow(dat))
  obs[weights == 0] <- NA # To prevent warning on NaNs
  if(any(is.na(obs[weights>0]))) stop('NA values in observations obs, not just where weights = 0.')

  pred <- alfam2(dat, app.name = app.name, time.name = time.name, 
                    time.incorp = time.incorp, group = group, pars = p, flatout = flatout, warn = FALSE)[[to]]

  # Set NA obs to high value for high residual
  pred[is.na(pred)] <- 2
  
  if (method == 'TAE') {
    res <- weights*(pred - obs) 
    res[weights == 0] <- 0 
    if(any(is.na(res))) warning('NA in residuals, see rows ', paste(which(is.na(res)), collapse = ', '), '. ')
    if(any(is.na(res)) && browseNA) browser('NA in residuals')
    res[is.na(res)] <- 0
    obj <- sum(abs(res))
    if (prog) cat(signif(obj, 5), ' ')
    return(obj)
  } else if (method == 'SS') {
    res <- weights * (pred - obs)
    res[weights == 0] <- 0 
    if(any(is.na(res))) warning('NA in residuals, see rows ', paste(which(is.na(res)), collapse = ', '), '. ')
    if(any(is.na(res)) && browseNA) browser('NA in residuals')
    res[is.na(res)] <- 0
    obj <- sum(res^2)
    if (prog) cat(signif(obj, 5), ' ')
    return(obj)
  }
  stop('method must be "TAE" or "SS" but is ', method)
}

