
pamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing\nhose', 'Trailing\nshoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pamdat[, man.source.nm := factor(man.source, levels = c('cattle/other', 'pig'), labels = c('Cattle/other', 'Pig'))]

qamdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing\nhose', 'Trailing\nshoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qamdat[, man.source.nm := factor(man.source, levels = c('pig', 'cattle/other'), labels = c('Pig', 'Cattle/other'))]

# Drop cs CI
qamdat[app.mthd == 'cs', `:=` (rr10 = NA, rr90 = NA)]

d1 <- subset(qamdat, app.mthd != 'bc')
d3 <- subset(pamdat, app.mthd != 'bc' & parset == '3')
ggplot(d1, aes(app.mthd.nm, -rr10)) + 
  geom_errorbar(aes(ymin = -rr10, ymax = -rr90), lty = 'solid', colour = 'gray55', lwd = 1.6, width = 0) +
  #geom_point(aes(y = rrmd),  col = 'gray45', size = 2) +
  geom_point(data = d3, aes(y = -rr),  size = 3, shape = 19) +
  facet_wrap(~ man.source.nm, scale = 'fixed') +
  #scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Application method', y = 'Emission reduction\n(Frac. broadcast emission)', colour = '')
#  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
  #guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/rel_red_app_mthd', height = 3.0, width = 7)
