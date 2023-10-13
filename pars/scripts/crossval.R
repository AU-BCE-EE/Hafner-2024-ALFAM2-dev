# Grouped LOOCV (cross-validation)

# Change starting pars to avoid getting something similar to ps3 back
# With this correction and maxit limit below this approach would tend to return poorer fit than possible and so overestimate error
# Better approach is to use more iterations below
pars.cal <- mods$ps3$cal$par * 0.8
fixed <- numeric()

# Set weights to match those in ps3
ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.last.b = weight.last * ww[app.mthd], weight.1.b = weight.1 * ww[app.mthd])]

insts <- unique(idat1[, inst])
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

  # Calibration
  mods.cv[[ic]] <- list()
  mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                    resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idatsamp[, .(weight.last.b, weight.1.b)], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = maxit2))
  
  pp <- c(m$par, fixed)
  cat('\n')
  print(pp)

  mods.cv[[ic]][['coef']] <- pp
  
}


# Get cv pars
d.parscv <- data.table()

for(i in 1:length(mods.cv)) {
    pp <- mods.cv[[i]][['coef']]
    pp <- data.table(inst.dropped = i, t(pp))
    d.parscv <- rbindf(d.parscv, pp)
}

parscvl <- melt(d.parscv, id.vars = 'inst.dropped', variable.name = 'parameter')
parscvl[, parset := paste0('3-d', inst.dropped)]

cvparsumm <- parscvl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95), min = min(value), max = max(value)), by = parameter]
