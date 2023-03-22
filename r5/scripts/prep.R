

dat.ref <- data.table(ct = 0:168, TAN.app = 100, rain.rate = 0)
dat.rain <- copy(dat.ref)
dat.rain[, rain.rate := ifelse((ct >= 12 & ct <= 15) | (ct >= 100 & ct <= 103), 2, 0)]
