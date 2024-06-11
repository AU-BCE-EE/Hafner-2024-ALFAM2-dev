
pamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing\nhose', 'Trailing\nshoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pamdat[, man.source.nm := factor(man.source, levels = c('cattle/other', 'pig'), labels = c('Cattle/other', 'Pig'))]

qamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing\nhose', 'Trailing\nshoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qamdat[, man.source.nm := factor(man.source, levels = c('pig', 'cattle/other'), labels = c('Pig', 'Cattle/other'))]

# Drop cs CI
qamdat[app.mthd == 'cs', `:=` (rr10 = NA, rr90 = NA)]

d1 <- subset(qamdat, app.mthd != 'bc')
d3 <- subset(pamdat, app.mthd != 'bc' & parset == '3')
p <- ggplot(d1, aes(app.mthd.nm, rr10)) + 
  geom_errorbar(aes(ymin = rr10, ymax = rr90), lty = 'solid', colour = 'gray55', lwd = 1.6, width = 0) +
  geom_point(data = d3, aes(y = rr),  size = 3, shape = 19) +
  ylim(0, 1.0) +
  facet_wrap(~ man.source.nm, scale = 'fixed') +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Application method', y = 'Emission reduction\n(Frac. broadcast emission)', colour = '')
ggsave2x('../plots/rel_red_app_mthd', height = 3.0, width = 7)

p <- p +
  geom_text(data = d3, aes(y = rr, label = signif(rr, 2)), nudge_x = 0.3, size = 2.3) +
  geom_text(aes(y = rr90, label = signif(rr90, 2)), nudge_x = 0.3, size = 2.3) +
  geom_text(aes(y = rr10, label = signif(rr10, 2)), nudge_x = 0.3, size = 2.3) +
ggsave2x('../plots/rel_red_app_mthd_num', height = 3.0, width = 7)

dd <- pamdat[parset == '3', ]
ggplot(pamdat, aes(app.mthd.nm, rr)) + 
  geom_jitter(height = 0, alpha = 0.3) +
  geom_point(data = dd, colour = 'red') +
  geom_point(data = qamdat, aes(y = rrmd), colour = 'blue') +
  ylim(0, 1.0) +
  facet_wrap(~ man.source.nm, scale = 'fixed') +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Application method', y = 'Emission reduction\n(Frac. broadcast emission)', colour = '')
ggsave2x('../plots/rel_red_app_mthd_obs', height = 3.0, width = 7)


