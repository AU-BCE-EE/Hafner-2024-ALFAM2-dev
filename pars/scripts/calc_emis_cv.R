# Generate predictions for all cross-validation par sets
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.

cvdat <- data.table()
for (i in 1:length(mods.cv)) {
  pp <- mods.cv[[i]][['coef']]
  dd <- idat1[inst == names(mods.cv)[i], ]

  preds <- as.data.table(alfam2(dd, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(mods.cv)[i]
  cvdat <- rbind(cvdat, preds)

}


