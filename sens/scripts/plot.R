
dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                            labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
dat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), 
                       labels = c('DM', 'pH', 'Air temperature', 'Wind speed', 'Rain'))]

pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
pdat[, app.mthd.ab := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                             labels = c('BC', 'TH', 'TS', 'OSI', 'CSI'))]
pdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), 
                        labels = c(expression('DM'~(`%`)), expression('pH'), 
                                   expression('Air temp' ~(degree*C)), expression('Wind speed'~(m~s^'-1')), 
                                   expression('Rain'~(mm~h^'-1'))))]

qdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]
qdat[, set.nm := factor(set, levels = c('man.dm', 'man.ph', 'air.temp', 'wind.2m', 'rain.rate'), 
                        labels = c(expression('DM'~(`%`)), expression('pH'), 
                                   expression('Air temp' ~(degree*C)), expression('Wind speed'~(m~s^'-1')), 
                                   expression('Rain'~(mm~h^'-1'))))]

d1 <- pdat[parset == 3 & man.source != 'pig' & !outsidein, ]
d2 <- pdat[parset == 3 & man.source != 'pig', ]
d2[, xvalmax := max(xval), by = .(set, app.mthd)]
d3 <- d2[xval == xvalmax, ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x', label = 'label_parsed') +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens5_cattle', height = 5, width = 5)

d1 <- pdat[parset == 3 & man.source == 'pig' & !outsidein, ]
d2 <- pdat[parset == 3 & man.source == 'pig', ]
ggplot(d2, aes(xval, er.pred, colour = app.mthd.nm)) + 
  geom_line(lty = '1111', linewidth = 0.7) +
  geom_line(data = d1, linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free_x', label = 'label_parsed') +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = '168 h relative emission (frac. TAN)', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/sens5_pig', height = 5, width = 5)

# Derivatives
pd <- pdat[man.source != 'pig' & app.mthd == 'bsth', ]
d <- qdat[man.source != 'pig' & app.mthd == 'bsth', ]
d3 <- pdat[man.source != 'pig' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  geom_line(data = pd, aes(y = dedx, group = parset), colour = 'gray45', linewidth = 0.7, alpha = 0.2) +
  facet_wrap(~ set.nm, scale = 'free', label = 'label_parsed', ncol = 2) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens5_cattle', height = 5, width = 5)

pd <- pdat[man.source == 'pig' & app.mthd == 'bsth', ]
d <- qdat[man.source == 'pig' & app.mthd == 'bsth', ]
d3 <- pdat[man.source == 'pig' & app.mthd == 'bsth' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_hline(yintercept = 0, colour = 'gray45') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  geom_line(data = pd, aes(y = dedx, group = parset), colour = 'gray45', linewidth = 0.7, alpha = 0.2) +
  facet_wrap(~ set.nm, scale = 'free', label = 'label_parsed', ncol = 2) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens5_pig', height = 5, width = 5)

# Derivatives
pd <- pdat[man.source != 'pig' & app.mthd == 'bsth' & set != 'rain.rate', ]
d <- qdat[man.source != 'pig' & app.mthd == 'bsth' & set != 'rain.rate', ]
d3 <- pdat[man.source != 'pig' & app.mthd == 'bsth' & set != 'rain.rate' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_line(data = pd, aes(y = dedx, group = parset), colour = 'gray55', linewidth = 0.7, alpha = 0.15) +
  geom_hline(yintercept = 0, colour = 'gray55') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free', label = 'label_parsed', ncol = 2) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens4_cattle', height = 5, width = 5)

d <- qdat[man.source != 'pig'  & set != 'rain.rate' & app.mthd %in% c('bc', 'bsth') & set != 'rain.rate', ]
d3 <- pdat[man.source != 'pig' & set != 'rain.rate' & app.mthd %in% c('bc', 'bsth') & parset == '3', ]
ggplot(d, aes(xval, dedx10, colour = app.mthd.nm)) + 
  geom_hline(yintercept = 0, colour = 'gray55') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free', label = 'label_parsed', ncol = 2) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens4_am_cattle', height = 5, width = 5)

pd <- pdat[man.source == 'pig' & app.mthd == 'bsth' & set != 'rain.rate', ]
d <- qdat[man.source == 'pig' & app.mthd == 'bsth' & set != 'rain.rate', ]
d3 <- pdat[man.source == 'pig' & app.mthd == 'bsth' & set != 'rain.rate' & parset == '3', ]
ggplot(d, aes(xval, dedx10)) + 
  geom_line(data = pd, aes(y = dedx, group = parset), colour = 'gray55', linewidth = 0.7, alpha = 0.15) +
  geom_hline(yintercept = 0, colour = 'gray55') +
  geom_line(aes(y = dedx10), lty = '2222') +
  geom_line(aes(y = dedx90), lty = '2222') +
  geom_line(data = d3, aes(y = dedx), linewidth = 0.7) +
  facet_wrap(~ set.nm, scale = 'free', label = 'label_parsed') +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Predictor variable value', y = 'Emission derivative', colour = '') +
  guides(colour = guide_legend(nrow = 2))
ggsave2x('../plots/dsens4_pig', height = 5, width = 5)
