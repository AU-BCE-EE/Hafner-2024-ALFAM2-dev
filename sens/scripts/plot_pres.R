# Plots for presentations

dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
dat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

qdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

datin <- pdat[parset == 3 & set.nm != 'Rain' & !(man.ph < 5.8 | man.ph > 8.9 | man.dm < 1 | man.dm > 8.8 | wind.2m < 0.6 | wind.2m > 9.7 | air.temp < -1 | air.temp > 21.7)]
d1 <- datin[man.source != 'pig', ]
d2 <- pdat[parset == 3 & set.nm != 'Rain' & man.source != 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x', ncol = 4) +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h emis. (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 1))
ggsave2x('../plots-pres/sens4_cattle', height = 3, width = 7)

# Derivatives
d <- qdat[man.source != 'pig' & set.nm != 'Rain' & app.mthd == 'bsth', ]
d3 <- pdat[man.source != 'pig' & set.nm != 'Rain' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'red') +
  geom_smooth(aes(y = dedx10), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_smooth(aes(y = dedx90), linewidth = 0.7, se = FALSE, lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7, colour = 'gray45') +
  facet_wrap(~ set.nm, scale = 'free', nrow = 1) +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') 
ggsave2x('../plots-pres/dsens4_cattle', height = 2, width = 7)
