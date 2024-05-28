# Drop predictors to see how much they affect model fit
# No longer stepwise/sequential
# Now parallel too

clstr <- parallel::makeCluster(parallel::detectCores(), type = 'FORK') 
registerDoParallel(cl = clstr)

# Get ps3 parameters but remove incorp pars
pars.start.main <- mods$ps3$optim$par
pars.start.main <- pars.start.main[!grepl('incorp', names(pars.start.main))]
fixed.main <- c(int.r5 = -1.8, man.ph.r3 = 0.05)

set.seed(030979) 

# Drop all weather, slurry pH and DM, or application method 
dropvals <- c('air.temp|wind|rain', 'man\\.dm|man\\.ph|pig', 'app\\.mthd')

mods.drop <- foreach (i = dropvals) %dorng% {

  fixed <- c(int.r5 = -1.8)
  pars.start <- pars.start.main[!grepl(i, names(pars.start.main))]
  
  # Look for problem observations before parameter estimation by running with all parameters
  pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = c(pars.start, fixed), flatout = TRUE)
  # Should be no warning about pars (none dropped)
  # Should be no NA in output
  if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')
  
  output <- list()
  output[['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                    resCalcComb(p = par, dat = idat1, to = c('er', 'j'), wr = 3 / 1, time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idat1[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = maxit2))
  
  # Save pars
  pp <- c(m$par, fixed)
  output[['coef']] <- pp 

  output
}

# Combine with mods
names(mods.drop) <- c('dropweather', 'dropprop', 'dropapp')
mods <- c(mods, mods.drop)
