# Process ALFAM2 output (get derivatives)

# Derivatives
pdat[, dedx := c(NA, diff(er.pred) / diff(xval)), by = .(set, man.source, app.mthd, parset)]

# Get quantiles
qdat <- pdat[!is.na(dedx) & parset != '3', .(n = length(dedx), dedx10 = quantile(dedx, 0.1), dedx90 = quantile(dedx, 0.9), dedxmd = median(dedx)), 
             by = .(ct, man.dm, wind.2m, app.rate.ni, man.ph, tan.app, man.source, air.temp, app.mthd, id, set, xval, id.pred)]
