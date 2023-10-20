# Get boot pars

d.parsb <- data.table()

for(i in 1:length(mods.boot)) {
    pp <- mods.boot[[i]][['coef']]
    pp <- data.table(iteration = i, t(pp))
    d.parsb <- rbindf(d.parsb, pp)
}


# Long version for use elsewhere
parsbl <- melt(d.parsb, id.vars = 'iteration', variable.name = 'parameter')
parsbl[, parset := paste0('3-', sprintf('%03d', iteration))]

# Summarize
bootsumm <- parsbl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95)), by = parameter]

# Export
fwrite(d.parsb, '../output/pars_boot.csv')
fwrite(parsbl, '../output/pars_boot_long.csv')
fwrite(bootsumm, '../output/boot_summary.csv')
