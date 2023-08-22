print(Sys.time())

# List for holding output
mods <- list()

# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

# Cal xx ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

