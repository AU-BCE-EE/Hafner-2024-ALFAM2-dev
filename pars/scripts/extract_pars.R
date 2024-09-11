# Extract parameter values, organize in data table

d.pars <- data.table()

for(i in 1:length(mods)) {
    pp <- mods[[i]]$coef
    pp <- data.table(pars = names(mods)[[i]], t(pp))
    d.pars <- rbind(d.pars, pp, fill = TRUE)
}

# Add par sets 1 and 2
d1 <- data.table(pars = 'ps1', t(alfam2pars01))
d2 <- data.table(pars = 'ps2', t(alfam2pars02))
d.pars <- rbind(d.pars, d1, d2, fill = TRUE)

# Reshape for plotting 
parsl <- melt(d.pars, id.vars = 'pars', variable.name = 'parameter')

# Add in par set 3 value to boot parts for comparison
ps3 <- parsl[pars == 'ps3', ]
parsbl3 <- merge(parsbl, ps3[, -1], by = 'parameter', suffixes = c('', '.ps3'))
bootsumm3 <- parsbl3[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95), fps3 = mean(value == value.ps3)), by = parameter]

# Export
fwrite(d.pars, '../output/pars.csv')
fwrite(parsl, '../output/pars_long.csv')
fwrite(parsbl3, '../output/pars_boot_long_ps3.csv')
fwrite(bootsumm, '../output/boot_summary_ps3.csv')
