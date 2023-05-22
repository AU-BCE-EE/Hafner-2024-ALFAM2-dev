

dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
dat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed'))]

datin <- dat[!(man.ph < 6 | man.ph > 8 | man.dm < 2 | man.dm > 10 | wind.2m < 1 | wind.2m > 8 | air.temp < 4 | air.temp > 21)]
d1 <- datin[man.source != 'pig', ]
d2 <- dat[man.source != 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens4_cattle', height = 4, width = 4)

d1 <- datin[man.source == 'pig', ]
d2 <- dat[man.source == 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens4_pig', height = 4, width = 4)
