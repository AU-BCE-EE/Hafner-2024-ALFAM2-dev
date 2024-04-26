# Parameter estimation

# List for optim() output (including best-fit parameters) for all attempts
mods <- list()

# Cal f1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f1'
print(ps)
fixed <- integer()

pars.start <- ALFAM2::alfam2pars02
pars.start <- pars.start[!names(pars.start) %in% c('ts.cereal.hght.r1')]
pars.start['int.r5'] <- -1.5
pars.start['rain.rate.r5'] <- 1.0

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')
dim(idat1)
dim(pr)

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.last, weight.1a)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same but use SS
# Settings
ps <- 'f2'
print(ps)
fixed <- integer()

pars.start <- mods$f1$optim$par

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last, weight.1a)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Increase weights for injection and band application
# Settings
ps <- 'f3'
print(ps)
fixed <- integer()

pars.start <- mods$f2$optim$par

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Square root wind transformation and reduce rain effect (to avoid r1 limit)
# Settings
ps <- 'f4'
print(ps)
fixed <- integer()

pars.start <- mods$f3$optim$par
names(pars.start) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.start))
pars.start['rain.rate.r5'] <- 0.3


# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Increase weight on flux a bit for better flux curves
# Settings
ps <- 'f5'
print(ps)
fixed <- integer()

pars.start <- mods$f4$optim$par

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
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Fix int.r5 at a higher (faster) value
# Settings
ps <- 'f6'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f5$optim$par
pars.start <- pars.start[names(pars.start) != 'int.r5']

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try square root DM for f0
# Settings
ps <- 'f7'
print(ps)
fixed <- c(int.r5 = -1.8)

idat1[, man.dm.sqrt := sqrt(man.dm)]

pars.start <- mods$f6$optim$par
names(pars.start) <- gsub('man\\.dm\\.f0', 'man\\.dm\\.sqrt\\.f0', names(pars.start))

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try f6 again, with better starting values
# Settings
ps <- 'f8'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f6$optim$par
pars.start['incorp.deep.r3'] <- -1.5
pars.start['app.mthd.os.f0'] <- -2
pars.start['app.mthd.cs.f0'] <- -3

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try f6 again, with better starting values
# Settings
ps <- 'f9'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f6$optim$par
pars.start['app.mthd.cs.f0'] <- -5

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f10 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with f9, try to optimize r5 intercept too
# Settings
ps <- 'f10'
print(ps)
fixed <- NULL

pars.start <- mods$f9$optim$par
pars.start['int.r5'] <- -1.8

upper <- pars.start + 2
lower <- pars.start - 2
lower['int.r5'] <- -4

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f11 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with f9 but put DM effect on r2 not f0 (try to fix os increase with DM)
# Settings
ps <- 'f11'
print(ps)
fixed <- c(int.r5 = -1.8)

# NTS: re-run with f9!!! Was f6.
pars.start <- mods$f9$optim$par
pars.start <- pars.start[names(pars.start) != 'man.dm.f0']
pars.start['man.dm.r2'] <- -0.1

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f12 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with f9 but add DM effect on r2 not f0 (try to fix os increase with DM)
# Settings
ps <- 'f12'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f9$optim$par
idat1[, app.mthd.bc.man.dm := app.mthd.bc * man.dm]
pars.start['app.mthd.bc.man.dm.r1'] <- -0.1

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f13 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with f9 but add DM bc effect on f0 not r1
# Settings
ps <- 'f13'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f9$optim$par
idat1[, app.mthd.bc.man.dm := app.mthd.bc * man.dm]
pars.start['app.mthd.bc.man.dm.f0'] <- -0.1

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



# Cal f14 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with f13 but add DM r1 effect for bc
# Settings
ps <- 'f14'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f13$optim$par
pars.start['app.mthd.bc.man.dm.r1'] <- -0.1

upper <- pars.start + 2
lower <- pars.start - 2

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
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



