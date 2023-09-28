# Get measurement data ready

# *dat1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat1[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idat1[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idat1[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]

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
idat1 <-ALFAM2:::prepDat(idat1, value = 'data') 
idat1$`__group` <- idat1$pmid
idat1$`__f4` <- 1

idat1 <- idat1[order(pmid, cta), ]
idat1 <- ALFAM2:::prepIncorp(idat1, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]
# Set emission in added incorporation rows (needed because flatout option will be used) to NA so they are not used in fitting
# See love-hate-data.table repo issue #1 for more on this operation below
idat1[idat1$`__add.row`, c('j.NH3', 'e.cum', 'e.rel')] <- NA

# Wind tunnel and micromet variables
idat1[, wt := meas.tech2 == 'wt']
idat1[, mm := meas.tech2 == 'micro met']

# Measurement method-specific weather]
idat1[, wind.wt := (meas.tech2 == 'wt') * sqrt(wind.2m)]
idat1[, wind.mm := (meas.tech2 == 'micro met') * sqrt(wind.2m)]
idat1[, air.temp.wt := (meas.tech2 == 'wt') * air.temp]
idat1[, air.temp.mm := (meas.tech2 == 'micro met') * air.temp]

# Alternate predictor variables
idat1[, wind.sqrt := sqrt(wind.2m)]
idat1[, air.temp.log := log10(air.temp + 273.15)]

# resCalc needs measured vars w names that match alfam2() output
idat1[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# *dat2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat2[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idat2[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idat2[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]

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
# No incorporation so skipping prepIncorp() call
idat2 <-ALFAM2:::prepDat(idat2, value = 'data') 
idat2$`__group` <- idat2$pmid
idat2$`__f4` <- 1
# Need add.row because it is usually added without flatout option
idat2$`__add.row` <- FALSE

# Wind tunnel and micromet variables
idat2[, wt := meas.tech2 == 'wt']
idat2[, mm := meas.tech2 == 'micro met']

# Measurement method-specific weather]
idat2[, wind.wt := (meas.tech2 == 'wt') * sqrt(wind.2m)]
idat2[, wind.mm := (meas.tech2 == 'micro met') * sqrt(wind.2m)]
idat2[, air.temp.wt := (meas.tech2 == 'wt') * air.temp]
idat2[, air.temp.mm := (meas.tech2 == 'micro met') * air.temp]

# Alternate predictor variables
idat2[, wind.sqrt := sqrt(wind.2m)]
idat2[, air.temp.log := log10(air.temp + 273.15)]

# resCalc needs measured vars w names that match alfam2() output
idat2[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# Repeat for *dati, and also fill in more missing values ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idati[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]
idati[, man.dm.ni := man.dm * !app.mthd %in% c('os', 'cs')]
idati[, man.ph.ni := man.ph * !app.mthd %in% c('os', 'cs')]

dfsumm(idati[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idati[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idati[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idati <- interpm(idati, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Get an average air temperature for input
idati[, air.temp.ave := ifelse(!is.na(air.temp.48), air.temp.48, air.temp.24)]

# Set missing pH to 7.5
idati[is.na(man.ph), man.ph.missing := TRUE]
idati[is.na(man.ph), man.ph := 7.0]

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
idati <-ALFAM2:::prepDat(idati, value = 'data') 
idati$`__group` <- idati$pmid
idati$`__f4` <- 1

idati <- idati[order(pmid, cta), ]
idati <- ALFAM2:::prepIncorp(idati, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]
# Set emission in added incorporation rows (needed because flatout option will be used) to NA so they are not used in fitting
idati[idati$`__add.row`, c('j.NH3', 'e.cum', 'e.rel')] <- NA

# Wind tunnel and micromet variables
idati[, wt := meas.tech2 == 'wt']
idati[, mm := meas.tech2 == 'micro met']

# Measurement method-specific weather]
idati[, wind.wt := (meas.tech2 == 'wt') * sqrt(wind.2m)]
idati[, wind.mm := (meas.tech2 == 'micro met') * sqrt(wind.2m)]
idati[, air.temp.wt := (meas.tech2 == 'wt') * air.temp]
idati[, air.temp.mm := (meas.tech2 == 'micro met') * air.temp]

# Alternate predictor variables
idati[, wind.sqrt := sqrt(wind.2m)]
idati[, air.temp.log := log10(air.temp + 273.15)]

# resCalc needs measured vars w names that match alfam2() output
idati[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# Add idati (other incorporation obs) to idat1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Not using merge() but I always search for that function so there it is now to use as a keyword
# Add missing columns, with row indices for safety
idati[app.mthd != 'ts', app.mthd.ts := 0]
idati[app.mthd != 'os', app.mthd.os := 0]
idati[app.mthd != 'cs', app.mthd.cs := 0]
idati[, dataset := 0]

#names(idati)[!names(idati) %in% names(idat1)]
#names(idat1)[!names(idat1) %in% names(idati)]
idat1 <- rbind(idat1, idati, fill = TRUE)[, dataset := 1]
# Needs next row beacuse there is lack of duplication for same pmid because missing pH is added in idati but not idat1
idat1 <- idat1[!duplicated(idat1[, .(pmid, cta)]), ]
# And then get new plots from idati in the pdat* df as well
pdat1 <- pdat[pmid %in% unique(idat1[, pmid])]


# (Re)calculate weights ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Get weights, equal by plot
idat1[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat1[, weight.er := 1 / max(er[cta <= 168]), by = pmid]
# Normalize for number of intervals (later ints count more, last counts the most)
idat1[, weight.int := interval / max(interval[cta <= 168]), by = pmid]
# Keep to 168 h
idat1[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat1[, weight.1 := weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er), by = pmid]
idat1[, weight.j := weight.plots * weight.168 * (cta > 0) * !is.na(j), by = pmid]
# Only last obs
idat1[, cta.168 := cta[which.min(abs(cta - 168))], by = pmid]
idat1[, weight.last := 1 * (cta == cta.168), by = pmid]
# NTS: update dati too
## Last obs only
#idat1[!is.na(er), weight.last := 1 * (cta == max(cta)), by = pmid]
#idat1[is.na(er), weight.last := 0, by = pmid]

# Get weights, equal by plot
idat2[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat2[, weight.er := 1 / max(er[cta <= 168]), by = pmid]
# Normalize for number of intervals (later ints count more, last counts the most)
idat2[, weight.int := interval / max(interval[cta <= 168]), by = pmid]
# Keep to 168 h
idat2[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat2[, weight.1 := weight.plots * weight.int * weight.168 * (cta > 0) * !is.na(er) , by = pmid]

# Missing incorporation problem
idat1[is.na(incorp.deep), incorp.deep := 0]
idat1[is.na(incorp.shallow), incorp.shallow := 0]
