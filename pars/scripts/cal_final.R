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
table(idat1$incorp, exclude = NULL)
sum(is.na(idat1$incorp))
#debug(ALFAM2:::prepIncorp)
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Shift balance between er and j to improve fit in final emissions
# Settings
ps <- 'f2'
fixed <- integer()
pars.cal <- mods$f1$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal f3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Keep balance wr = 1 : 3 
# Try SS instead of MAE
# Settings
ps <- 'f3'
fixed <- integer()
pars.cal <- mods$f2$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SS and er only
# Settings
ps <- 'f4'
fixed <- integer()
pars.cal <- mods$f1$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# MAE and er only
# Settings
ps <- 'f5'
fixed <- integer()
pars.cal <- mods$f4$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove increase in r3 with shallow incorp
# Settings
ps <- 'f6'
fixed <- integer()
pars.cal <- mods$f5$cal$par
pars.cal <- pars.cal[names(pars.cal) != 'incorp.shallow.r3']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Add app.mthd.bc.r5 to try to separate bc (good) and bsth (poor) fit
# Settings
ps <- 'f7'
fixed <- integer()
pars.cal <- mods$f6$cal$par
pars.cal <- c(pars.cal, app.mthd.bc.r5 = 0.0)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Instead of app.mthd.bc.r5 try app.mthd.bc.r2
# Settings
ps <- 'f8'
fixed <- integer()
pars.cal <- mods$f6$cal$par
pars.cal <- c(pars.cal, app.mthd.bc.r2 = 0.0)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal nor5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# For comparison, drop r5 out
# Settings
ps <- 'nor5'
fixed <- c(int.r5 = -6)
pars.cal <- mods$f6$cal$par
pars.cal <- pars.cal[!grepl('r5', names(pars.cal))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal r5t ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Link r5 to temperature 
# Settings
ps <- 'r5t'
fixed <- numeric()
pars.cal <- mods$f6$cal$par
pars.cal <- c(pars.cal, air.temp.ave.r5 = 0.01)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.1], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f10 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Only count final obs
# Settings
ps <- 'f10'
fixed <- numeric()
pars.cal <- mods$f6$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())



# Cal f11 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Only count final obs but use SS
# Settings
ps <- 'f11'
fixed <- numeric()
pars.cal <- mods$f10$cal$par

# Adjust some extreme values (remember there is a max par setting in calcPPars())
lim <- 3
while (any(abs(pars.cal) > lim)) {
  pars.cal[abs(pars.cal) > lim] <-  pars.cal[abs(pars.cal) > lim] * 0.8
}

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal f12 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stick with f11 SS and final er approach, but add r3 temp back in
# Settings
ps <- 'f12'
fixed <- numeric()
pars.cal <- mods$f11$cal$par
pars.cal <- c(pars.cal, air.temp.r3 = 0.0)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal f13 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Stick with f11 SS and final er approach, keep temp r3 from f12, but now try sqrt transformation for wind 
# Settings
ps <- 'f13'
fixed <- numeric()
pars.cal <- mods$f12$cal$par
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())


# Cal f14 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ...
# Settings
ps <- 'f14'
fixed <- numeric()
pars.cal <- mods$f12$cal$par
names(pars.cal) <- gsub('air\\.temp', 'air.temp.log', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f15 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Back to f11 approach (had no temp effect for r3) but try sqrt wind
# Like f13 but no temp effect for r3
# Settings
ps <- 'f15'
fixed <- numeric()
pars.cal <- mods$f11$cal$par
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f16 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Why does bc drive poor fit for others? Omit it to see how parameters change.
# Settings
ps <- 'f16'
fixed <- numeric()
pars.cal <- mods$f11$cal$par
pars.cal <- pars.cal[!grepl('app\\/mthd\\.bc', names(pars.cal))]

# Subset without bc
idat1nbc <- idat1[app.mthd != 'bc', ]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1nbc), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1nbc, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1nbc[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f17 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Treat as partial cal to get incorp and rain pars to use as fixed in f11
# This uses flux data too
# Settings
ps <- 'f17'
fixed <- numeric()
pars.cal <- mods$f11$cal$par

# Adjust some extreme values (remember there is a max par setting in calcPPars())
lim <- 3
while (any(abs(pars.cal) > lim)) {
  pars.cal[abs(pars.cal) > lim] <-  pars.cal[abs(pars.cal) > lim] * 0.8
}

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f18 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Now back to f11 approach but drop some odd pars 
# Settings
ps <- 'f18'
fixed <- numeric()
pars.cal <- mods$f11$cal$par
pars.cal <- pars.cal[names(pars.cal) != c('rain.rate.r5')]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f19 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop ts effect (wrong direction)
# Settings
ps <- 'f19'
fixed <- numeric()
pars.cal <- mods$f18$cal$par
pars.cal <- pars.cal[names(pars.cal) != c('app.mthd.ts.r1')]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())

# Cal f20 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try DM effect on r2
# Settings
ps <- 'f20'
fixed <- numeric()
pars.cal <- mods$f19$cal$par
pars.cal <- c(pars.cal, man.dm.r2 = -0.1)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = c(pars.cal, fixed))
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
pp <- c(m$par, fixed)
# Add injection negation pars
# NTS: This stuff is dangerous
pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 2 as well
idat2[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd, fill = TRUE)

print(Sys.time())



