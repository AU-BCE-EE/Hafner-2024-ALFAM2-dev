# Run model

# Run with new par set
pr3 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
                group = 'sida', pars = pars03, prep = TRUE)

# Run with par set 2
pr2 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
                group = 'sida', pars = ALFAM2pars02, prep = TRUE)

# Run with par set 1
pr1 <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
                group = 'sida', pars = ALFAM2pars01, prep = TRUE)
