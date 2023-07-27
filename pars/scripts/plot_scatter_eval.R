# Evaluation plots

dpreds.plot <- copy(dpreds)
dp168.plot <- copy(dp168)

# NTS: Clean up this crap
dp168.plot[, digested := grepl('[Dd]igest', paste(man.trt1, man.trt2))]

dpreds.plot[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dp168.plot[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dp168.plot[, `:=` (acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
                    digested.nm = factor(ifelse(digested, 'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
                    pig.nm = factor(ifelse(man.source.pig == 1, 'Pig', 'Cattle &\nothers'), levels = c('Pig', 'Cattle &\nothers')),
                    incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]


dpreds.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]
dp168.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]

dp168w <- dcast(dp168.plot, inst + institute + country + exper + pmid + uptake + man.source + man.source.pig + pig.nm + app.mthd + incorp + incorp.nm + app.mthd.nm + digested + digested.nm + acid + acid.nm + man.dm + man.ph + air.temp.24 + wind.2m.24 + er ~ pars + dataset, value.var = 'er.pred')

# And compare to h1
# **f for final emission
ddf <- subset(dp168.plot, pars == 'h1')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h1', height = 4.2, width = 6)

ddf <- subset(dp168.plot, pars == 'h2')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h2', height = 4.2, width = 6)

ddf <- subset(dp168.plot, pars == 'h3')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h3', height = 4.2, width = 6)

ddf <- subset(dp168.plot, pars == 'h4')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h4', height = 4.2, width = 6)

ddf <- subset(dp168.plot, pars == 'h5')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h5', height = 4.2, width = 6)

ddf <- subset(dp168.plot, pars == 'h5')
names(ddf)
ggplot(ddf, aes(er.pred, er, colour = incorp, group = pmid, shape = incorp)) +
  geom_point() +
  facet_wrap(~ country, scale = 'fixed') +
  geom_abline(intercept = 0, slope = 1) +
  theme_bw() +
  labs(colour = 'Incorporation', x = 'Calculated emission (frac.)', y = 'Measured emission (frac.)')

ddf <- subset(dp168.plot, pars == 'h6')
ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-scatter/resids_erf_temp_h6', height = 4.2, width = 6)
