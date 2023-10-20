# Bootstrap pars
# See crossval.R for notes

pars.cal <- mods$ps3$cal$par * 0.8
fixed <- numeric()

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
  mods.boot[[i]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                    resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idatsamp[, .(weight.last, weight.1a)], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = maxit2))

  mods.boot[[i]][['coef']] <- c(m$par, fixed)
  
}
