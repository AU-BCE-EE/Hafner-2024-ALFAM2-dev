# Sort out scenario variables

t.max <- 168
dt <- 1
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

# Adjust temperature for heating and cooling simulations
# Set amplitude 
amp <- 20.
dat[descrip == 'cooling', air.temp := air.temp - (ct - mean(ct)) * amp / 168, by = .(sid, app.mthd)]  
dat[descrip == 'warming', air.temp := air.temp + (ct - mean(ct)) * amp / 168, by = .(sid, app.mthd)]  

# Dummy variables
dat[, app.rate.ni := (!app.mthd %in% c('os', 'cs')) * app.rate]
dat[, man.dm.ni := (!app.mthd %in% c('os', 'cs')) * man.dm]

# Transformed wind
dat[, wind.sqrt := sqrt(wind.2m)]

# Sim ID plus application method for unique value for each sim
dat[, sida := paste0(sid, app.mthd)]
