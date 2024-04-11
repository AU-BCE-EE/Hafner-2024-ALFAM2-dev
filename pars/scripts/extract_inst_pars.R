# Get inst pars

d.parsinst <- data.table()

for(i in names(mods.inst)) {
    pp <- mods.inst[[i]][['coef']]
    pp <- data.table(inst.dropped = i, t(pp))
    d.parsinst <- rbindf(d.parsinst, pp)
}

parsinstl <- melt(d.parsinst, id.vars = 'inst.dropped', variable.name = 'parameter')
parsinstl[, parset := paste0('3-d', inst.dropped)]

instparsumm <- parsinstl[, .(mn = mean(value), md = median(value), se = sd(value), l90 = quantile(value, 0.05), u90 = quantile(value, 0.95), min = min(value), max = max(value)), by = parameter]

# Export
fwrite(d.parsinst, '../output/pars_inst.csv')
fwrite(parsinstl, '../output/pars_inst_long.csv')
fwrite(instparsumm, '../output/inst_par_summary.csv')


