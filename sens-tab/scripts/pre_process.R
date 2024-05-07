# Pre-process incorporation data

dat <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = pars03, value = 'incorp')

setDT(dat)

