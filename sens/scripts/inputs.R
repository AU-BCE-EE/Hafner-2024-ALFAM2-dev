# Sort out scenarios

# Reference conditions, based on cattle slurry 2010-2019 April for Denmark
dat.ref <- data.table(ct = 168, man.dm = c(6.5, 3.9), wind.2m = 3.1, air.temp = 12, rain.rate = 0, app.rate = 40, man.ph = c(7, 7.2), tan.app = 100, man.source = c('cattle/other', 'pig'))

man.dm <- data.table(man.dm = seq(0, 10, length.out = 100))
man.ph <- data.table(man.ph = seq(5.5, 9.0, length.out = 100))
air.temp <- data.table(air.temp = seq(-2, 28, length.out = 100))
wind.2m <- data.table(wind.2m = seq(0.2, 10, length.out = 100))
rain.rate <- data.table(rain.rate = seq(0, 3, length.out = 100))

app.mthd <- data.table(app.mthd = c('bc', 'bsth', 'ts', 'os', 'cs'))

dat.air.temp <- as.data.table(dfcombos(dat.ref[, -4], air.temp, app.mthd))
dat.air.temp[, id := paste('air.temp', 1:nrow(dat.air.temp))]
dat.air.temp[, set := 'air.temp']
dat.air.temp[, xval := air.temp]

dat.wind <- as.data.table(dfcombos(dat.ref[, -3], wind.2m, app.mthd))
dat.wind[, id := paste('wind', 1:nrow(dat.wind))]
dat.wind[, set := 'wind.2m']
dat.wind[, xval := wind.2m]

dat.rain.rate <- as.data.table(dfcombos(dat.ref[, -5], rain.rate, app.mthd))
dat.rain.rate[, id := paste('rain.rate', 1:nrow(dat.rain.rate))]
dat.rain.rate[, set := 'rain.rate']
dat.rain.rate[, xval := rain.rate]

dat.dm <- as.data.table(dfcombos(dat.ref[, -2], man.dm, app.mthd))
dat.dm[, id := paste('dm', 1:nrow(dat.dm))]
dat.dm[, set := 'man.dm']
dat.dm[, xval := man.dm]

dat.man.ph <- as.data.table(dfcombos(dat.ref[, -7], man.ph, app.mthd))
dat.man.ph[, id := paste('man.ph', 1:nrow(dat.man.ph))]
dat.man.ph[, set := 'man.ph']
dat.man.ph[, xval := man.ph]

dat <- rbind(dat.air.temp, dat.wind, dat.rain.rate, dat.dm, dat.man.ph)

# Add some (dummy) variables
dat[, air.temp.ave := air.temp]
dat[, wind.sqrt := sqrt(wind.2m)]
dat[, man.dm.log := log10(man.dm)]
dat[, app.rate.ni := (as.numeric(!app.mthd %in% c('os', 'cs')) * app.rate)]
dat[, man.dm.ni := (as.numeric(!app.mthd %in% c('os', 'cs')) * man.dm)]

# Mark obs outside of par est range
pvsumm[, variable := gsub('rain\\.1', 'rain\\.rate', variable)]
pvsumm[, set := gsub('\\.24', '', variable)]
dat <- merge(dat, pvsumm[, .(set, app.mthd, b3, a3)], by = c('set', 'app.mthd')) 
dat[, outsidein := xval < b3 | xval > a3]

# Application method has to be handled differently, separately
dat.app.mthd <- as.data.table(dfcombos(dat.ref, app.mthd))
dat.app.mthd[, id := paste('app.mthd', 1:nrow(dat.app.mthd))]
dat.app.mthd[, set := 'app.mthd']
dat.app.mthd[, xval := app.mthd]
dat.app.mthd[, wind.sqrt := sqrt(wind.2m)]
dat.app.mthd[, man.dm.log := log10(man.dm)]
dat.app.mthd[, app.rate.ni := (as.numeric(!app.mthd %in% c('os', 'cs')) * app.rate)]
dat.app.mthd[, man.dm.ni := (as.numeric(!app.mthd %in% c('os', 'cs')) * man.dm)]


