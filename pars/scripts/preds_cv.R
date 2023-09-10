# Generate predictions for all cross-validation par sets
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.

# Fill in missing pH
idat2[is.na(man.ph), man.ph := 7]

i <- 1
# First main calibration sets
dpredscv1 <- dpredscv2 <- data.table()
for (i in 1:length(mods.cv)) {
  pp <- mods.cv[[i]][['coef']]

  preds <- as.data.table(alfam2(idat1, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(mods.cv)[i]
  dpredscv1 <- rbind(dpredscv1, preds)

  preds <- as.data.table(alfam2(idat2, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', flatout = TRUE))
  names(preds)[-1:-3] <- paste0(names(preds)[-1:-3], '.pred')
  preds$pars <- names(mods.cv)[i]
  dpredscv2 <- rbind(dpredscv2, preds)

}

dpredscv1[, dataset := 1]
dpredscv2[, dataset := 2]

# Merge in measurements
# Note that without 'by = ' 40 pmid are lost, maybe dt mismatch?
dpredscv1 <- merge(idat1[, c('pmid', 'cta', 'cta.168', 'j', 'e.cum', 'er')], dpredscv1, by = c('pmid', 'cta'))

dpredscv2 <- merge(idat1[, c('pmid', 'cta', 'cta.168', 'j', 'e.cum', 'er')], dpredscv2, by = c('pmid', 'cta'))

dpredscv1[, ererr := er.pred - er]

# Get quantiles for 168 hr emission only
cvdat <- dpredscv1[cta == cta.168 & !is.na(er.pred), .(n = length(er.pred), 
						       er = er[1], er10 = quantile(er.pred, 0.1), 
                                                  er90 = quantile(er.pred, 0.9), ermed = median(er.pred),
						  ererr = mean(abs(ererr)), rerr = mean(abs(ererr)) / mean(er)), 
             by = .(pmid, cta)]

cvdat[, `:=` (errange = er90 - er10, rerrange = (er90 - er10) / ermed, rerr = ererr / er)]

cvdat <- merge(pdat, cvdat, by = 'pmid', suffixes = c('', '.cv'))

cvsumm <- cvdat[, .(ererr = mean(ererr), rerr = mean(rerr), ersd = sd(er), rersd = sd(er) / mean(er)), by = .(app.mthd, man.source == 'pig')]
