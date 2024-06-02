# Get measurement data ready
# Also extends subsets made in subsets.R

# *dat1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat1[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idat1[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idat1[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]
idat1[, app.mthd.inj := app.mthd %in% c('os', 'cs')]

dfsumm(idat1[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat1[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat1[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat1 <- interpm(idat1, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Get an average air temperature for input
idat1[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]

# Set missing rain to 0
idat1[is.na(rain.rate), rain.missing := TRUE]
idat1[is.na(rain.rate), rain.rate := 0]
idat1[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idat1[is.na(cta), cta := ct]

# And drop obs with cta < 0
idat1 <- idat1[cta > 0, ]

dfsumm(idat1[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat1[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Will run model with flatout option, so need to do dummy variable data prep separately here
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.
idat1 <- idat1[order(pmid, cta), ]
idat1 <- alfam2(idat1, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                time.name = 'cta', group = 'pmid',
                time.incorp = 'time.incorp',  incorp.names = c('incorp', 'deep', 'shallow'), 
                warn = TRUE, value = 'incorp')
idat1 <- data.table(idat1)
# Set emission in added incorporation rows (needed because flatout option will be used) to NA so they are not used in fitting
# See love-hate-data.table repo issue #1 for more on this operation below
idat1[(`__add.row`), c('j.NH3', 'e.cum', 'e.rel')] <- NA

# Alternate predictor variables
idat1[, wind.sqrt := sqrt(wind.2m)]
idat1[, air.temp.log := log10(air.temp + 273.15)]
idat1[, man.dm.log := log10(man.dm)]

# resCalc needs measured vars w names that match alfam2() output
idat1[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# *dat2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat2[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idat2[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idat2[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]
idat2[, app.mthd.inj := app.mthd %in% c('os', 'cs')]

dfsumm(idat2[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat2[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat2[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat2 <- interpm(idat2, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Get an average air temperature for input
idat2[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]

# Set missing rain to 0
idat2[is.na(rain.rate), rain.missing := TRUE]
idat2[is.na(rain.rate), rain.rate := 0]
idat2[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idat2[is.na(cta), cta := ct]

# And drop obs with cta < 0
idat2 <- idat2[cta > 0, ]

dfsumm(idat2[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat2[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Will run model with flatout option, so need to do dummy variable data prep separately here
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.
# No incorporation so skipping prepIncorp() call
idat2 <- idat2[order(pmid, cta), ]
idat2 <- alfam2(idat2, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                time.name = 'cta', group = 'pmid',
                time.incorp = 'time.incorp',  incorp.names = c('incorp', 'deep', 'shallow'), 
                warn = TRUE, value = 'incorp')
idat2 <- data.table(idat2)
# Set emission in added incorporation rows (needed because flatout option will be used) to NA so they are not used in fitting
# See love-hate-data.table repo issue #1 for more on this operation below
idat2[(`__add.row`), c('j.NH3', 'e.cum', 'e.rel')] <- NA

# Alternate predictor variables
idat2[, wind.sqrt := sqrt(wind.2m)]
idat2[, air.temp.log := log10(air.temp + 273.15)]
idat2[, man.dm.log := log10(man.dm)]

# resCalc needs measured vars w names that match alfam2() output
idat2[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# Repeat for *dati, and also fill in more missing values ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idati[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idati[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idati[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]
idati[, app.mthd.inj := app.mthd %in% c('os', 'cs')]

dfsumm(idati[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idati[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idati[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idati <- interpm(idati, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Get an average air temperature for input
idati[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]

# Fill in missing pH with institute means from full database
mnph <- idat[, .(man.ph.mean = mean(na.omit(man.ph)), man.ph.n = sum(is.na(man.ph))), by = inst]
idati <- merge(idati, mnph, by = 'inst')
idati[is.na(man.ph), man.ph.missing := TRUE]
idati[is.na(man.ph), man.ph := man.ph.mean]
range(idati[, man.ph.mean])

# Set missing rain to 0
idati[is.na(rain.rate), rain.missing := TRUE]
idati[is.na(rain.rate), rain.rate := 0]
idati[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idati[is.na(cta), cta := ct]

# And drop obs with cta < 0
idati <- idati[cta > 0, ]

dfsumm(idati[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idati[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Will run model with flatout option, so need to do dummy variable data prep separately here
# Note: *must* use flatout option for safety once rows have been added (will screw up incorp otherwise) etc.
idati <- idati[order(pmid, cta), ]
idati <- alfam2(idati, pars = ALFAM2::alfam2pars02, app.name = 'tan.app', 
                time.name = 'cta', group = 'pmid',
                time.incorp = 'time.incorp',  incorp.names = c('incorp', 'deep', 'shallow'), 
                warn = TRUE, value = 'incorp')
idati <- data.table(idati)
# Set emission in added incorporation rows (needed because flatout option will be used) to NA so they are not used in fitting
# See love-hate-data.table repo issue #1 for more on this operation below
idati[(`__add.row`), c('j.NH3', 'e.cum', 'e.rel')] <- NA

# Alternate predictor variables
idati[, wind.sqrt := sqrt(wind.2m)]
idati[, air.temp.log := log10(air.temp + 273.15)]
idati[, man.dm.log := log10(man.dm)]

# resCalc needs measured vars w names that match alfam2() output
idati[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# Add idati (other incorporation obs) to idat1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Not using merge() but I always search for that function so there it is now to use as a keyword
# Add missing columns, with row indices for safety
idati[app.mthd != 'ts', app.mthd.ts := 0]
idati[app.mthd != 'os', app.mthd.os := 0]
idati[app.mthd != 'cs', app.mthd.cs := 0]
idati[, dataset := 0]

idat1 <- rbind(idat1, idati, fill = TRUE)[, dataset := 1]
# Needs next row beacuse there is lack of duplication for same pmid because missing pH is added in idati but not idat1
idat1 <- idat1[!duplicated(idat1[, .(pmid, cta)]), ]
# And then get new plots from idati in the pdat* df as well
pdat1 <- pdat[pmid %in% unique(idat1[, pmid])]

# Now remove values outside emission limits
# Done here and not in subset.R in order to see effect on counts
dim(pdat1)
pdat1 <- pdat1[e.rel.24 > -0.20 & 
               e.rel.24 < 1.20 &
               e.rel.final < 1.20 &
               e.rel.final > -0.20, ]
dim(pdat1)
range(pdat1$e.rel.final)
range(pdat1$e.rel.24)

idat1 <- idat1[pmid %in% unique(pdat1[, pmid])]

table(pdat1$app.mthd)


# (Re)calculate weights ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Equal by application method
idat1[, weight.app.mthd := 1 / length(unique(pmid)), by = app.mthd]
# Get weights, equal by plot
idat1[, weight.plots := 1 / sum(cta <= 168), by = pmid]
# Normalize for cumulative emission
idat1[, weight.er := 1 / max(na.omit(er[cta <= 168])), by = pmid]
# Normalize for number of intervals (later ints count more, last counts the most)
idat1[, weight.int := interval / max(interval[cta <= 168]), by = pmid]
# Keep to 168 h
idat1[, weight.168 := as.numeric(cta <= 168)]
# Combined
idat1[, weight.1 :=                                weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er)]
idat1[, weight.1a :=                               weight.plots *              weight.168 * (cta > 0) * !is.na(er)]
idat1[, weight.1b := weight.app.mthd * weight.er * weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er)]
idat1[, weight.j := weight.plots * weight.168 * (cta > 0) * !is.na(j), by = pmid]
# Only last obs
idat1[, cta.168 := cta[which.min(abs(cta - 168))], by = pmid]
idat1[, weight.last := 1 * (cta == cta.168), by = pmid]
idat1[, weight.2 := weight.last * weight.app.mthd * weight.er, by = pmid]
# Arbitrary reduction in broadcast weight, increase in others, partially offsetting plot numbers, also low emission
ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat1[, `:=` (weight.lastc = weight.last * ww[app.mthd], weight.1c = weight.1a * ww[app.mthd])]


# Equal by application method
idat2[, weight.app.mthd := 1 / length(unique(pmid)), by = app.mthd]
# Get weights, equal by plot
idat2[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat2[, weight.er := 1 / max(er[cta <= 168]), by = pmid]
# Normalize for number of intervals (later ints count more, last counts the most)
idat2[, weight.int := interval / max(interval[cta <= 168]), by = pmid]
# Keep to 168 h
idat2[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat2[, weight.1 :=                                weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er)]
idat2[, weight.1a :=                               weight.plots *              weight.168 * (cta > 0) * !is.na(er)]
idat2[, weight.1b := weight.app.mthd * weight.er * weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er)]
idat2[, weight.j := weight.plots * weight.168 * (cta > 0) * !is.na(j), by = pmid]
# Only last obs
idat2[, cta.168 := cta[which.min(abs(cta - 168))], by = pmid]
idat2[, weight.last := 1 * (cta == cta.168), by = pmid]
idat2[, weight.2 := weight.last * weight.app.mthd * weight.er, by = pmid]
# Arbitrary reduction in broadcast weight, increase in others, partially offsetting plot numbers, also low emission
ww <- c(bsth = 1, ts = 1, os = 2, cs = 2, bc = 0.5)
idat2[, `:=` (weight.lastc = weight.last * ww[app.mthd], weight.1c = weight.1a * ww[app.mthd])]

# Missing incorporation problem
idat1[is.na(incorp.deep), incorp.deep := 0]
idat1[is.na(incorp.shallow), incorp.shallow := 0]

# Finally, select only the necessary columns to reduce data table size, mainly for parallel stuff
idat1 <- idat1[, ..parestcols]
idat2 <- idat2[, ..parestcols]
