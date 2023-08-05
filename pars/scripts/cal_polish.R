# Polish par set
# One of these will be "par set 3"

print(Sys.time())

# Cal h1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# h for polis*h*
# Revise p2 
# Settings
ps <- 'h1'

# Fix rain rate
fixed <- c(rain.rate.r5 = 0.5)
pars.prev <- mods[['p2']][['cal']][['par']]
pars.cal <- pars.prev[!grepl('rain.rate.r5', names(pars.prev))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

# Cal h2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# h for polis*h*
# Fix some pars that go to nonsense values (and some incorp stuff, preemptive fixing)
ps <- 'h2'

# Fix rain rate
fixed <- c(rain.rate.r5 = 0.5, app.mthd.cs.f0 = -7, incorp.shallow.f4 = -1, incorp.deep.f4 = -3)
pars.prev <- mods[['h1']][['cal']][['par']]
pars.cal <- pars.prev[!names(pars.prev) %in% names(fixed)]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

