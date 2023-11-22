
# Set labels here
app.mthd.labels <- c('Bred-\nspredning', 'Slæbe\nslange', 'Slæbe\nsko', 'Åben rende\nnedfældning', 'Lukket rende\nnedfældning')
man.source.labels <- c('Kvæg/andet', 'Svin')

pamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = app.mthd.labels)]
pamdat[, man.source.nm := factor(man.source, levels = c('cattle/other', 'pig'), labels = man.source.labels)]

qamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = app.mthd.labels)]
qamdat[, man.source.nm := factor(man.source, levels = c('pig', 'cattle/other'), labels = man.source.labels)]

d1 <- subset(qamdat, app.mthd != 'bc')
d3 <- subset(pamdat, app.mthd != 'bc' & parset == '3')
ggplot(d1, aes(app.mthd.nm, -rr10)) + 
  geom_errorbar(aes(ymin = -rr10, ymax = -rr90), lty = 'solid', colour = 'gray55', lwd = 1.6, width = 0) +
  geom_point(data = d3, aes(y = -rr),  size = 3, shape = 19) +
  facet_wrap(~ man.source.nm, scale = 'fixed') +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Udbringningsteknik', y = 'Emissions reduktion\n(Frak. bredspredt emission)', colour = '')
ggsave2x('../plots-pres/rel_red_app_mthd', height = 3.0, width = 7)
