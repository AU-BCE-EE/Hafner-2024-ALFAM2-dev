# Grouped LOOCV (cross-validation)

# Don't even try with some parameters with few measurement data or low stability
nm.fixed <-'incorp|rain.rate' 
pars.prev <- mods[['ps3']][['cal']][['par']]
pars.cal <- pars.prev[!grepl(nm.fixed, names(pars.prev))]
fixed <- pars.prev[grepl(nm.fixed, names(pars.prev))]

insts <- unique(idat1[, inst])
mods.cv <- list()

set.seed(123) 

dpreds1cv <- copy(dpreds1)

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
  mods.cv[[ic]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                    resCalc(p = par, dat = idatsamp, to = 'er', time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                            weights = idatsamp[, weight.last], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = 30000))

  pp <- c(m$par, fixed)
  pp <- c(pp, app.rate.app.mthd.inj.f0 = - pp[['app.rate.f0']], man.dm.app.mthd.inj.f0 = - pp[['man.dm.f0']])
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

fwrite(d.parsb, '../output/pars_cv.csv')

parsbl <- melt(d.parsb, id.vars = 'inst.dropped', variable.name = 'parameter')
parsbl[, parset := paste0('3-d', inst.dropped)]

fwrite(parsbl, '../output/pars_cv_long.csv')
##parsbl <- fread('../output/pars_cv_long.csv')

##cvsumm <- parsbl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95)), by = parameter]
##fwrite(cvsumm, '../output/cv_summary.csv')
