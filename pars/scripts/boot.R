# Bootstrap pars

pars.cal <- mods$ps3$cal$par * 0.8
fixed <- numeric()

nb <- 25
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
                                    resCalc(p = par, dat = idatsamp, to = 'er', time.name = 'cta',
                                            app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'TAE', 
                                            weights = idatsamp[, weight.1], flatout = TRUE),
                                    method = 'Nelder-Mead', control = list(maxit = maxit1))
  mods.boot[[i]][['coef']] <- c(m$par, fixed)
  
}

# Get boot pars
d.parsb <- data.table()

for(i in 1:length(mods.boot)) {
    pp <- mods.boot[[i]][['coef']]
    pp <- data.table(iteration = i, t(pp))
    d.parsb <- rbindf(d.parsb, pp)
}

fwrite(d.parsb, '../output/pars_boot.csv')

parsbl <- melt(d.parsb, id.vars = 'iteration', variable.name = 'parameter')
parsbl[, parset := paste0('3-', sprintf('%03d', iteration))]

fwrite(parsbl, '../output/pars_boot_long.csv')
##parsbl <- fread('../output/pars_boot_long.csv')

bootsumm <- parsbl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95)), by = parameter]

fwrite(bootsumm, '../output/boot_summary.csv')
