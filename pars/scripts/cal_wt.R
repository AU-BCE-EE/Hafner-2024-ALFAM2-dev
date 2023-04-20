# Calibration based on Johanna's wind tunnel data

# Cal w1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Revise trimmed p1
# Settings
ps <- 'w1'
fixed <- integer()

pars.cal <- mods[['p1']][['cal']][['par']]
pars.cal <- pars.cal[!grepl('app.mthd.bc|app.mthd.os', names(pars.cal))]

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat4), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
if (is.nan(sum(pr$er))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat4, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat4[, weight.plots] * idat4[, weight.168]),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat4), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat4, pr[, -1:-3])
dpreds4 <- dpreds4[pars != ps, ]
dpreds4 <- rbind(dpreds4, dd)

