# Grouped leave-one-out cross-validation (LOOCV)

# Change starting pars to avoid getting something similar to ps3 back
# With this correction and maxit limit below this approach would tend to return poorer fit than possible and so overestimate error
# Better approach is to use more iterations below (maxit = maxit3)
pars.cal <- mods$ps3$cal$par * 0.8
fixed <- numeric()

# Get institutions
insts <- unique(idat1[, inst])

# Empty list for holding output
mods.cv <- list()

set.seed(123) 

for (i in insts) {
  ic <- as.character(i)
  cat('\n')
  print(Sys.time())
  cat('Institution dropped ', rep(i, 10))
  cat('\n')

  # Drop institution
  idatsamp <- idat1[inst != i, ]

  # Parameter estimation
  mods.cv[[ic]] <- list()
  mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                    resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idatsamp[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = maxit2))
  
  pp <- c(m$par, fixed)
  cat('\n')
  print(pp)

  mods.cv[[ic]][['coef']] <- pp
  
}
