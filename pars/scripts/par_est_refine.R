# Final parameter estimation, separate script just to make it easier to work on

print(Sys.time())

# Cal f20 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Drop some pars from f9
# Settings
ps <- 'f20'
print(ps)
fixed <- c(int.r5 = -1.8)

pars.start <- mods$f9$optim$par
pars.start <- pars.start[!grepl('app.rate|app.mthd.bc.r3', names(pars.start))]
print(pars.start)

upper <- pars.start + 2
lower <- pars.start - 2

# Look for problem observations before parameter estimation by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 3 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                  method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())



