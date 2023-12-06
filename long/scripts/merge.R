# Add digestion to pdat
pdat[, digested := grepl('[Dd]igest', paste(man.trt1, man.trt2))]
idat[, rain.missing := FALSE]
pdat[, man.ph.missing := FALSE]

# To help with rbind() later

# Add institute x experiment
pdat[, iexper := paste(inst, exper)]

# Merge pdat and idat
idat <- merge(pdat, idat, by = c('pid', 'pmid'))


