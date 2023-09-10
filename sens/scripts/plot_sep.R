

pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]
pdat[, man.source.nm := factor(man.source, levels = c('cattle/other', 'pig'), labels = c('Cattle/other', 'Pig'))]

qdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]
qdat[, man.source.nm := factor(man.source, levels = c('cattle/other', 'pig'), labels = c('Cattle/other', 'Pig'))]

# Limits (datin) from plot.R

datin <- pdat[parset == 3 & !(man.ph < 5.8 | man.ph > 8.9 | man.dm < 1 | man.dm > 8.8 | wind.2m < 0.6 | wind.2m > 9.7 | air.temp < -1 | air.temp > 21.7)]
d1 <- datin[set == 'man.dm', ]
d2 <- pdat[parset == 3 & set == 'man.dm', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Slurry DM (%)', y = '168 h emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens_DM', height = 3, width = 4.5)

d1 <- datin[set == 'man.ph', ]
d2 <- pdat[parset == 3 & set == 'man.ph', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Slurry pH', y = '168 h emission (frac. TAN)', colour = '')
ggsave2x('../plots/sens_pH', height = 2.2, width = 4.5)

d1 <- datin[set == 'air.temp', ]
d2 <- pdat[parset == 3 & set == 'air.temp', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = expression('Air temperature'~(degree*C)), y = '168 h emission (frac. TAN)', colour = '')
ggsave2x('../plots/sens_temp', height = 2.2, width = 4.5)

d1 <- datin[set == 'wind.2m', ]
d2 <- pdat[parset == 3 & set == 'wind.2m', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free_x') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = expression('Wind speed'~(m~s^'-1')), y = '168 h emission (frac. TAN)', colour = '')
ggsave2x('../plots/sens_wind', height = 2.2, width = 4.5)

# Derivatives
d <- qdat[set == 'man.dm' & app.mthd == 'bsth', ]
d3 <- pdat[set == 'man.dm' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedx90), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedxmd), linewidth = 0.7, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Slurry DM (%)', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens_DM', height = 2.2, width = 4.5)

d <- qdat[set == 'man.ph' & app.mthd == 'bsth', ]
d3 <- pdat[set == 'man.ph' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedx90), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedxmd), linewidth = 0.7, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Slurry pH', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens_pH', height = 2.2, width = 4.5)

d <- qdat[set == 'air.temp' & app.mthd == 'bsth', ]
d3 <- pdat[set == 'air.temp' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedx90), linewidth = 0.7, lty = '2222', colour = 'blue') +
  #geom_line(aes(y = dedxmd), linewidth = 0.7, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = expression('Air temperature'~(degree*C)), y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens_temp', height = 2.2, width = 4.5)

d <- qdat[set == 'wind.2m' & app.mthd == 'bsth', ]
d3 <- pdat[set == 'wind.2m' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedx90), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedxmd), linewidth = 0.7, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = expression('Wind speed'~(m~s^'-1')), y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens_wind', height = 2.2, width = 4.5)

d <- qdat[set == 'rain.rate' & app.mthd == 'bsth', ]
d3 <- pdat[set == 'rain.rate' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), linewidth = 0.7, lty = '2222', colour = 'blue') +
  geom_line(aes(y = dedx90), linewidth = 0.7, lty = '2222', colour = 'blue') +
  #geom_line(aes(y = dedxmd), linewidth = 0.7, col = 'gray45') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ man.source.nm, scale = 'free') +
  scale_color_viridis_d() +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = expression('Rainfall rate'~(mm~h^'-1')), y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens_rain', height = 2.2, width = 4.5)


