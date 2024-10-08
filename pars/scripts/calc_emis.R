# Generate predictions for all par sets
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.

# Fill in missing pH in idat2
idat2[is.na(man.ph), man.ph := man.ph.default]

# First main calibration sets
# 1 and 2 correspond to datasets idat1 and idat2
dpreds1 <- dpreds2 <- data.table()
for (i in 1:length(mods)) {
  pp <- mods[[i]][['coef']]

  preds <- as.data.table(alfam2(idat1, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', center = c(man.dm.app.mthd.bc = 6), flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(mods)[i]
  dpreds1 <- rbind(dpreds1, preds)

  preds <- as.data.table(alfam2(idat2, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', center = c(man.dm.app.mthd.bc = 6), flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(mods)[i]
  dpreds2 <- rbind(dpreds2, preds)

}

# Also for earlier default parameter sets 1 and 2 for comparison
defpars <- list(ps1 = ALFAM2::alfam2pars01, ps2 = ALFAM2::alfam2pars02)
for (i in 1:length(defpars)) {
  pp <- defpars[[i]]

  preds <- as.data.table(alfam2(idat1, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', center = c(man.dm.app.mthd.bc = 6), flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(defpars)[i]
  dpreds1 <- rbind(dpreds1, preds)

  preds <- as.data.table(alfam2(idat2, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', center = c(man.dm.app.mthd.bc = 6), flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(defpars)[i]
  dpreds2 <- rbind(dpreds2, preds)

}

# Add dataset key
dpreds1[, dataset := 1]
dpreds2[, dataset := 2]

# Merge in measurements (but not all idat* columns, to avoid massive object)
# Note that without 'by = ' 40 pmid are lost, maybe dt mismatch?
dpreds1 <- merge(idat1[, c('pmid', 'cta', 'man.ph', 'man.dm', 'j', 'er')], dpreds1, by = c('pmid', 'cta'))
dpreds2 <- merge(idat2[, c('pmid', 'cta', 'man.ph', 'man.dm', 'j', 'er')], dpreds2, by = c('pmid', 'cta'))

# Combind data sets idat1 and idat2
dpreds <- rbindf(dpreds1, dpreds2)

dpreds <- merge(dpreds, pdat[, .(pmid, app.mthd, incorp, time.incorp, man.source, man.trt1, man.trt2, man.trt3, acid, digested, inst, institute, country, air.temp.24, wind.2m.24, meas.tech)], by = 'pmid')

#dpreds2 <- merge(idat1[, c('inst', 'institute', 'country', 'pmid', 'cta', 'cta.168', 'dt', 'app.mthd', 'meas.tech', 'man.trt1', 'man.trt2', 'man.source.pig', 'incorp', 'air.temp.24', 'man.ph', 'man.dm', 'acid', 'digested', 'j', 'e.cum', 'er')], dpreds2, by = c('pmid', 'cta'))

