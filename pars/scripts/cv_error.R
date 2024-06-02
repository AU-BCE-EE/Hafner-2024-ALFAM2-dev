# Calculate model error from cross-validation results

# Merge in measurements
# Note that without 'by = ' 40 pmid are lost, maybe dt mismatch?
cvdat <- merge(idat1[, c('pmid', 'cta', 'j', 'er')], cvdat, by = c('pmid', 'cta'))

# Get cta closest to 24 and 168 hours to use these times for model evaluation
cvdat[, cta.168 := cta[which.min(abs(cta - 168))], by = pmid]
cvdat[, cta.24 := cta[which.min(abs(cta - 24))], by = pmid]

cvdat[, dataset := 1]

#cvdat[, `:=` (ererr = er.pred - er, rerr = (er.pred - er) / er)]
cvdat <- merge(pdat, cvdat, by = 'pmid', suffixes = c('', '.cv'))
cvdat168 <- cvdat[cta == cta.168, ]
names(cvdat168)

fitcv.168 <- cvdat168[, .(rmse = rmse(m = er, p = er.pred),
                          me = me(m = er, p = er.pred),
                          mae = mae(m = er, p = er.pred),
                          mbe = mbe(m = er, p = er.pred),
                          nu = length(unique(pmid)),
                          er.mn = mean(er.pred),
                          er.md = median(er.pred),
                          n = length(er)), ]

fitcv.168.am <- cvdat168[, .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        er.mn = mean(er.pred),
                        er.md = median(er.pred),
                        n = length(er)), by = .(app.mthd)]

# Export
fwrite(fitcv.168, '../output/fit168_cv.csv')
fwrite(fitcv.168.am, '../output/fit168_app_methd_cv.csv')
