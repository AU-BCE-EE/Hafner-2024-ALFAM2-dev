# Get measurement data ready

idat1[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(idat1[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat1[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat1[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat1 <- interpm(idat1, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

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

# Get weights, equal by plot
idat1[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat1[, weight.er := 1 / max(er), by = pmid]
# Keep to 168 h
idat1[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat1[, weight.1 := weight.plots * weight.er * weight.168, by = pmid]

### Subset with pH
##idat2 <- idat1[!is.na(man.ph), ]
##idat3 <- idat1[!is.na(man.ph) & meas.tech2 == 'micro met', ]

# Repeat for *dat2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat2[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(idat2[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat2[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat2[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat2 <- interpm(idat2, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

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
idat2 <-ALFAM2:::prepDat(idat2, value = 'data') 
idat2$`__group` <- idat2$pmid
idat2$`__f4` <- 1

idat2 <- ALFAM2:::prepIncorp(idat2, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]

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

# Get weights, equal by plot
idat2[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat2[, weight.er := 1 / max(er), by = pmid]
# Keep to 168 h
idat2[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat2[, weight.1 := weight.plots * weight.er * weight.168, by = pmid]


# Repeat for *dat3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idat3[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(idat3[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat3[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat3[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat3 <- interpm(idat3, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Set missing rain to 0
idat3[is.na(rain.rate), rain.missing := TRUE]
idat3[is.na(rain.rate), rain.rate := 0]
idat3[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idat3[is.na(cta), cta := ct]

# And drop obs with cta < 0
idat3 <- idat3[cta > 0, ]

dfsumm(idat3[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat3[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Will run model with flatout option, so need to do dummy variable data prep separately here
idat3 <-ALFAM2:::prepDat(idat3, value = 'data') 
idat3$`__group` <- idat3$pmid
idat3$`__f4` <- 1

idat3 <- ALFAM2:::prepIncorp(idat3, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]

# Wind tunnel and micromet variables
idat3[, wt := meas.tech2 == 'wt']
idat3[, mm := meas.tech2 == 'micro met']

# Measurement method-specific weather]
idat3[, wind.wt := (meas.tech2 == 'wt') * sqrt(wind.2m)]
idat3[, wind.mm := (meas.tech2 == 'micro met') * sqrt(wind.2m)]
idat3[, air.temp.wt := (meas.tech2 == 'wt') * air.temp]
idat3[, air.temp.mm := (meas.tech2 == 'micro met') * air.temp]

# Alternate predictor variables
idat3[, wind.sqrt := sqrt(wind.2m)]
idat3[, air.temp.log := log10(air.temp + 273.15)]

# resCalc needs measured vars w names that match alfam2() output
idat3[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]

# Get weights, equal by plot
idat3[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idat3[, weight.er := 1 / max(er), by = pmid]
# Keep to 168 h
idat3[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idat3[, weight.1 := weight.plots * weight.er * weight.168, by = pmid]

# Repeat for *dati, and also fill in more missing values ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idati[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(idati[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idati[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idati[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idati <- interpm(idati, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Set missing pH to 7.5
idati[is.na(man.ph), man.ph.missing := TRUE]
idati[is.na(man.ph), man.ph := 7.5]

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

idati <- ALFAM2:::prepIncorp(idati, pars = ALFAM2::alfam2pars02, time.name = 'cta', 
                                       time.incorp = 'time.incorp',  
                                       incorp.names = c('incorp', 'deep', 'shallow'), 
                                       warn = TRUE)[[1]]

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

# Get weights, equal by plot
idati[, weight.plots := 1 / length(j.NH3), by = pmid]
# Normalize for cumulative emission
idati[, weight.er := 1 / max(er), by = pmid]
# Keep to 168 h
idati[, weight.168 := as.numeric(cta <= 168), by = pmid]
# Combined
idati[, weight.1 := weight.plots * weight.er * weight.168, by = pmid]

# Add idati to idat2 and idat3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
idati[, app.mthd.ts := 0]
idat2 <- unique(rbind(idat2, idati)[, dataset := 2])
# Needs next row beacuse there is lack of duplication for same pmid because missing pH is added in idati but not idat2
idat2 <- idat2[!duplicated(idat2[, .(pmid, cta)]), ]
idat3 <- unique(rbind(idat3, idati)[, dataset := 3])

# wt
idat4[, `:=` (j = j.NH3, e = e.cum, er = e.rel)]
# Dummy vars for wt data
# Will run model with flatout option, so need to do dummy variable data prep separately here
idat4 <-ALFAM2:::prepDat(idat4, value = 'data') 
idat4$`__group` <- idat4$pmid
idat4$`__f4` <- 1


