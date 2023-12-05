# Sort out scenarios

# Set reference values here
# These values are based on cattle and April values in the DK EF report
dat.ref <- data.table(ct = 168, man.dm = 6.5, wind.2m = 3.4, air.temp = 7.6, rain.rate = 0, app.rate.ni = 40, man.ph = 7.0, tan.app = 100, app.mthd = 'bsth')
man.source <- data.table(man.source = c('pig', 'cattle/other'))
dat.ref <- data.table(dfcombos(dat.ref, man.source))

# Set min/max here
man.dm <- data.table(man.dm = seq(1, 15, length.out = 100))
man.ph <- data.table(man.ph = seq(6, 9, length.out = 100))
air.temp <- data.table(air.temp = seq(0, 25, length.out = 100))
wind.2m <- data.table(wind.2m = seq(0, 10, length.out = 100))
rain.rate <- data.table(rain.rate = seq(0, 2, length.out = 100))

app.mthd <- data.table(app.mthd = c('bc', 'bsth', 'ts', 'os', 'cs'))
app.mthd.num <- c(bc = 1, bsth = 0, ts = -0.1, os = -0.5, cs = -1)

dat.air.temp <- as.data.table(dfcombos(dat.ref[, -4], air.temp))
dat.air.temp[, id := paste('air.temp', 1:nrow(dat.air.temp))]
dat.air.temp[, set := 'air.temp']
dat.air.temp[, xval := air.temp]

dat.wind <- as.data.table(dfcombos(dat.ref[, -3], wind.2m))
dat.wind[, id := paste('wind', 1:nrow(dat.wind))]
dat.wind[, set := 'wind.2m']
dat.wind[, xval := wind.2m]

dat.rain.rate <- as.data.table(dfcombos(dat.ref[, -5], rain.rate))
dat.rain.rate[, id := paste('rain.rate', 1:nrow(dat.rain.rate))]
dat.rain.rate[, set := 'rain.rate']
dat.rain.rate[, xval := rain.rate]

dat.dm <- as.data.table(dfcombos(dat.ref[, -2], man.dm))
dat.dm[, id := paste('dm', 1:nrow(dat.dm))]
dat.dm[, set := 'man.dm']
dat.dm[, xval := man.dm]

dat.man.ph <- as.data.table(dfcombos(dat.ref[, -7], man.ph))
dat.man.ph[, id := paste('man.ph', 1:nrow(dat.man.ph))]
dat.man.ph[, set := 'man.ph']
dat.man.ph[, xval := man.ph]

# Application method has to be handled differently
dat.app.mthd <- as.data.table(dfcombos(dat.ref[, -9], app.mthd))
dat.app.mthd[, id := paste('app.mthd', 1:nrow(dat.app.mthd))]
dat.app.mthd[, set := 'app.mthd']
dat.app.mthd[, xval := app.mthd.num[app.mthd]]

# Add columns to dat.ref 
dat.ref[, `:=` (set = 'ref', id = paste('ref', 1:nrow(dat.ref)), xval = 0)]

dat <- rbind(dat.air.temp, dat.wind, dat.rain.rate, dat.dm, dat.man.ph, dat.app.mthd, dat.ref)
dat[, air.temp.ave := air.temp]

# Normalize x values for plotting
sets <- unique(dat[, set])
sets <- sets[!sets %in% c('ref', 'app.mthd')]
for (i in sets) {
  xref <- as.numeric(dat[set == 'ref', ..i][1])
  div <- max(abs(dat[set == i, xval] - xref))
  dat[set == i, xval.norm := (xval - xref) / div] 
}

# Application method
dat[set == 'app.mthd', xval.norm := xval]

# Reference
dat[set == 'ref', xval.norm := 0]

# Square root wind
dat[, wind.sqrt := sqrt(wind.2m)]
