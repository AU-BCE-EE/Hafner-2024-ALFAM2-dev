# Polish par set
# One of these will be "par set 3"

print(Sys.time())

# Cal h1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# h for polis*h*
# Revise p1 
# Settings
ps <- 'h1'

# Fix pars that are not well-supported by many institutions (or like int.f0 just seem to vary)
nm.fixed <-'rain.rate.2|int.f0|app.mthd|man.ph' 
pars.prev <- mods[['p1']][['cal']][['par']]
pars.cal <- pars.prev[!grepl(nm.fixed, names(pars.prev))]
fixed <- pars.prev[grepl(nm.fixed, names(pars.prev))]

pars.cal <- c(pars.cal, air.temp.r5 = 0.0)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(idat3, app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal, flatout = TRUE)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat3, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat3[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat3), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat3, pr[, -1:-3])
dpreds3 <- dpreds3[pars != ps, ]
dpreds3 <- rbind(dpreds3, dd)

# Apply to subset 1 as well, fixing missing pH at 7
# NTS: apply note to cal_pH and also should this substitution be done in data prep?
idat1[is.na(man.ph), man.ph := 7]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

# Cal h2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Revise p1 again but try . . . something else
# Settings
ps <- 'h2'

# Fix pars that are not well-supported by many institutions (or like int.f0 just seem to vary)
nm.fixed <-'rain.rate.2|int.f0|app.mthd|man.ph' 
pars.prev <- mods[['p1']][['cal']][['par']]
pars.cal <- pars.prev[!grepl(nm.fixed, names(pars.prev))]
fixed <- pars.prev[grepl(nm.fixed, names(pars.prev))]

pars.cal <- c(pars.cal, air.temp.r2 = 0.01)


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(idat3, app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal, flatout = TRUE)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat3, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat3[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat3), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat3, pr[, -1:-3])
dpreds3 <- dpreds3[pars != ps, ]
dpreds3 <- rbind(dpreds3, dd)

# Apply to subset 1 as well, fixing missing pH at 7
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

# Cal h3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove air.temp.r3
# Settings
ps <- 'h3'

pars.prev <- mods[['p1']][['cal']][['par']]
pars.cal <- pars.prev[!grepl('air.temp.r3', names(pars.prev))]
fixed <- numeric()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(idat3, app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal, flatout = TRUE)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat3, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat3[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat3), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat3, pr[, -1:-3])
dpreds3 <- dpreds3[pars != ps, ]
dpreds3 <- rbind(dpreds3, dd)

# Apply to subset 1 as well, fixing missing pH at 7
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

# Cal h4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try r3 air temp effect based on average (for soil temp surrogate)
# Settings
ps <- 'h4'

pars.prev <- mods[['h3']][['cal']][['par']]
pars.cal <- pars.prev
pars.cal <- c(pars.cal, air.temp.ave.r3 = 0.01)
fixed <- numeric()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(idat3, app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal, flatout = TRUE)
# Should be no warnings (no dropped pars)
# Should be no NA in output
if (is.nan(sum(pr$er)) | is.na(sum(pr$e))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat3, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat3[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat3), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat3, pr[, -1:-3])
dpreds3[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]
dpreds3 <- dpreds3[pars != ps, ]
dpreds3 <- rbind(dpreds3, dd)

# Apply to subset 1 as well, fixing missing pH at 7
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())


