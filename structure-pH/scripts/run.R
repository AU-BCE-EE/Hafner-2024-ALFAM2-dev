
# Apply ALFAM2 model to pmid 1529 through 1532

idatp <- subset(idat, pmid %in% c(1529:1532))
preds <- alfam2(idatp, pars = pars03, time.name = 'cta', app.name = 'tan.app', time.incorp = 'time.incorp', group = 'pmid', prep.dum = TRUE)
idatp[, e.rel.pred := preds$er]
idatp[, j.NH3.pred := preds$j]

pdatp <- subset(pdat, pmid %in% c(1529:1532))
pdatp$tan.app
