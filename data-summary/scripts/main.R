# Plot data to show old/new

rm(list = ls())

source('packages.R')
source('load.R')

dim(pdat)
table(pdat[, sub.period])
table(pdat[, corr.period])
table(pdat[, .(country, corr.period)])
table(pdat[, .(country, sub.period)])
table(pdat[, .(meas.tech2, sub.period)])
table(pdat[, .(sub.period, !is.na(e.rel.final) & e.rel.final > 1.5)])
table(pdat[, .(sub.period, !is.na(e.rel.final) & e.rel.final > 2)])
table(pdat[, .(sub.period, is.na(e.rel.final))])

x <- pdat[is.na(e.rel.final), ]

pdat[, man.trts := paste(man.trt1, man.trt2, man.trt3)]
pdat[, digested := grepl('[Dd]igest', man.trts)]
pdat[, separated := grepl('[Ss]epar', man.trts)]
pdat[, treat.nm := factor(ifelse(acid, 'Acid', ifelse(digested, 'AD', ifelse(separated, 'Separated', 'None/other'))),
                          levels = c('Acid', 'AD', 'Separated', 'None/other'))]
pdat[is.na(treat.nm), treat.nm := 'None/other']

mms <- c(chamber = 'Other chamber', cps = 'Other chamber', wt = 'Wind tunnel', `micro met` = 'Micromet.')
pdat[, meas.tech.nm := factor(mms[meas.tech2], levels = c('Micromet.', 'Wind tunnel', 'Other chamber'))]

pdat <- pdat[!is.na(app.mthd) & app.mthd != 'pi' & app.mthd != 'bss', ]
pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

pdat[, app.mthd.simp := as.character(app.mthd)]
pdat[app.mthd.simp %in% c('bsth', 'ts'), app.mthd.simp := 'bs'] 
pdat[app.mthd.simp %in% c('os', 'cs'), app.mthd.simp := 'i'] 
pdat[, app.mthd.simp.nm := factor(app.mthd.simp, levels = c('bc', 'bs', 'i'), labels = c('Broadcast', 'Band application', 'Injection'))]

pdat[, period := as.character(sub.period)]
pdat[corr.period == 3, period := '2/3']
pdat[, period.nm := factor(paste('Period', period))]
pdat[, sub.period.nm := factor(paste('Period', sub.period))]

pdat <- droplevels(pdat)

table(pdat[, .(treat.nm, sub.period)])

table(pdat$treat.nm, exclude = NULL)
levels(pdat$treat.nm)

table(pdat[, .(period.nm, ct.max > 72)]) / matrix(rep(table(pdat[, .(period.nm)]), 2), ncol = 2)
table(pdat[, .(period.nm, ct.max > 96)]) / matrix(rep(table(pdat[, .(period.nm)]), 2), ncol = 2)
table(pdat[, .(period.nm, ct.max > 168)]) / matrix(rep(table(pdat[, .(period.nm)]), 2), ncol = 2)

# Without na.translate = FALSE I get an NA entry in legend although there are no NA values for treat.nm
ggplot(pdat, aes(app.mthd.nm, e.rel.final, colour = inst, shape = treat.nm)) +
  geom_jitter(height = 0) +
  geom_bar(stat = 'summary', fun = 'mean', aes(group = app.mthd.nm), fill = 'gray55', colour = 'gray54', alpha = 0.1) +
  scale_shape_discrete(na.translate = FALSE) +
  theme_bw() +
  labs(x = 'Application method', y = 'Total emission (frac. applied TAN)', shape = 'Slurry treatment', colour = 'Institution') +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  ylim(0, 1.5) +
  facet_grid(meas.tech.nm ~ sub.period.nm)
ggsave('../plots/emis_summ.png', height = 7, width = 6.5)

ggplot(pdat, aes(air.temp.24, wind.2m.24, colour = sub.period.nm, shape = sub.period.nm)) +
  geom_point(alpha = 0.5) +
  theme_bw() +
  labs(x = expression('Air temperature'~(degree*C)), y = expression('Wind speed'~(m~s^'-1')), 
       colour = '', shape =  '') +
  facet_grid(meas.tech.nm ~ app.mthd.simp.nm)
ggsave('../plots/weather.png', height = 5, width = 6.5)


ggplot(pdat, aes(air.temp.24, e.rel.24, colour = app.mthd.nm, shape = app.mthd.nm)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = lm, se = FALSE, show.legend = FALSE) +
  theme_bw() +
  ylim(0, 1) +
  facet_grid(meas.tech.nm ~ sub.period.nm)
ggsave('../plots/emis_temp.png', height = 5, width = 6.5)

ggplot(pdat, aes(air.temp.24, fill = app.mthd)) +
  geom_histogram() +
  facet_wrap( ~ period.nm)

