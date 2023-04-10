

dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
dat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed'))]

dd <- dat[man.source != 'pig', ]
ggplot(dd, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens4_cattle', height = 4, width = 4)

dd <- dat[man.source == 'pig', ]
ggplot(dd, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens4_pig', height = 4, width = 4)
