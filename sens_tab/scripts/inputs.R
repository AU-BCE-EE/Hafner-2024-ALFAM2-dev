# Sort out scenario variables

t.max <- 168
dt <- 1.
nt <- ceiling(t.max/dt)

ni <- nrow(inputs)

app.mthds <- c('bc', 'bsth', 'ts', 'os', 'cs')
n.app.mthds <- length(app.mthds)
dat <- inputs[rep(1:ni, each = nt * n.app.mthds), ]
dat[, app.mthd := rep(rep(app.mthds, each = nt), ni)]

dat[, dt := dt]
dat[, ct := cumsum(dt), by = .(sid, app.mthd)]

# Rain only falls during first 3 h
dat[ct > 3, rain.rate := 0]
dat[, rain.cum := cumsum(rain.rate * dt), by = .(sid, app.mthd)]

### Adjust temperature for heating and cooling simulations
### Set amplitude 
##amp <- 20.
##dat[descrip == 'cooling', air.temp := air.temp - (ct - mean(ct) * amp / 168), by = .(sid, app.mthd)]  
##dat[descrip == 'warming', air.temp := air.temp + (ct - mean(ct) * amp / 168), by = .(sid, app.mthd)]  
##dat[dat$descrip == 'warming', 'air.temp'] <- dat[dat$descrip == 'warming', 'air.temp'] + 
##  (dat[dat$descrip == 'warming', 'ct'] - mean(dat[dat$descrip == 'warming', 'ct']))*amp/168
##
##  Group 3 column 'air.temp': 3.940476 (type 'double') at RHS position 1 truncated (precision lost) when assigning to type 'integer'
##4: In `[.data.table`(dat, descrip == "warming", `:=`(air.temp, air.temp +  :
##  Group 4 column 'air.temp': 3.940476 (type 'double') at RHS position 1 truncated (precision lost) when assigning to type 'integer'
##5

## Add some factor levels for dummy vars
#dat$app.mthd <- factor(dat$app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))
#dat$incorp <- factor(dat$incorp, levels = c('none', 'shallow', 'deep'))
#dat$man.source <- factor(dat$man.source, levels = c('cat', 'pig'))

# Dummy variables
dat$app.rate.ni <- (!dat$app.mthd %in% c('os', 'cs')) * dat$app.rate

# Sim ID plus application method for unique value for each sim
dat$sida <- paste0(dat$sid, dat$app.mthd)
