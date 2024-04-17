# Grouped leave-one-out cross-validation (LOOCV)

# Parallel
clstr <- parallel::makeCluster(parallel::detectCores(), type = 'FORK') 
registerDoParallel(cl = clstr)

# Change starting pars to avoid getting something similar to ps3 back
# With this correction and maxit limit below this approach would tend to return poorer fit than possible and so overestimate error
# Better approach is to use more iterations below (maxit = maxit3)
pars.start <- mods$ps3$optim$par * 0.9
pars.start['app.mthd.cs.f0'] <- -5
fixed <- c(int.r5 = -1.8)

lower <- c(
  int.f0 = -2,
  app.mthd.os.f0 = -5,
  app.rate.ni.f0 = -0.5,
  man.dm.f0 = -1,
  man.source.pig.f0 = -3,
  app.mthd.cs.f0 = -12,
  int.r1 = -3,
  app.mthd.bc.r1 = -1,
  man.dm.r1 = -1,
  air.temp.r1 = -1,
  wind.sqrt.r1 = -1,
  app.mthd.ts.r1 = -2,
  man.ph.r1 = -1,
  int.r2 = -3,
  rain.rate.r2 = -1,
  int.r3 = -4,
  app.mthd.bc.r3 = -1,
  app.mthd.cs.r3 = -2,
  man.ph.r3 = -1,
  incorp.shallow.f4 = -5,
  incorp.shallow.r3 = -2,
  incorp.deep.f4 = -5,
  incorp.deep.r3 = -2,
  rain.rate.r5 = -1)

upper <- c(
  int.f0 = 4,
  app.mthd.os.f0 = 5,
  app.rate.ni.f0 = 0.5,
  man.dm.f0 = 2,
  man.source.pig.f0 = 1,
  app.mthd.cs.f0 = 1,
  int.r1 = 2,
  app.mthd.bc.r1 = 1,
  man.dm.r1 = 0.2,
  air.temp.r1 = 0.2,
  wind.sqrt.r1 = 2,
  app.mthd.ts.r1 = 1,
  man.ph.r1 = 1,
  int.r2 = 0,
  rain.rate.r2 = 1,
  int.r3 = 0,
  app.mthd.bc.r3 = 1,
  app.mthd.cs.r3 = 0.5,
  man.ph.r3 = 1,
  incorp.shallow.f4 = 0,
  incorp.shallow.r3 = 0,
  incorp.deep.f4 = 0,
  incorp.deep.r3 = 0,
  rain.rate.r5 = 1)


# Get institutions
insts <- unique(idat1[, inst])

# Empty list for holding output
mods.cv <- list()

set.seed(123) 

mods.cv <- foreach (i = insts) %dorng% {

  ic <- as.character(i)

  cat('\n')
  print(Sys.time())
  cat('Institution dropped ', rep(i, 10))
  cat('\n')

  # Drop institution
  idatsamp <- idat1[inst != i, ]

  # Parameter estimation
  output <- list()
  mods[[ps]][['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                    resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idatsamp[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                    method = 'L-BFGS-B', lower = lower, upper = upper, control = list(maxit = maxit2))
  
  pp <- c(m$par, fixed)
  cat('\n')
  print(pp)

  output[['coef']] <- pp

  output
  
}
