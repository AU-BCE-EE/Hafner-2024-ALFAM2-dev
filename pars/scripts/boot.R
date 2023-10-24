# Bootstrap pars
# See crossval.R for notes

pars.start <- mods$ps3$optim$par
fixed <- c(int.r5 = -1.8)

nb <- 100
inst.all <- unique(idat1[, inst])
mods.boot <- list()

set.seed(123) 

for (i in 1:nb) {

  cat('\n')
  cat('\n')
  print(Sys.time())
  cat('Iteration ', rep(i, 10))
  cat('\n')
  cat('\n')
  # Sample institutes
  inst.samp <- sort(sample(inst.all, length(inst.all), replace = TRUE))

  v <- 1
  idatsamp <- data.table()
  for (ii in inst.samp) {
    x <- idat1[inst == ii]
    x[, pmid := paste0(v, '-', pmid)]
    idatsamp <- rbind(idatsamp, x)
    v <- v + 1
  }

  # Calibration
  mods.boot[[i]] <- list()
  mods.boot[[i]][['inst']] <- inst.samp
  mods.boot[[i]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                          resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                                  app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                                  weights = idatsamp[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                          method = 'Nelder-Mead', control = list(maxit = maxit1))

  mods.boot[[i]][['coef']] <- c(m$par, fixed)
  
}
