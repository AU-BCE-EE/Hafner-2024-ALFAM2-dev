# Compare speed of alfam2() versions

rm(list = ls())

# Packages
library(data.table)

# Functions
source('../../functions/rounddf.R')

# Install packages
# Locations for R (old) and Rcpp (new) versions
rver <- '/home/sasha/R/ALFAM2-versions/R-ver/'
cver <- '/home/sasha/R/ALFAM2-versions/Rcpp-ver/'

# Install different versions to different locations (only needs to be done once)
#devtools::install_github('sashahafner/ALFAM2@v2.0', lib = rver)
#devtools::install_github('sashahafner/ALFAM2@bb418400e3fec8ad5c1d065c583b06de7ef2de23', lib = cver, force = TRUE)
#3

# Need new version of package first for incorp data processing
library(ALFAM2, lib.loc = cver)
packageVersion('ALFAM2')

# Input data
# Many plots 
set.seed(123)
d <- data.frame(ct = 1:168, app.mthd = 'bc', 
                man.dm = 7, man.ph = 7, man.source = 'cattle', 
                air.temp = rnorm(168, mean = 10, sd = 5), 
                wind.2m = rnorm(168, mean = 5, sd = 1),
                tan.app = 100)

# Without incorporation.
nplots <- 1000
datp <- d[rep(1:nrow(d), nplots), ]
datp$id <- rep(1:nplots, each = nrow(d))

# Add incorporation.
datpi <- datp
datpi$t.incorp <- 3
datpi$incorp <- 'shallow'

# Incorp needs prep if used with flatout = TRUE
datpip <- alfam2(datpi, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                 app.name = 'tan.app', group = 'id', prep.dum = TRUE, warn = TRUE, 
                 value = 'incorp')

# Many times
set.seed(123)
ntimes <- 1E6
d <- data.frame(ct = sort(c(1:(ntimes - 1) * 168 / (ntimes - 1), 3)), app.mthd = 'bc', 
                man.dm = 7, man.ph = 7, man.source = 'cattle', 
                air.temp = rnorm(ntimes, mean = 10, sd = 5), 
                wind.2m = rnorm(ntimes, mean = 5, sd = 1),
                tan.app = 100)

# Without incorporation.
datt <- d

# Add incorporation.
datti <- datt
datti$t.incorp <- 3
datti$incorp <- 'shallow'

# Incorp needs prep if used with flatout = TRUE
dattip <- alfam2(datti, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                 app.name = 'tan.app',  prep.dum = TRUE, warn = TRUE, 
                 value = 'incorp')

# Results matrix
stdev <- times <- matrix(NA, nrow = 4, ncol = 3, 
                         dimnames = list(c('plots', 'plots-incorp', 'times', 'times-incorp'), 
                                         c('R', 'Rcpp', 'Rcpp-fast')))

# Run old version first
for (j in 1) {

  if ('ALFAM2' %in% (.packages())) detach('package:ALFAM2')
  ll <- rver
  library(ALFAM2, lib.loc = ll)
  print(packageVersion("ALFAM2"))

  # Many plots, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outp.o <- alfam2(datp, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                group = 'id', prep = TRUE, warn = FALSE))[3]
  }
  
  times['plots', j] <- mean(tt)
  stdev['plots', j] <- sd(tt)
  
  # Many plots, with incorporation.
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    args(alfam2)
    tt[i] <- system.time(outpi.o <- alfam2(datpi, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', group = 'id', prep = TRUE, warn = FALSE))[3]
  }
  
  times['plots-incorp', j] <- mean(tt)
  stdev['plots-incorp', j] <- sd(tt)
  
  # Many times, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outt.o <- alfam2(datt, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                prep = TRUE, warn = FALSE))[3]
  }
  
  times['times', j] <- mean(tt)
  stdev['times', j] <- sd(tt)
  
  # Many times, with incorporation
  
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outti.o <- alfam2(datti, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', prep = TRUE, warn = FALSE))[3]
  }
  
  times['times-incorp', j] <- mean(tt)
  stdev['times-incorp', j] <- sd(tt)
}


# Run new version with and without flatout option
j <- 2
for (j in 2:3) {

  if ('ALFAM2' %in% (.packages())) detach('package:ALFAM2')
  ll <- cver

  library(ALFAM2, lib.loc = ll)
  print(packageVersion("ALFAM2"))

  dp <- datp
  dt <- datt

  if (j == 3) {
    prep.incorp <- FALSE
    check <- FALSE
    dpi <- datpip
    dti <- dattip
  } else {
    prep.incorp <- TRUE
    check <- TRUE
    dpi <- datpi
    dti <- datti
  }
  
  # Many plots, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outp.n <- alfam2(dp, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                group = 'id', prep.dum = TRUE, warn = TRUE, prep.incorp = TRUE, check = check))[3]
  }
  
  times['plots', j] <- mean(tt)
  stdev['plots', j] <- sd(tt)
  
  # Many plots, with incorporation.
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outpi.n <- alfam2(dpi, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', group = 'id', prep.dum = FALSE, warn = FALSE, prep.incorp = prep.incorp, check = check))[3]
  }
  
  times['plots-incorp', j] <- mean(tt)
  stdev['plots-incorp', j] <- sd(tt)
  
  # Many times, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outt.n <- alfam2(dt, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                prep.dum = TRUE, warn = FALSE, prep.incorp = TRUE, check = check))[3]
  }
  
  times['times', j] <- mean(tt)
  stdev['times', j] <- sd(tt)
  
  # Many times, with incorporation
  
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(outti.n <- alfam2(dti, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', prep.dum = TRUE, warn = FALSE, prep.incorp = prep.incorp, check = check))[3]
  }
  
  times['times-incorp', j] <- mean(tt)
  stdev['times-incorp', j] <- sd(tt)
}

# Sort out results
cv <- 100 * stdev / times
times <- rounddf(times, 3, func = signif)
cv <- rounddf(cv, 3, func = signif)

# Make sure incorporation and other results with fast options are correct
# Note that *.n results are fast because they were last run in loop
if (!all(c1 <- isTRUE(all.equal(outp.o$er, outp.n$er)), 
         c2 <- isTRUE(all.equal(outpi.o$er, outpi.n$er)), 
         c3 <- isTRUE(all.equal(outt.o$er, outt.n$er)), 
         c4 <- isTRUE(all.equal(outti.o$er, outti.n$er)))) {
  print(c(c1, c2, c3, c4))
  stop('Output problem--results are not identical with and without flatout = TRUE!')
}

# Export results
write.csv(times, '../output/times_ubuntu.csv')
write.csv(cv, '../output/cv_ubuntu.csv')
