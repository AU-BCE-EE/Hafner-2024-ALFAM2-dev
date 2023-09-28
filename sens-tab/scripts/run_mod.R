# Run model

# Add wind.sqrt to cmns
cmns <- c(app.rate = 40, man.dm = 6, man.tan = 1.2, man.ph = 7.5, air.temp = 13, wind.2m = 2.7, crop.z = 10,
          wind.sqrt = sqrt(2.7))

# Run with new par set
pr3 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp', cmns = cmns,
                group = 'sida', pars = pars03, prep = TRUE)

# Run with par set 2
pr2 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp', cmns = cmns,
                group = 'sida', pars = ALFAM2pars02, prep = TRUE)

# Run with par set 1
pr1 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp', cmns = cmns, 
                group = 'sida', pars = ALFAM2pars01, prep = TRUE)
