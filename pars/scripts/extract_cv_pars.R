# Get cv pars

d.parscv <- data.table()

for(i in 1:length(mods.cv)) {
    pp <- mods.cv[[i]][['coef']]
    pp <- data.table(inst.dropped = i, t(pp))
    d.parscv <- rbindf(d.parscv, pp)
}

parscvl <- melt(d.parscv, id.vars = 'inst.dropped', variable.name = 'parameter')
parscvl[, parset := paste0('3-d', inst.dropped)]

cvparsumm <- parscvl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95), min = min(value), max = max(value)), by = parameter]

# Export
fwrite(d.parscv, '../output/pars_cv.csv')
fwrite(parscvl, '../output/pars_cv_long.csv')
fwrite(cvparsumm, '../output/cv_par_summary.csv')


