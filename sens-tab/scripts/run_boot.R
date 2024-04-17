# NTS: use flatout? have to prep for incorp

bootdat <- data.table()

for (i in unique(pars03boot[, parset])) {
  cat(i, '\n')
  pp <- pars03boot[parset == i, value]
  names(pp) <- pars03boot[parset == i, parameter]

  prb <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
                group = 'sida', pars = pp, flatout = TRUE, warn = FALSE)
  prb <- data.table(prb)
  prb[, pars := i]
  bootdat <- rbind(bootdat, prb)

}
