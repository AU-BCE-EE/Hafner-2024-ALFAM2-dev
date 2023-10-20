
# Cal c1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'c1'
print(ps)
pars.cal <- c(app.mthd.bsth.f0 = -0.22, app.mthd.bc.f0 = 1.0, app.mthd.ts.f0 = -0.52, app.mthd.os.f0 = -1.0, app.mthd.cs.f0 = -5.5,
              app.rate.ni.f0 = -0.02, man.dm.ni.f0 = 0.38, man.source.pig.f0 = -1.4,
              app.mthd.bsth.r1 = -1.3, app.mthd.bc.r1 = -1.0, app.mthd.ts.r1 = -2.2, app.mthd.os.r1 = -1.8, 
              man.dm.r1 = -0.1, air.temp.r1 = 0.07, wind.sqrt.r1 = 1.3, man.ph.r1 = 0.94, 
              int.r2 = -2.3, 
              int.r3 = -3, 
              man.ph.r3 = 0.20, 
              incorp.shallow.f4 = -0.50, incorp.shallow.r3 = -0.5, 
              incorp.deep.f4 = -2.4, incorp.shallow.r3 = -4.8, 
              int.r5 = -1.8, rain.rate.r5 = 0.5)

fixed <- c(app.mthd.cs.r1 = -1.8, rain.rate.r2 = 0.4)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'er'), wr = 4 / 1, time.name = 'cta',
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



