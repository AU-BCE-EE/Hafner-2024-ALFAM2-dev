# Apply bootstrap parameters through ALFAM2 model to get uncertainty in predictions

#parsbl <- fread('../output/pars_boot_long.csv')

bpdat <- data.table()

for (i in unique(parsbl[, parset])) {

  cat(i, ', ')
  d <- parsbl[parset == i, ]
  pars <- d[, value]
  names(pars) <- d[, parameter]

  preds <- data.table(ALFAM2mod(idat3, app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pars, flatout = TRUE))

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  bpdat <- rbind(bpdat, cbind(idat3, preds))

  dim(bpdat)
}
