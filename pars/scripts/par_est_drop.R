# Drop predictors to see how much they affect model fit

# Cal d1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop all weather
# Settings
ps <- 'd1'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$ps3$optim$par
pars.start <- pars.start[! grepl('air.temp|wind|rain', names(pars.start))]

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 3 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal d2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop application rate
# Settings
ps <- 'd2'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$d1$optim$par
pars.start <- pars.start[! grepl('app\\.rate', names(pars.start))]

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 3 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
fixed <- c(int.r5 = -1.8)
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal d3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop pH
# Settings
ps <- 'd3'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$d2$optim$par
pars.start <- pars.start[! grepl('man\\.ph', names(pars.start))]

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 3 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



# Cal d4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop man.dm
# Settings
ps <- 'd4'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$d3$optim$par
pars.start <- pars.start[! grepl('man\\.dm', names(pars.start))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal d5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop pig source
# Settings
ps <- 'd5'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$d4$optim$par
pars.start <- pars.start[! grepl('man\\.source\\.pig', names(pars.start))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



# Cal d6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop application methods
# Settings
ps <- 'd6'
fixed <- c(int.r5 = -1.8)
pars.start <- mods$d5$optim$par
pars.start <- pars.start[! grepl('app\\.mthd', names(pars.start))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit2))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())
