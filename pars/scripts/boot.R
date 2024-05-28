# Bootstrap pars
# See crossval.R for notes

clstr <- parallel::makeCluster(parallel::detectCores(), type = 'FORK') 
registerDoParallel(cl = clstr)

pars.start.main <- mods$ps3$optim$par
fixed.main <- c(int.r5 = -1.8, man.ph.r3 = 0.05)

nb <- 100
inst.all <- unique(idat1[, inst])
mods.boot <- list()

idat1sel <- idat1[, ..parestcols]

#set.seed(123) 

mods.boot <- foreach (i = 1:nb) %dorng% {

  cat('\n')
  cat('\n')
  print(Sys.time())
  cat('Iteration ', rep(i, 10))
  cat('\n')
  cat('\n')
  # Sample institutes
  inst.samp <- sort(sample(inst.all, length(inst.all), replace = TRUE))

  # Iteration number etc.
  v <- 1
  idatsamp <- data.table()
  for (ii in inst.samp) {
    x <- idat1sel[inst == ii]
    x[, pmid := paste0(v, '-', pmid)]
    idatsamp <- rbind(idatsamp, x)
    v <- v + 1
  }

  pars.start <- pars.start.main
  fixed <- fixed.main

  # Move missing application methods to fixed pars
  am <- paste0('app.mthd.', unique(idatsamp$app.mthd))
  ampars <- names(pars.start)[grepl('app\\.mthd', names(pars.start))]
  ampars <- unique(gsub('\\.[rf][0-5]$', '', ampars))
  missingam <- ampars[! ampars %in% am] 
  if (length(missingam) > 0) {
    cat('\nDropping application methods: ', missingam, '\n')
    pars.start <- pars.start[!gsub('\\.[rf][0-5]$', '', names(pars.start)) %in% missingam]
    fixed <- c(fixed, pars.start.main[gsub('\\.[rf][0-5]$', '', names(pars.start.main)) %in% missingam])
  }

  # Move missing incorporation methods to fixed pars
  im <- paste0('incorp.', unique(idatsamp$incorp))
  impars <- names(pars.start)[grepl('incorp', names(pars.start))]
  impars <- unique(gsub('\\.[rf][0-5]$', '', impars))
  missingim <- impars[! impars %in% im] 
  if (length(missingim) > 0) {
    cat('\nDropping incorporation methods: ', missingim, '\n')
    pars.start <- pars.start[!gsub('\\.[rf][0-5]$', '', names(pars.start)) %in% missingim]
    fixed <- c(fixed, pars.start.main[gsub('\\.[rf][0-5]$', '', names(pars.start.main)) %in% missingim])
  }

  # Remove rain pars if rain doesn't vary
  if (diff(range(idatsamp[, rain.rate])) == 0) {
    cat('\nDropping rain parameters.\n')
    pars.start <- pars.start[!grepl('rain', names(pars.start))]
    fixed <- c(fixed, pars.start.main[grepl('rain', names(pars.start.main))])
  }

  # Par estimation
  output <- list()
  output[['inst']] <- inst.samp
  output[['optim']] <- m <- optim(par = pars.start, fn = function(par) 
                                          resCalcComb(p = par, dat = idatsamp, to = c('er', 'j'), wr = 4 / 1, time.name = 'cta',
                                                  app.name = 'tan.app', group = 'pmid', fixed = fixed, method = 'SS', 
                                                  weights = idatsamp[, .(weight.lastc, weight.1c)], flatout = TRUE),
                                          method = 'Nelder-Mead', control = list(maxit = maxit2))

  output[['coef']] <- c(m$par, fixed)
  output[['inst.samp']] <- inst.samp
  
  output

}
