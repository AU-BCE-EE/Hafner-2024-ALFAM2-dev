# Parameter estimation

mods <- list()

# Cal f1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f1'
print(ps)
fixed <- integer()

pars.cal <- ALFAM2::alfam2pars02
pars.cal <- pars.cal[!names(pars.cal) %in% c('ts.cereal.hght.r1')]
pars.cal['int.r5'] <- -1.5
pars.cal['rain.rate.r5'] <- 1.0

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.last, weight.1)], flatout = TRUE),
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

pars.cal <- mods$f1$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last, weight.1)], flatout = TRUE),
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

pars.cal <- mods$f2$cal$par

ww <- c(bsth = 1, ts = 1, os = 3, cs = 3, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try square root wind
# Settings
ps <- 'f4'
print(ps)
fixed <- integer()

pars.cal <- mods$f3$cal$par
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Exclude man.dm effect from injection
# Cal f5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f5'
print(ps)
fixed <- integer()

pars.cal <- mods$f4$cal$par
names(pars.cal) <- gsub('man\\.dm', 'man\\.dm\\.ni', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Adjust weights to try to improve bsth fit
# Settings
ps <- 'f6'
print(ps)
fixed <- integer()

pars.cal <- mods$f3$cal$par

ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same but improve some starting estimates, hoping some extreme pars are local minima
# Settings
ps <- 'f7'
print(ps)
fixed <- integer()

pars.cal <- mods$f6$cal$par
pars.cal['incorp.deep.r3'] <- -0.5
pars.cal['incorp.shallow.r3'] <- 0
pars.cal['incorp.deep.f4'] <- -2
pars.cal['incorp.shallow.f4'] <- -0.5
pars.cal['man.ph.r1'] <- 0.7
pars.cal['man.ph.r3'] <- 0.1
pars.cal['app.mthd.cs.f0'] <- -4
pars.cal['rain.rate.r5'] <- 0.3

ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Manually set starting values, and use limits?
# These values from an older "f9"
# Settings
ps <- 'f8'
print(ps)
fixed <- integer()

pars.cal <- c(
  int.f0 = -0.080296560,
  app.mthd.os.f0 = -2.593071,
  app.rate.ni.f0 = -0.0202197,
  man.dm.f0 = 0.40205,
  man.source.pig.f0 = -0.97309,
  app.mthd.cs.f0 = -7.4823,
  int.r1 = -1.2692,
  app.mthd.bc.r1 = 0.4945,
  man.dm.r1 = -0.0955290,
  air.temp.r1 = 0.08569,
  app.mthd.ts.r1 = -0.653678,
  man.ph.r1 = 0.95401,
  int.r2 = -1.973,
  rain.rate.r2 = 0.78398,
  int.r3 = -2.8579,
  app.mthd.bc.r3 = 0.67081,
  app.mthd.cs.r3 = -0.2693,
  man.ph.r3 = 0.0945944,
  incorp.shallow.f4 = -1.09220,
  incorp.shallow.r3 = -0.286370,
  incorp.deep.f4 = -1.49060,
  incorp.deep.r3 = -0.9927,
  int.r5 = -2.0482,
  rain.rate.r5 = 0.633341,
  wind.sqrt.r1 = 1.43227,
  app.cs.f0 = 6.32131)

# Same weights
ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try average air temp effect on r3 
# Settings
ps <- 'f9'
print(ps)
fixed <- integer()

pars.cal <- mods$f8$cal$par
pars.cal['air.temp.ave.r3'] <- 0.001

ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



