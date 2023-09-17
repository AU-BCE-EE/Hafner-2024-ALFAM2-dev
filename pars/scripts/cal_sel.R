print(Sys.time())

# List for holding output
mods <- list()

# Cal f1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f1'
fixed <- integer()

pars.cal <- ALFAM2::alfam2pars02
pars.cal['app.rate.f0'] <- pars.cal['app.rate.ni.f0']
pars.cal <- pars.cal[!names(pars.cal) %in% c('app.rate.ni.f0', 'ts.cereal.hght.r1')]
pars.cal['int.r5'] <- -1.5
pars.cal['rain.rate.r5'] <- 1.0

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try more weight to er
# Settings
ps <- 'f2'
fixed <- integer()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove shallow incorp r3 effect, wrong direction
# Settings
ps <- 'f3'
fixed <- integer()
pars.cal <- pars.cal[names(pars.cal) != 'incorp.shallow.r3']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same except use only final emission as reponse
# Settings
ps <- 'f4'
fixed <- integer()
pars.cal <- mods$f3$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove rain r5, wrong direction
# Settings
ps <- 'f5'
fixed <- integer()
pars.cal <- mods$f4$cal$par
pars.cal <- pars.cal[names(pars.cal) != 'rain.rate.r5']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
# NTS: increase iterations later!
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE, rminj = c('app.rate', 'man.dm')),
                                  method = 'Nelder-Mead', control = list(maxit = 400))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove pH effect for injection
# Settings
ps <- 'f6'
fixed <- integer()
pars.cal <- mods$f5$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
# NTS: increase iterations later!
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE, rminj = c('app.rate.f0', 'man.dm.f0', 'man.ph.r3')),
                                  method = 'Nelder-Mead', control = list(maxit = 400))

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp['app.rate.f0'], man.dm.app.mthd.inj.f0 = - pp['man.dm.f0'], man.ph.app.mthd.inj.r3 = - pp[['man.ph.r3']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



