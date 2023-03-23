# Add incorporation parameters

# Cal i1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Revise c
# Settings
ps <- 'i1'
fixed <- integer()

pp <- mods[['c']][['cal']][['par']]
pars.cal <- c(pp, ALFAM2pars02[grepl('incorp', names(ALFAM2pars02))])

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat2, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat2[, weight.168]),
                                  method = 'Nelder-Mead')

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd)

# Cal i2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Revise i1, weight by number of obs
# Settings
ps <- 'i2'
fixed <- integer()

pars.cal <- mods[['i1']][['cal']][['par']]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat2, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat2[, weight.plots] * idat2[, weight.168]),
                                  method = 'Nelder-Mead')

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat2), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat2, pr[, -1:-3])
dpreds2 <- dpreds2[pars != ps, ]
dpreds2 <- rbind(dpreds2, dd)
