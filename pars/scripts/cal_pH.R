# Try to add pH parameters
# One of these will be "par set 3"

print(Sys.time())

# Cal p1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Revise i2 
# Settings
ps <- 'p1'
fixed <- integer()

pp <- mods[['i2']][['cal']][['par']]
pars.cal <- c(pp, ALFAM2pars02[grepl('man.ph', names(ALFAM2pars02))])

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat3), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat3, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat3[, weight.plots] * idat3[, weight.168], flatout = TRUE),
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

# Apply to subset 1 as well
idat1[is.na(man.ph), man.ph := 7]
ps <- 'p1'
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd)

print(Sys.time())

# Cal p2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
