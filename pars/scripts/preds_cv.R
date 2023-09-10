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

cvdat[, dataset := 1]

# Merge in measurements
# Note that without 'by = ' 40 pmid are lost, maybe dt mismatch?
cvdat <- merge(idat1[, c('pmid', 'cta', 'cta.168', 'j', 'e.cum', 'er')], cvdat, by = c('pmid', 'cta'))

cvdat[, ererr := er.pred - er]
cvdat[, rerr := (er.pred - er) / er]

# Get quantiles for 168 hr emission only
cvdat <- merge(pdat, cvdat, by = 'pmid', suffixes = c('', '.cv'))
cvsumm <- cvdat[cta == cta.168 & !is.na(er.pred), .(n = length(er.pred), 
						       er = er[1], er10 = quantile(er.pred, 0.1), 
                                                  er90 = quantile(er.pred, 0.9), ermed = median(er.pred),
						  ererr = mean(abs(ererr)), rerr = mean(abs(ererr)) / mean(er)), 
             by = .(app.mthd, man.source == 'pig')]

