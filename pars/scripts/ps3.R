# Simply name a model ps3 for clarity

mods[['ps3']] <- mods[['f29']]

# And make low/high r5 sets for sensitivity
mods[['ps3lowr5']] <- mods[['ps3']]
mods[['ps3highr5']] <- mods[['ps3']]

mods[['ps3lowr5']][['coef']][['int.r5']] <- mods[['ps3lowr5']][['coef']][['int.r5']] - log10(2)
mods[['ps3highr5']][['coef']][['int.r5']] <- mods[['ps3highr5']][['coef']][['int.r5']]  + log10(2)
