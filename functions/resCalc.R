# Functions for calculating residuals

# Basic version, one response variable
resCalc <- function(p, dat, weights = 1, app.name, group = NULL, time.name = 'ct', to = 'j', fixed, method = 'TAE', time.incorp = NULL, flatout = FALSE, prog = TRUE, browseNA = FALSE, rminj = NULL) {

  if (!all(is.numeric(weights) | length(weights) > 0 | !all(is.na(weights)))) stop('Problem with weights argument.')
  if (!to%in%c('j', 'e', 'e.int', 'er')) stop('to argument must be "j", "e", "er", or "e.int" but is ', to)
  if (any(is.na(weights)) || any(is.null(weights))) stop('weights are NA or NULL')
  if (!missing(fixed)) p <- c(p, fixed)

  # Cancel some pars for injection
  if (!is.null(rminj)) {
    p <- ipars(p, rminj)
  }

  obs <- dat[[to]]
  if (length(weights) == 1) weights <- rep(weights, nrow(dat))
  obs[weights == 0] <- NA # To prevent warning on NaNs
  if (any(is.na(obs[weights>0]))) stop('NA values in observations obs, not just where weights = 0.')

  pred <- alfam2(dat, pars = p, app.name = app.name, time.name = time.name, 
                    time.incorp = time.incorp, group = group, flatout = flatout, warn = FALSE)[[to]]

  # Set NA obs to high value for high residual
  pred[is.na(pred)] <- 2
  
  if (method == 'TAE') {
    res <- weights*(pred - obs) 
    res[weights == 0] <- 0 
    if (any(is.na(res))) warning('NA in residuals, see rows ', paste(which(is.na(res)), collapse = ', '), '. ')
    if (any(is.na(res)) && browseNA) browser('NA in residuals')
    res[is.na(res)] <- 0
    obj <- sum(abs(res))
    if (prog) cat(signif(obj, 5), ' ')
    return(obj)
  } else if (method == 'SS') {
    res <- weights * (pred - obs)
    res[weights == 0] <- 0 
    if (any(is.na(res))) warning('NA in residuals, see rows ', paste(which(is.na(res)), collapse = ', '), '. ')
    if (any(is.na(res)) && browseNA) browser('NA in residuals')
    res[is.na(res)] <- 0
    obj <- sum(res^2)
    if (prog) cat(signif(obj, 5), ' ')
    return(obj)
  }
  stop('method must be "TAE" or "SS" but is ', method)
}


# Objective based on two variables
resCalcComb <- function(p, dat, weights = 1, app.name, group = NULL, time.name = 'ct', to = c('j', 'er'), wr = 1, fixed, method = 'TAE', time.incorp = NULL, flatout = FALSE, prog = TRUE, browseNA = FALSE, rminj = NULL) {

  if (!all(is.numeric(weights) | length(weights) > 0 | !all(is.na(weights)))) stop('Problem with weights argument.')
  if (!all(to %in% c('j', 'e', 'e.int', 'er'))) stop('to argument must be "j", "e", "er", or "e.int" but is ', to)
  if (any(is.na(weights)) || any(is.null(weights))) stop('weights are NA or NULL')
  if (!missing(fixed)) p <- c(p, fixed)
  #cat('\n')
  #print(p)

  # Cancel some pars for injection
  if (!is.null(rminj)) {
    p <- ipars(p, rminj)
  }

  pred <- alfam2(dat, pars = p, app.name = app.name, time.name = time.name, 
                    time.incorp = time.incorp, group = group, flatout = flatout, warn = FALSE, center = c(man.dm.app.mthd.bc = 6))[, to]

  if (length(weights) == 1) {
    weights <- data.frame(rep(weights, nrow(dat)), rep(weights, nrow(dat)))
  }

  # Note that data frame is needed for indexing by matrix
  obs <- data.frame(dat[, ..to])
  obs[weights == 0] <- NA # To prevent warning on NaNs
  if (any(is.na(obs[weights > 0]))) {
    stop('NA values in observations obs, not just where weights = 0.')
  }

  # Drop obs originally added in alfam2() call for data prep in prep.R
  keeprows <- !dat[, `__add.row`]
  obs <- obs[keeprows, ]
  weights <- weights[keeprows, ]

  # Switch to matrix for cell-by-cell calcs
  pred <- as.matrix(pred)
  obs <- as.matrix(obs)
  weights <- as.matrix(weights)

  # Set NA obs to high value for high residual
  pred[is.na(pred)] <- Inf

  # Adjust weights in total for second variable to match weights ratio wr, based on measurements (not predictions)
  ws1 <- sum(na.omit(obs[, 1] * weights[, 1]))
  ws2 <- sum(na.omit(obs[, 2] * weights[, 2]))
  weights[, 2] <- ws1 / ws2 * 1 / wr * weights[, 2]
  
  res <- weights * (pred - obs) 
  res[weights == 0] <- 0 

  if (any(is.na(res))) {
    warning('NA in residuals, see rows ', paste(which(is.na(res)), collapse = ', '), '. ')
  }

  if (any(is.na(res)) && browseNA) {
    browser('NA in residuals')
  }

  res[is.na(res)] <- 0

  if (method == 'TAE') {
    obj <- sum(abs(res))
  } else if (method == 'SS') {
    obj <- sum(abs(res^2))
  } else {
    stop('method must be "TAE" or "SS" but is ', method)
  }

  if (prog) cat(signif(obj, 5), ' ')

  return(obj)

}

