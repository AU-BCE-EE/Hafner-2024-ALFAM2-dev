
dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
dat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

qdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

d1 <- pdat[parset == 3 & man.source != 'pig' & !outsidein, ]
d2 <- pdat[parset == 3 & man.source != 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens5_cattle', height = 4, width = 4)

d1 <- pdat[man.source == 'pig', ]
d2 <- pdat[parset == 3 & man.source == 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens5_pig', height = 4, width = 4)

# Derivatives
d <- qdat[man.source != 'pig' & app.mthd == 'bsth', ]
d3 <- pdat[man.source != 'pig' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_smooth(aes(y = dedx10), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_smooth(aes(y = dedx90), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_smooth(aes(y = dedxmd), linewidth = 0.7, se = FALSE, col = 'gray45') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(aes(y = dedxmd), col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens5_cattle', height = 4, width = 5)

d <- qdat[man.source == 'pig' & app.mthd == 'bsth', ]
d3 <- pdat[man.source == 'pig' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_smooth(aes(y = dedx10), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_smooth(aes(y = dedx90), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_smooth(aes(y = dedxmd), linewidth = 0.7, se = FALSE, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens5_pig', height = 4, width = 5)
