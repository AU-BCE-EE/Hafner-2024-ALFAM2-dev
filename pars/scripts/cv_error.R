# Calculate model error from cross-validation results

# Merge in measurements
# Note that without 'by = ' 40 pmid are lost, maybe dt mismatch?
cvdat <- merge(idat1[, c('pmid', 'cta', 'j', 'er')], cvdat, by = c('pmid', 'cta'))

# Get cta closest to 24 and 168 hours to use these times for model evaluation
cvdat[, cta.168 := cta[which.min(abs(cta - 168))], by = pmid]
cvdat[, cta.24 := cta[which.min(abs(cta - 24))], by = pmid]

cvdat[, dataset := 1]

cvdat[, `:=` (ererr = er.pred - er, rerr = (er.pred - er) / er)]
cvdat <- merge(pdat, cvdat, by = 'pmid', suffixes = c('', '.cv'))
cvdat168 <- cvdat[cta == cta.168, ]

# Get quantiles for 168 hr emission only
cverrsumm1 <- cvdat[cta == cta.168 & !is.na(er.pred), .(n = length(er.pred), 
                                                       ererr = median(ererr),
                                                       aererr = median(abs(ererr)), 
                                                       arerr = median(abs(rerr)),
                                                       ererrse = sd(ererr), 
                                                       ersd = sd(er)), 
               by = app.mthd]

cverrsumm2 <- cvdat[cta == cta.168 & !is.na(er.pred), .(n = length(er.pred), 
                                                       ererr = median(ererr),
                                                       aererr = median(abs(ererr)), 
                                                       arerr = median(abs(rerr)),
                                                       ererrse = sd(ererr), 
                                                       ersd = sd(er)), 
               by = .(app.mthd, incorp, man.source == 'pig')]


cverrsumm1 <- cverrsumm1[order(app.mthd), ]
cverrsumm2 <- cverrsumm2[order(app.mthd, man.source), ]

# Export
fwrite(cverrsumm1, '../output/cv_error_summary1.csv')
fwrite(cverrsumm2, '../output/cv_error_summary2.csv')
