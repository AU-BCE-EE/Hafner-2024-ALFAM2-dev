
# Check these
#source('plot_boot.R')
#source('plot_resids.R') source('plot_.R')


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
# Adjust weights to try to improve bsth fit
# Settings
ps <- 'f6'
print(ps)
fixed <- integer()

pars.cal <- mods$f3$cal$par

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

# Cal f7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same but improve some starting estimates, hoping some extreme pars are local minima
# Settings
ps <- 'f7'
print(ps)
fixed <- integer()

pars.cal <- mods$f6$cal$par
pars.cal['incorp.deep.r3'] <- -0.5
pars.cal['incorp.shallow.r3'] <- 0
pars.cal['incorp.deep.f4'] <- -2
pars.cal['incorp.shallow.f4'] <- -0.5
pars.cal['man.ph.r1'] <- 0.7
pars.cal['man.ph.r3'] <- 0.1
pars.cal['app.mthd.cs.f0'] <- -4
pars.cal['rain.rate.r5'] <- 0.3

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

# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Manually set starting values, and use limits?
# These values from an older "f9"
# Settings
ps <- 'f8'
print(ps)
fixed <- integer()

pars.cal <- c(
  int.f0 = -0.080296560,
  app.mthd.os.f0 = -2.593071,
  app.rate.ni.f0 = -0.0202197,
  man.dm.f0 = 0.40205,
  man.source.pig.f0 = -0.97309,
  app.mthd.cs.f0 = -7.4823,
  int.r1 = -1.2692,
  app.mthd.bc.r1 = 0.4945,
  man.dm.r1 = -0.0955290,
  air.temp.r1 = 0.08569,
  app.mthd.ts.r1 = -0.653678,
  man.ph.r1 = 0.95401,
  int.r2 = -1.973,
  rain.rate.r2 = 0.78398,
  int.r3 = -2.8579,
  app.mthd.bc.r3 = 0.67081,
  app.mthd.cs.r3 = -0.2693,
  man.ph.r3 = 0.0945944,
  incorp.shallow.f4 = -1.09220,
  incorp.shallow.r3 = -0.286370,
  incorp.deep.f4 = -1.49060,
  incorp.deep.r3 = -0.9927,
  int.r5 = -2.0482,
  rain.rate.r5 = 0.633341,
  wind.sqrt.r1 = 1.43227)

# Same weights
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

# Cal f9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try average air temp effect on r3 
# Settings
ps <- 'f9'
print(ps)
fixed <- integer()

pars.cal <- mods$f8$cal$par
pars.cal['air.temp.ave.r3'] <- 0.001

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

# Cal f10 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try again to improve fit with more weighting of final emission
# Settings
ps <- 'f10'
print(ps)
fixed <- integer()

pars.cal <- mods$f8$cal$par

ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]


# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 6 / 1, time.name = 'cta',
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










#dpreds.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]
#dp168.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]

#dp168w <- dcast(dp168.plot, inst + institute + country + exper + pmid + uptake + man.source + man.source.pig + pig.nm + app.mthd + incorp + incorp.nm + app.mthd.nm + digested + digested.nm + acid + acid.nm + man.dm + man.ph + air.temp.24 + wind.2m.24 + er ~ pars + dataset, value.var = 'er.pred')



#cvsumm[, `:=` (pig.nm = factor(ifelse(man.source == 'pig', 'Pig', 'Cattle &\nothers'), levels = c('Pig', 'Cattle &\nothers')),
#               app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
#                              labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
#					 'Open slot\ninjection', 'Closed slot\ninjection')),
#                    incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]

cvsumm[, `:=` (pig.nm = factor(ifelse(man.source, 'Pig', 'Cattle &\nothers'), levels = c('Pig', 'Cattle &\nothers')),
               app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                              labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
					 'Open slot\ninjection', 'Closed slot\ninjection')))]

ggplot(cvsumm, aes(app.mthd.nm, ererr, shape = pig.nm, colour = pig.nm)) + 
  geom_point(size = 4) +
  theme_bw() +
  coord_cartesian(ylim = c(0, NA))  +
  labs(x = 'Application method', y = 'Ave. emission error (frac. TAN)', colour = 'Slurry type', shape = 'Slurry type')
ggsave2x('../plots-cv/cross_val_error', height = 3.3, width = 7)


ggplot(cvsumm, aes(app.mthd.nm, rerr, shape = pig.nm, colour = pig.nm)) + 
  geom_point(size = 4) +
  theme_bw() +
  coord_cartesian(ylim = c(0, NA)) +
  labs(x = 'Application method', y = 'Ave. emission error (frac. meas.)', colour = 'Slurry type', shape = 'Slurry type')
ggsave2x('../plots-cv/cross_val_rel_error', height = 3.3, width = 7)

# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try again but with app.mthd.cs.f0 this time (had mistakenly omitted above)
# Settings
ps <- 'f8'
print(ps)
fixed <- integer()

pars.cal <- mods$f7$cal$par
pars.cal['app.mthd.cs.f0'] <- -4

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


# Cal f9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try again but start with smaller rain r5 effect to remove shoulders in AU curves caused by small amount of rain
# Settings
ps <- 'f9'
print(ps)
fixed <- integer()

pars.cal <- mods$f8$cal$par
pars.cal['rain.rate.r5'] <- 0.3

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


# Cal c1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Now add bc (comes with deep incorporation)
# Settings
ps <- 'c1'
print(ps)
pars.cal <- mods$th5$cal$par
pars.cal['incorp.deep.r3'] <- ALFAM2::alfam2pars02['incorp.deep.r3']
pars.cal['incorp.deep.f4'] <- ALFAM2::alfam2pars02['incorp.deep.f4']
pars.cal['app.mthd.bc.r1'] <- ALFAM2::alfam2pars02['app.mthd.bc.r1']
pars.cal['app.mthd.bc.r3'] <- ALFAM2::alfam2pars02['app.mthd.bc.r3']

caldat <- idat1[app.mthd %in% c('bsth', 'bc'), ]

fixed <- integer()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(caldat), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = caldat, to = c('er', 'er'), wr = 4 / 1, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = caldat[, .(weight.last, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal c2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# c1 performs very poorly. Try starting with ps2 again.
# Settings
ps <- 'c2'
print(ps)
pars.cal <- ALFAM2::alfam2pars02
pars.cal <- pars.cal[!names(pars.cal) %in% c('ts.cereal.hght.r1')]
pars.cal['int.r5'] <- -1.5
pars.cal['rain.rate.r5'] <- 1.0

fixed <- integer()

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








# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Try more weight to er
# Settings
ps <- 'f2'
fixed <- integer()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove shallow incorp r3 effect, wrong direction
# Settings
ps <- 'f3'
fixed <- integer()
pars.cal <- pars.cal[names(pars.cal) != 'incorp.shallow.r3']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 3, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same except use only final emission as reponse
# Settings
ps <- 'f4'
fixed <- integer()
pars.cal <- mods$f3$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove rain r5
# Settings
ps <- 'f5'
fixed <- integer()
pars.cal <- mods$f4$cal$par
pars.cal <- pars.cal[names(pars.cal) != 'rain.rate.r5']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
# NTS: increase iterations later!
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove pH effect for injection
# Settings
ps <- 'f6'
fixed <- integer()
pars.cal <- mods$f5$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
# NTS: increase iterations later!
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Polish f5
# Settings
ps <- 'f7'
fixed <- integer()
pars.cal <- mods$f5$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Polish f4
# Settings
ps <- 'f8'
fixed <- integer()
pars.cal <- mods$f4$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Remove rain r5
# Settings
ps <- 'f9'
fixed <- integer()
pars.cal <- mods$f8$cal$par
pars.cal <- pars.cal[names(pars.cal) != 'rain.rate.r5']

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f10 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Start with best fit, f7, add r5 rain effect in
# Settings
ps <- 'f10'
fixed <- integer()
pars.cal <- mods$f7$cal$par
pars.cal['rain.rate.r5'] <- 0.01

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f11 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Polish f10
# Settings
ps <- 'f11'
fixed <- integer()
pars.cal <- mods$f10$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'er', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                          weights = idat1[, weight.last], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f12 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Refining f11, add a little weight to flux to improve flux comparison
# Settings
ps <- 'f12'
fixed <- integer()
pars.cal <- mods$f11$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
plot(weight.1 ~ cta, data = idat1)
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 10, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit1))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f13 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Square root transformation for wind
# Settings
ps <- 'f13'
fixed <- integer()
pars.cal <- mods$f12$cal$par
names(pars.cal) <- gsub('wind\\.2m', 'wind.sqrt', names(pars.cal))

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
plot(weight.1 ~ cta, data = idat1)
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 10, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.1)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f14 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Weight only last er and add weight to flux
# Settings
ps <- 'f14'
fixed <- integer()
pars.cal <- mods$f13$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
plot(weight.1 ~ cta, data = idat1)
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('j', 'er'), wr = 1 / 6, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.j, weight.last)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())

# Cal f15 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Weight last er and all er separately
# Settings
ps <- 'f15'
fixed <- integer()
pars.cal <- mods$f13$cal$par

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.cal, fixed), flatout = TRUE)
# Should be no warning about pars (none dropped)
# Should be no NA in output
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
plot(weight.1 ~ cta, data = idat1)
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalcComb(p = par, dat = idat1, to = c('er', 'er'), wr = 1 / 4, time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                          weights = idat1[, .(weight.1, weight.last)], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = maxit3))

# Save pars
pp <- c(m$par, fixed)
mods[[ps]][['coef']] <- pp 

# Echo pars and other model info
print(pp)
print(m)

print(Sys.time())




head(idat1)
x <- idat1[pmid == 1500, ][1:5, ]
x <- idat1[pmid == 1500, ]
x$cta
x
x$incorp.shallow

y <- ALFAM2:::prepIncorp(x, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]

undebug(ALFAM2:::prepIncorp)

table(dp168$pmid, dp168$pars, dp168$dataset)
plot(air.temp.log ~ air.temp, data = idat1)

names(mods)
boxplot(idat1$j.NH3)

x <- dpreds[country == 'NL' & pars %in% c('ps1', 'ps2', 'f3', 'f4') & dataset == 1, ]
y <- subset(x, country == 'NL' & app.mthd == 'os')
unique(x$pmid)


ggplot(y, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('x.png', height = 20, width = 8)

ggplot(y, aes(cta, r1.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

ggplot(y, aes(cta, f.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f0.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

pp





#dp168w <- dcast(dp168.plot, inst + institute + country + exper + pmid + uptake + man.source + man.source.pig + pig.nm + app.mthd + incorp + incorp.nm + app.mthd.nm + digested + digested.nm + acid + acid.nm + man.dm + man.ph + air.temp.24 + wind.2m.24 + er ~ pars + dataset, value.var = 'er.pred')

# Cal f1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f1'
fixed <- integer()

pars.cal <- c(int.f0 = 0.36, 
              int.r1 = -1.3, 
              int.r2 = -1.7, 
              int.r3 = -2.4, 
              int.r5 = -1.6, 
              app.mthd.os.f0 = -3.0,
              app.mthd.cs.f0 = -7.6,
              app.mthd.bc.r1 = 1.3,
              app.mthd.ts.r1 = -0.53,
              app.mthd.bc.r3 = 0.53,
              app.mthd.cs.r3 = -0.29,
              man.dm.f0 = 0.28,
              man.dm.r1 = -0.19,
              app.rate.ni.f0 = -0.04,
              man.source.pig.f0 = -1.31,
              air.temp.r1 = 0.13,
              wind.2m.r1 = 0.56,
              rain.rate.r2 = 0.53,
              rain.rate.r5 = 0.84,
              incorp.shallow.f4 = -1.0,
              incorp.shallow.r3 = -1.27,
              incorp.deep.f4 = 3.0,
              incorp.deep.r3 = -1.7,
              man.ph.r1 = 0.5,
              man.ph.r3 = 0.2)

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
                                  resCalc(p = par, dat = idat1, to = 'j', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.j], flatout = TRUE),
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
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 1 as well
idat1[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

print(Sys.time())


# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f2'
fixed <- integer()

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
                                  resCalc(p = par, dat = idat1, to = 'e.int', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.j], flatout = TRUE),
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
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 1 as well
idat1[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

print(Sys.time())


# Cal xx ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x <- dpreds[country == 'NL' & pars %in% c('ps1', 'ps2', 'f3') & dataset == 1, ]
y <- subset(x, country == 'NL' & app.mthd == 'cs')
unique(x$pmid)


ggplot(y, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, r1.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f0.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

m

ggplot(dd, aes(wind.2m, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  theme_bw()

ggplot(dd, aes(air.temp, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.1) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  coord_cartesian(ylim = c(-0.5, 0.5))


ggplot(ddf, aes(air.temp, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()

ggplot(ddf, aes(wind.2m, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()


