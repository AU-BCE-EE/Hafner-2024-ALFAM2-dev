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


dp168w <- dcast(dp168.plot, inst + institute + country + exper + pmid + man.source + man.source.pig + pig.nm + app.mthd + incorp + incorp.nm + app.mthd.nm + digested + digested.nm + acid + acid.nm + man.dm + man.ph + air.temp.24 + wind.2m.24 + er ~ pars + dataset, value.var = 'er.pred')

# WIP
# Need different dataset
dd <- droplevels(subset(dp168w, !is.na(w4_4)))
ggplot(dd, aes(w4_4, er, colour = exper)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point() +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = 'Institution')
ggsave2x('../plots-resids/erf_scatter1', height = 5, width = 6)

ggplot(dp168w, aes(p1_3, er, colour = inst)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point() +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = 'Institution')
ggsave2x('../plots-resids/erf_scatter1', height = 5, width = 6)

dd <- subset(dp168w, acid)
ggplot(dp168w, aes(p1_3, er, colour = acid.nm)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point(alpha = 0.6) +
  geom_point(data = dd) +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = '')
ggsave2x('../plots-resids/erf_scatter2', height = 5, width = 6)

dd <- subset(dp168w, incorp != 'none')
ggplot(dp168w, aes(p1_3, er, colour = incorp.nm)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point(alpha = 0.3) +
  geom_point(data = dd) +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = 'Incorporation')
ggsave2x('../plots-resids/erf_scatter3', height = 5, width = 6)

dd <- subset(dp168w, digested)
ggplot(dp168w, aes(p1_3, er, colour = digested.nm)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point(alpha = 0.3) +
  geom_point(data = dd) +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = '')
ggsave2x('../plots-resids/erf_scatter4', height = 5, width = 6)

dd <- subset(dp168w, man.source.pig == 1)
ggplot(dp168w, aes(p1_3, er, colour = pig.nm)) +
  geom_abline(intercept = 0, slope = 1) +
  facet_wrap(~ app.mthd.nm) +
  geom_point(alpha = 0.5) +
  #geom_point(data = dd) +
  theme_bw() +
  theme(legend.pos = c(0.84, 0.23)) +
  guides(colour = guide_legend(ncol = 2)) +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', y = 'Measured emission (frac. applied TAN)', colour = '')
ggsave2x('../plots-resids/erf_scatter5', height = 5, width = 6)

# Use null2 model (with app method and DM) to look at weather effects ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- subset(dpreds.plot, pars == 'null2' & ct > 12)
ddf <- subset(dp168.plot, pars == 'null2')

ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'fixed') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-resids/resids_erf_temp', height = 4.2, width = 6)

ggplot(ddf, aes(wind.2m.24, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd.nm, scale = 'fixed') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  coord_cartesian(xlim = c(0, 11.5)) +
  labs(colour = 'Institution', x = expression('24 h ave. wind speed'~(m~s^'-1')), y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-resids/resids_erf_wind', height = 4.2, width = 6)

set.seed(186)
ddd <- subset(dd, pmid %in% sample(dd[, pmid], 100))
ggplot(ddd, aes(cta/24, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  coord_cartesian(xlim = c(0, 4), ylim = c(-1, 1)) +
  labs(colour = 'Institution', x = 'Time since application (d)', y = expression('N flux residual'~(kg~ha^'-1'~h^'-1')))
ggsave2x('../plots-resids/resids_flux_time', height = 4.2, width = 6)

ggplot(dd, aes(rain.rate, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  coord_cartesian(ylim = c(-0.5, 0.5)) +
  labs(colour = 'Institution', x = expression('Rainfall rate'~(mm~h^'-1')), y = expression('N flux residual'~(kg~ha^'-1'~h^'-1')))
ggsave2x('../plots-resids/resids_flux_rain', height = 4.2, width = 6)

ggplot(ddf, aes(rain.cum, resid.er, colour = inst, group = pmid)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ app.mthd.nm) +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  labs(colour = 'Institution', x = 'Cumulative rainfall (mm)', y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-resids/resids_erf_rain', height = 4.2, width = 6)


# Model c and d comparison ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dd <- subset(dp168.plot, pars %in% c('ps1', 'ps2', 'p1', 'null2'))
ggplot(dd, aes(inst, resid.er, fill = pars.nm)) +
  geom_boxplot() +
  facet_wrap(~ app.mthd.nm)

# r5 check, long trials ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lp <- subset(pdat, ct.max > 100)[, pmid]
dd <- subset(dpreds.plot, pars %in% c('ps2', 'null2', 'p1') & pmid %in% lp)
ggplot(dd, aes(cta, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3, size = 0.3) +
  facet_grid(app.mthd.nm ~ pars.nm) +
  theme_bw() +
  labs(colour = 'Institution', x = 'Time since application (h)', y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-resids/resids_er_long_time', height = 5.2, width = 6)

ggplot(dd, aes(cta, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.3) +
  geom_point(alpha = 0.3) +
  facet_grid(app.mthd.nm ~ pars.nm, scale = 'free') +
  theme_bw() +
  coord_cartesian(xlim = c(0, 500)) +
  labs(colour = 'Institution', x = 'Time since application (h)', y = 'Emission residual (frac. applied TAN)')
ggsave2x('../plots-resids/resids_er_long_time_short', height = 5.2, width = 6)

dd <- subset(dpreds.plot, pars %in% c('ps2', 'null2', 'p1') & pmid %in% c(1498, 1505))
ggplot(dd, aes(cta, er, colour = pars, group = pmid)) +
  geom_line(colour = 'black') +
  geom_line(aes(cta, er.pred, group = pars), lty = '1111') +
  geom_point(alpha = 0.3, size = 0.3) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  labs(colour = 'Parameter set', x = 'Time since application (h)', y = 'Cum. emis. (frac. TAN)')
ggsave2x('../plots-resids/cum_emis_example_r5', height = 2.5, width = 6)


