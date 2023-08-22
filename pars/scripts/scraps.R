# Cal f1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f1'
fixed <- integer()

pars.cal <- c(int.f0 = 0.36, 
              int.r1 = -1.3, 
              int.r2 = -1.7, 
              int.r3 = -2.4, 
              int.r5 = -1.6, 
              app.mthd.os.f0 = -3.0,
              app.mthd.cs.f0 = -7.6,
              app.mthd.bc.r1 = 1.3,
              app.mthd.ts.r1 = -0.53,
              app.mthd.bc.r3 = 0.53,
              app.mthd.cs.r3 = -0.29,
              man.dm.f0 = 0.28,
              man.dm.r1 = -0.19,
              app.rate.ni.f0 = -0.04,
              man.source.pig.f0 = -1.31,
              air.temp.r1 = 0.13,
              wind.2m.r1 = 0.56,
              rain.rate.r2 = 0.53,
              rain.rate.r5 = 0.84,
              incorp.shallow.f4 = -1.0,
              incorp.shallow.r3 = -1.27,
              incorp.deep.f4 = 3.0,
              incorp.deep.r3 = -1.7,
              man.ph.r1 = 0.5,
              man.ph.r3 = 0.2)

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'j', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.j], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 1 as well
idat1[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

print(Sys.time())


# Cal f2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Settings
ps <- 'f2'
fixed <- integer()

# Look for problem observations before calibration by running with all parameters
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pars.cal)
# Should be no warnings (no dropped pars)
# Should be no NA in output
which(is.na(pr$e))
which(!is.finite(pr$e))
which(!is.finite(pr$j))
if (is.nan(sum(pr$j[!pr$cta == 0]))) stop('NAs! Check pars and input data.')

mods[[ps]] <- list()
mods[[ps]][['cal']] <- m <- optim(par = pars.cal, fn = function(par) 
                                  resCalc(p = par, dat = idat1, to = 'e.int', time.name = 'cta',
                                          app.name = 'tan.app', group = 'pmid', method = 'TAE', 
                                          weights = idat1[, weight.j], flatout = TRUE),
                                  method = 'Nelder-Mead', control = list(maxit = 30000))

# View pars
print(m)

# Save pars
mods[[ps]][['coef']] <- pp <- c(m$par, fixed)

# Echo pars and other model info
print(pp)
print(m)

# Add predictions
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', time.incorp = 'time.incorp', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

# Apply to subset 1 as well
idat1[is.na(man.ph), man.ph := 7]
pp <- mods[[ps]][['coef']]
pr <- alfam2(as.data.frame(idat1), app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pp)
names(pr)[-1:-3] <- paste0(names(pr)[-1:-3], '.pred')
pr$pars <- ps
dd <- cbind(idat1, pr[, -1:-3])
dpreds1 <- dpreds1[pars != ps, ]
dpreds1 <- rbind(dpreds1, dd, fill = TRUE)

print(Sys.time())


# Cal xx ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
x <- dpreds[country == 'NL' & pars %in% c('ps1', 'ps2', 'f3') & dataset == 1, ]
y <- subset(x, country == 'NL' & app.mthd == 'cs')
unique(x$pmid)


ggplot(y, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, r1.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f0.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

m

ggplot(dd, aes(wind.2m, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  theme_bw()

ggplot(dd, aes(air.temp, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.1) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  coord_cartesian(ylim = c(-0.5, 0.5))


ggplot(ddf, aes(air.temp, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()

ggplot(ddf, aes(wind.2m, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()


