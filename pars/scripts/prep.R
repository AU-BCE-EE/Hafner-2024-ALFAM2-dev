# Get measurement data ready

pdat1[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(pdat1[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat1[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat1[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat1 <- interpm(idat1, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Set missing rain to 0
idat1[, rain.missing := FALSE]
idat1[is.na(rain.rate), rain.missing := TRUE]
idat1[is.na(rain.rate), rain.rate := 0]
idat1[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idat1[is.na(cta), cta := ct]

# And drop obs with cta < 0
idat1 <- idat1[cta > 0, ]

dfsumm(pdat1[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
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

# Repeat for *dat2
pdat2[, app.rate.ni := app.rate * !app.mthd %in% c('os', 'cs')]

dfsumm(pdat2[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
dfsumm(idat2[, .(ct, cta, air.temp, wind.2m, rain.rate, rain.cum)])

# Interpolate missing wind and air temperature values
idat2[, `:=` (interp.wind = is.na(wind.2m), interp.air.temp = is.na(air.temp)), ]
idat2 <- interpm(idat2, 'ct', c('wind.2m', 'air.temp'), by = 'pmid', rule = 2)

# Set missing rain to 0
idat2[, rain.missing := FALSE]
idat2[is.na(rain.rate), rain.missing := TRUE]
idat2[is.na(rain.rate), rain.rate := 0]
idat2[is.na(rain.cum), rain.cum := 0]

# Set cta to ct where missing
idat2[is.na(cta), cta := ct]

# And drop obs with cta < 0
idat2 <- idat2[cta > 0, ]

dfsumm(pdat2[, .(app.mthd, app.rate.ni, man.dm, man.source, man.ph, tan.app)])
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

### Subset with pH
##idat2 <- idat2[!is.na(man.ph), ]
##idat3 <- idat2[!is.na(man.ph) & meas.tech2 == 'micro met', ]


