# Compare speed of alfam2() versions

# Packages
library(data.table)

source('../../functions/rounddf.R')

# Install packages
# Locations for R (old) and Rcpp (new) versions
rver <- '/home/sasha/R/ALFAM2-versions/R-ver/'
cver <- '/home/sasha/R/ALFAM2-versions/Rcpp-ver/'

# Install different versions to different locations (only needs to be done once)
#devtools::install_github('sashahafner/ALFAM2@v2.0', lib = rver)
#devtools::install_github('sashahafner/ALFAM2@v3.17', ref = 'Rcpp-dev', lib = cver, force = TRUE)

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

# With prep
datpp <- ALFAM2:::prepDat(datp, value = 'data')
datpp$`__f4` <- 1
datpp$`__add.row` <- FALSE

datpip <- ALFAM2:::prepDat(datpi, value = 'data')
datpip$`__f4` <- 1
datpip$`__add.row` <- FALSE

# Many times
set.seed(123)
ntimes <- 1E6
d <- data.frame(ct = 1:ntimes * 168 / ntimes, app.mthd = 'bc', 
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

# With prep
dattp <- ALFAM2:::prepDat(datt, value = 'data')
dattp$`__f4` <- 1
dattp$`__add.row` <- FALSE

dattip <- ALFAM2:::prepDat(datti, value = 'data')
dattip$`__f4` <- 1
dattip$`__add.row` <- FALSE

# Results matrix
stdev <- times <- matrix(NA, nrow = 4, ncol = 3, 
                         dimnames = list(c('plots', 'plots-incorp', 'times', 'times-incorp'), 
                                         c('R', 'Rcpp', 'flat-out')))

# Loop through both versions and flatout option
for (j in 1:3) {

  if ('ALFAM2' %in% (.packages())) detach('package:ALFAM2')
  if (j == 1) {
    ll <- rver
  } else {
    ll <- cver
  }

  library(ALFAM2, lib.loc = ll)
  print(packageVersion("ALFAM2"))

  if (j == 3) {
    flatout <- TRUE
    datp <- datpp
    datpi <- datpip
    datt <- dattp
    datti <- dattip
  } else {
    flatout <- FALSE
  }
  
  # Many plots, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(alfam2(datp, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                group = 'id', prep = TRUE, warn = FALSE, flatout = flatout))[3]
  }
  
  times['plots', j] <- mean(tt)
  stdev['plots', j] <- sd(tt)
  
  # Many plots, with incorporation.
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    args(alfam2)
    tt[i] <- system.time(alfam2(datpi, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', group = 'id', prep = TRUE, warn = FALSE, flatout = flatout))[3]
  }
  
  times['plots-incorp', j] <- mean(tt)
  stdev['plots-incorp', j] <- sd(tt)
  
  # Many times, no incorporation
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(alfam2(datt, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                                prep = TRUE, warn = FALSE, flatout = flatout))[3]
  }
  
  times['times', j] <- mean(tt)
  stdev['times', j] <- sd(tt)
  
  # Many times, with incorporation
  
  nits <- 7
  tt <- numeric(nits)
  for (i in 1:nits) {
    tt[i] <- system.time(alfam2(datti, pars = ALFAM2::alfam2pars02, time.incorp = 't.incorp', 
                                app.name = 'tan.app', prep = TRUE, warn = FALSE, flatout = flatout))[3]
  }
  
  times['times-incorp', j] <- mean(tt)
  stdev['times-incorp', j] <- sd(tt)

}

# Sort out results
cv <- 100 * stdev / times
times <- rounddf(times, 3, func = signif)
cv <- rounddf(cv, 3, func = signif)

# Export results
write.csv(times, '../output/times_ubuntu.csv')
write.csv(cv, '../output/cv_ubuntu.csv')
