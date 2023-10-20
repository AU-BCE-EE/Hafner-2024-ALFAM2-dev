# Parameter estimation in 2 groups (surface and injection)

# Cal s1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 's1'
print(ps)
fixed <- integer()

pars.cal <- c(
  int.f0 = -0.080296560,
  app.rate.ni.f0 = -0.0202197,
  man.dm.f0 = 0.40205,
  man.source.pig.f0 = -0.97309,
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
  man.ph.r3 = 0.0945944,
  incorp.shallow.f4 = -1.09220,
  incorp.shallow.r3 = -0.286370,
  incorp.deep.f4 = -1.49060,
  incorp.deep.r3 = -0.9927,
  int.r5 = -2.0482,
  rain.rate.r5 = 0.633341,
  wind.sqrt.r1 = 1.)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

caldat <- idat1[app.mthd %in% c('bc', 'bsth', 'ts')]

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = caldat, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = caldat[, .(weight.last, weight.1a)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal s2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try different starting values
ps <- 's2'
print(ps)
fixed <- integer()

pars.cal <- ALFAM2::alfam2pars02
pars.cal <- pars.cal[!names(pars.cal) %in% c('ts.cereal.hght.r1')]
pars.cal <- pars.cal[!grepl('app\\.mthd\\.os|app\\.mthd\\.cs', names(pars.cal))]
pars.cal['int.r5'] <- -1.5
pars.cal['rain.rate.r5'] <- 1.0
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

caldat <- idat1[app.mthd %in% c('bc', 'bsth', 'ts')]

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = caldat, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = caldat[, .(weight.last, weight.1a)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())


# Cal s3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Different weighting because fit to bsth and overall is poor, why???
ps <- 's3'
print(ps)
fixed <- integer()

pars.cal <- mods[['s2']]$coef

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

caldat <- idat1[app.mthd %in% c('bc', 'bsth', 'ts')]

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = caldat, to = c('er', 'j'), wr = 10 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = caldat[, .(weight.last, weight.1a)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

