# Process ALFAM2 output (get derivatives)

# First numeric predictors
# Derivatives
pdat[, dedx := c(NA, diff(er.pred) / diff(xval)), by = .(set, man.source, app.mthd, parset)]

# Get quantiles
qdat <- pdat[!is.na(dedx) & parset != '3', .(n = length(dedx), dedx10 = quantile(dedx, 0.05), dedx90 = quantile(dedx, 0.95), dedxmd = median(dedx)), 
             by = .(ct, man.dm, wind.2m, app.rate.ni, man.ph, tan.app, man.source, air.temp, app.mthd, id, set, xval, id.pred)]

# Then application methods
# Relative differences
pamdat[, rr := (er.pred[app.mthd == 'bc'] - er.pred) / er.pred[app.mthd == 'bc'], by = .(set, man.source, parset)]
# Get quantiles
qamdat <- pamdat[!is.na(rr) & parset != '3', .(n = length(rr), rr10 = quantile(rr, 0.05), rr90 = quantile(rr, 0.95), rrmd = median(rr)), 
             by = .(ct, man.dm, wind.2m, app.rate, man.ph, tan.app, man.source, air.temp, app.mthd, id, set, xval, id.pred)]

# Add limits and cut some extreme bootstrap preds for plots
lims <- data.table(set = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), 
                   ymax = c(0.06, 0.3, 0.025, 0.08, 0.3))
pdat <- merge(pdat, lims, by = 'set')
pdat[dedx > ymax & parset != '3', dedx := NA]
