# Sort out scenarios

dat.ref <- data.table(ct = 168, man.dm = 5, wind.2m = 5, air.temp = 15, rain.rate = 0, app.rate.ni = 40, man.ph = 7, tan.app = 100)
man.source <- data.table(man.source = c('pig', 'cattle/other'))
dat.ref <- data.table(dfcombos(dat.ref, man.source))

man.dm <- data.table(man.dm = seq(0, 10, length.out = 100))
man.ph <- data.table(man.ph = seq(5.5, 9.0, length.out = 100))
air.temp <- data.table(air.temp = seq(-2, 28, length.out = 100))
wind.2m <- data.table(wind.2m = seq(0, 10, length.out = 100))
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
dat[, air.temp.ave := air.temp]
