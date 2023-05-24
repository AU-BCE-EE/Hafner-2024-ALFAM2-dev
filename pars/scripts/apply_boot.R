# Apply bootstrap parameters through ALFAM2 model to get uncertainty in predictions

bpdat <- data.table()

for (i in unique(parsbl[, parset])) {

  d <- parsbl[parset == i, ]
  pars <- d[, value]
  names(pars) <- d[, parameter]

  preds <- data.table(ALFAM2mod(idat3, app.name = 'tan.app', time.name = 'ct', group = 'pmid', pars = pars, flatout = TRUE))
  preds <- preds[ct == 168]

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  bpdat <- rbind(bpdat, cbind(idat3, preds))

}
