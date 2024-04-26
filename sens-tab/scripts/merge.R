# Merge in predictions

# NTS: switch to data.table!
# NTS: switch to data.table!
# NTS: switch to data.table!
# NTS: switch to data.table!

dat3 <- merge(dat, pr3, by = c('sida', 'ct'))
dat168.3 <- dat3[dat3$ct == 168, ]
dat168.3$upr.rel <- 100 * dat168.3$upr / dat168.3$er
dat168.3$lwr.rel <- 100 * dat168.3$lwr / dat168.3$er

summ168.3 <- dcast(dat168.3, sid + descrip ~ app.mthd, value.var = 'er')
summ168.3$bc.red <- 100*(1 - summ168.3$bc/summ168.3$bc[1])
summ168.3$bsth.red <- 100*(1 - summ168.3$bsth/summ168.3$bsth[1])
summ168.3$ts.red <- 100*(1 - summ168.3$ts/summ168.3$ts[1])
summ168.3$os.red <- 100*(1 - summ168.3$os/summ168.3$os[1])
summ168.3$cs.red <- 100*(1 - summ168.3$cs/summ168.3$cs[1])
summ168.3$bsth.bc.red <- 100*(1 - summ168.3$bsth/summ168.3$bc)
summ168.3$ts.bc.red <- 100*(1 - summ168.3$ts/summ168.3$bc)
summ168.3$os.bc.red <- 100*(1 - summ168.3$os/summ168.3$bc)
summ168.3$cs.bc.red <- 100*(1 - summ168.3$cs/summ168.3$bc)
summ168.3$ts.bsth.red <- 100*(1 - summ168.3$ts/summ168.3$bsth)
summ168.3$os.bsth.red <- 100*(1 - summ168.3$os/summ168.3$bsth)
summ168.3$cs.bsth.red <- 100*(1 - summ168.3$cs/summ168.3$bsth)
summ168.3 <- rounddf(summ168.3, 2, signif)

# Get boot results
# 90% CI
bootsumm <- bootdat[ct == 168, .(n = length(er), 
				 lwr = quantile(er, 0.05, na.rm = TRUE), 
				 upr = quantile(er, 0.95, na.rm = TRUE)), by = .(sida)]
dat168.3 <- merge(dat168.3, bootsumm, by = c('sida'))

# Repeat for 
dat2 <- merge(dat, pr2, by = c('sida', 'ct'))
dat168.2 <- dat2[dat2$ct == 168, ]

summ168.2 <- dcast(dat168.2, sid + descrip ~ app.mthd, value.var = 'er')
summ168.2$bc.red <- 100*(1 - summ168.2$bc/summ168.2$bc[1])
summ168.2$bsth.red <- 100*(1 - summ168.2$bsth/summ168.2$bsth[1])
summ168.2$ts.red <- 100*(1 - summ168.2$ts/summ168.2$ts[1])
summ168.2$os.red <- 100*(1 - summ168.2$os/summ168.2$os[1])
summ168.2$cs.red <- 100*(1 - summ168.2$cs/summ168.2$cs[1])
summ168.2$bsth.bc.red <- 100*(1 - summ168.2$bsth/summ168.2$bc)
summ168.2$ts.bc.red <- 100*(1 - summ168.2$ts/summ168.2$bc)
summ168.2$os.bc.red <- 100*(1 - summ168.2$os/summ168.2$bc)
summ168.2$cs.bc.red <- 100*(1 - summ168.2$cs/summ168.2$bc)
summ168.2$ts.bsth.red <- 100*(1 - summ168.2$ts/summ168.2$bsth)
summ168.2$os.bsth.red <- 100*(1 - summ168.2$os/summ168.2$bsth)
summ168.2$cs.bsth.red <- 100*(1 - summ168.2$cs/summ168.2$bsth)
summ168.2 <- rounddf(summ168.2, 2, signif)

# Repeat for original par set 1
dat1 <- merge(dat, pr1, by = c('sida', 'ct'))
dat168.1 <- dat1[dat1$ct == 168, ]

summ168.1 <- dcast(dat168.1, sid + descrip ~ app.mthd, value.var = 'er')
summ168.1$bc.red <- 100*(1 - summ168.1$bc/summ168.1$bc[1])
summ168.1$bsth.red <- 100*(1 - summ168.1$bsth/summ168.1$bsth[1])
summ168.1$ts.red <- 100*(1 - summ168.1$ts/summ168.1$ts[1])
summ168.1$os.red <- 100*(1 - summ168.1$os/summ168.1$os[1])
summ168.1$cs.red <- 100*(1 - summ168.1$cs/summ168.1$cs[1])
summ168.1$bsth.bc.red <- 100*(1 - summ168.1$bsth/summ168.1$bc)
summ168.1$ts.bc.red <- 100*(1 - summ168.1$ts/summ168.1$bc)
summ168.1$os.bc.red <- 100*(1 - summ168.1$os/summ168.1$bc)
summ168.1$cs.bc.red <- 100*(1 - summ168.1$cs/summ168.1$bc)
summ168.1$ts.bsth.red <- 100*(1 - summ168.1$ts/summ168.1$bsth)
summ168.1$os.bsth.red <- 100*(1 - summ168.1$os/summ168.1$bsth)
summ168.1$cs.bsth.red <- 100*(1 - summ168.1$cs/summ168.1$bsth)
summ168.1 <- rounddf(summ168.1, 2, signif)

# And stack
dat168.1$pars <- 'ps01'
dat168.2$pars <- 'ps02'
dat168.3$pars <- 'ps03'
datc <- rbind(data.table(dat168.1), data.table(dat168.2), data.table(dat168.3), fill = TRUE)


# Add dynamic data
dat1 <- data.table(dat1)
dat2 <- data.table(dat2)
dat3 <- data.table(dat3)

dat1[, pars := 'ps01']
dat2[, pars := 'ps02']
dat3[, pars := 'ps03']
dat <- rbind(dat1, dat2, dat3)
