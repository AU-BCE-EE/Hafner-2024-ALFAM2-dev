# Grouped LOOCV (cross-validation)

# Don't even try with some parameters with few measurement data or low stability
nm.fixed <-'incorp|rain.rate.2|int.f0' 
pars.prev <- mods[['ps3']][['cal']][['par']]
pars.cal <- pars.prev[!grepl(nm.fixed, names(pars.prev))]
fixed <- pars.prev[grepl(nm.fixed, names(pars.prev))]

insts <- unique(idat3[, inst])
mods.cv <- list()

set.seed(123) 

for (i in insts) {

  cat('\n')
  cat('\n')
  print(Sys.time())
  cat('Institution dropped ', rep(i, 10))
  cat('\n')
  cat('\n')

  # Drop institution
  idatsamp <- idat1[inst != i, ]

  # Calibration
  mods.cv[[i]] <- list()
  mods.cv[[i]][['inst']] <- inst.samp
  mods.cv[[i]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                    resCalc(p = par, dat = idatsamp, to = 'er', time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                            weights = idatsamp[, weight.1], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = 30000))
  mods.cv[[i]][['coef']] <- c(m$par, fixed)
  
}

# Get cv pars
d.parsb <- data.table()

for(i in 1:length(mods.cv)) {
    pp <- mods.cv[[i]][['coef']]
    pp <- data.table(inst.dropped = i, t(pp))
    d.parsb <- rbindf(d.parsb, pp)
}

fwrite(d.parsb, '../output/pars_cv.csv')

parsbl <- melt(d.parsb, id.vars = 'inst.dropped', variable.name = 'parameter')
parsbl[, parset := paste0('3-d', inst.dropped)]

fwrite(parsbl, '../output/pars_cv_long.csv')
##parsbl <- fread('../output/pars_cv_long.csv')

##cvsumm <- parsbl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95)), by = parameter]
##fwrite(cvsumm, '../output/cv_summary.csv')
