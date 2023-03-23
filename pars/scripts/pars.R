# Extract parameter values

d.pars <- data.table()

for(i in 1:length(mods)) {
    pp <- mods[[i]]$coef
    pp <- data.table(pars = names(mods)[[i]], t(pp))
    d.pars <- rbindf(d.pars, pp)
}

# Add par sets 1 and 2
pp <- data.table(pars = 'ps1', t(ALFAM2pars01))
d.pars <- rbindf(d.pars, pp)
pp <- data.table(pars = 'ps2', t(ALFAM2pars02))
d.pars <- rbindf(d.pars, pp)

fwrite(d.pars, '../output/pars.csv')

parsl <- melt(d.pars, id.vars = 'pars', variable.name = 'parameter')
