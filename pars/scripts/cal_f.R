# Calibration FUCK

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
# Adjust weights
# Settings
ps <- 'f6'
print(ps)
fixed <- integer()

pars.cal <- mods$f3$cal$par
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

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


