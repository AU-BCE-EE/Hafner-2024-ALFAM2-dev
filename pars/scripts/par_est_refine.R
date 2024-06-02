# Final parameter estimation, separate script just to make it easier to work on

print(Sys.time())

# Cal f20 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop some pars from f9
# Settings
ps <- 'f20'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f9$optim$par
pars.start <- pars.start[!grepl('app.rate|app.mthd.bc.r3', names(pars.start))]
print(pars.start)

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

# Cal f21 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try some separate bc pars
# Settings
ps <- 'f21'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f20$optim$par
pars.start <- pars.start[!grepl('app.rate|app.mthd.bc.r3', names(pars.start))]
pars.start['man.dm.app.mthd.bc.f0'] <- 0.0
pars.start['man.dm.app.mthd.bc.r1'] <- 0.0

idat1[, man.dm.app.mthd.bc := app.mthd.bc * man.dm]

upper <- pars.start + 2
lower <- pars.start - 2

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE, center = c(man.dm.app.mthd.bc = 6))
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

# Cal f22 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f20 but keep f9's bc r3 term
# Settings
ps <- 'f22'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f9$optim$par
pars.start <- pars.start[!grepl('app.rate', names(pars.start))]
print(pars.start)

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

# Cal f23 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f22 but boost final cum emis weight a bit for better fit
# Settings
ps <- 'f23'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f22$optim$par
pars.start <- pars.start[!grepl('app.rate', names(pars.start))]
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 5 / 1, time.name = 'cta',
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

# Cal f24 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f23 but don't allow negative r3 pH effect
# Settings
ps <- 'f24'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f23$optim$par
pars.start['man.ph.r3'] <- 0.01
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2
lower['man.ph.r3'] <- 0

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 5 / 1, time.name = 'cta',
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

# Cal f25 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f23 but now fix man.ph r3 effect at about 1/10th r1 value
# Settings
ps <- 'f25'
print(ps)
fixed <- c(int.r5 = -1.8, man.ph.r3 = 0.05)

pars.start <- mods$f23$optim$par
pars.start <- pars.start[!grepl('man.ph.r3', names(pars.start))]
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 5 / 1, time.name = 'cta',
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

# Cal f26 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f25 but add bc f0 par, hope it fixes bad DM r1 par
# Settings
ps <- 'f26'
print(ps)
fixed <- c(int.r5 = -1.8, man.ph.r3 = 0.05)

pars.start <- mods$f25$optim$par
# Add par
pars.start['app.mthd.bc.f0'] <- 0.01
# Adjust par
pars.start['man.dm.r1'] <- - 0.1
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 5 / 1, time.name = 'cta',
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

# Cal f27 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f26 but with lower weight
# Settings
ps <- 'f27'
print(ps)
fixed <- c(int.r5 = -1.8, man.ph.r3 = 0.05)

pars.start <- mods$f25$optim$par
# Add par
pars.start['app.mthd.bc.f0'] <- 0.01
# Adjust par
pars.start['man.dm.r1'] <- -0.1
print(pars.start)

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


# Cal f28 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Like f20 (from f9) but with incorp.shallow.r3 < 0
# Settings
ps <- 'f28'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f20$optim$par
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2
upper['incorp.shallow.r3'] <- 0

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

# Cal f29 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# May be same as f28 but without incorp.shallow.r3 par at all
# Settings
ps <- 'f29'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f28$optim$par
pars.start <- pars.start[names(pars.start) != 'incorp.shallow.r3']
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2
lower['incorp.deep.f4'] <- -10

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







