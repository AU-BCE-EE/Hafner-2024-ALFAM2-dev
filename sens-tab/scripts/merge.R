# Merge in predictions

pr0[, pars := 'ALFAM']
pr1[, pars := 'ps01']
pr2[, pars := 'ps02']
pr3[, pars := 'ps03']
preds <- rbind(pr0, pr1, pr2, pr3, fill = TRUE)

# Get boot results
# 90% CI
bootsumm <- bootdat[ct == 168, .(n = length(er), 
				 lwr = quantile(er, 0.05, na.rm = TRUE), 
				 upr = quantile(er, 0.95, na.rm = TRUE)), by = .(sida)]
bootsumm[, pars := 'ps03']

dd <- merge(dat, preds, by = c('sida', 'ct'))
dd <- merge(dd, bootsumm, by = c('sida', 'pars'), all.x = TRUE)
dat168 <- dd[ct == 168, ]


