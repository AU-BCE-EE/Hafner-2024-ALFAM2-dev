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

# Export
fwrite(d.pars, '../output/pars.csv')
fwrite(parsl, '../output/pars_long.csv')

