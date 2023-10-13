
# Settings to speed things up
# For intermediate par sets
maxit1 <-   400
maxit2 <-  5000
maxit3 <- 30000

# Centering means that include annoying injection exceptions
cmns <- c(app.rate = 40, man.dm = 6, man.tan = 1.2, man.ph = 7.5, air.temp = 13, wind.2m = 2.7, crop.z = 10,
          app.rate.app.mthd.inj = 40, man.dm.app.mthd.inj = 6, man.ph.app.mthd.inj = 7.5, wind.sqrt = sqrt(2.7))
