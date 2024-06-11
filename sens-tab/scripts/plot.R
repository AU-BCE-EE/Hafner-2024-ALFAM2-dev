
dat168[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot injection', 'Closed slot injection'))]
dat168[, pars.nm := factor(pars, levels = c('ps01', 'ps02', 'ps03', 'ALFAM'), labels = c(1:3, 'ALFAM'))]

dat168 <- dat168[pars != 'ps01' | app.mthd != 'cs', ]

# Set cs and incorporation CI to NA
#dat168[rain.cum > 0 | app.mthd.cs == 1, `:=` (lwr = NA, upr = NA)]
dat168[app.mthd.cs == 1, `:=` (lwr = NA, upr = NA)]
dat168[incorp != 'none', `:=` (lwr = NA, upr = NA)]
dat168[app.mthd.cs == 1 & pars == 'ALFAM', er := NA]

# Get position for text
eb0 <- dat168[pars != 'ALFAM', .(mx = max(c(er, upr), na.rm = TRUE)), by = .(sid, app.mthd.nm)]
eb <- dat168[, .(mx = max(c(er, upr), na.rm = TRUE)), by = .(sid, app.mthd.nm)]

ggplot(dat168, aes(sid, er, colour = pars.nm)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), alpha = 0.9, width = 0, lwd = 0.6, show.legend = FALSE) +
  geom_point(alpha = 0.8, size = 0.9) +
  geom_text(data = eb, aes(y = mx, label = sid), colour = 'black', nudge_y = 0.07, size = 1.9, angle = 90) +
  facet_wrap(~ app.mthd.nm, ncol = 2) +
  theme_bw() +
  theme(legend.position = c(0.77, 0.15)) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = '', y = '168 h emission (frac. applied TAN)', colour = '')
ggsave2x('../plots/sens_comp', height = 5, width = 6)

# 1 column
set.seed(120812)
dd <- dat168[pars != 'ALFAM', ]
dd1 <- dd[pars != 'ps03']
dd3 <- dd[pars == 'ps03']
ggplot(dd, aes(sid, er, colour = pars.nm)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), alpha = 0.9, width = 0, lwd = 0.6, show.legend = FALSE) +
  geom_jitter(data = dd1, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  geom_point(data = dd3, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  geom_text(data = eb0, aes(y = mx, label = sid), colour = 'black', nudge_y = 0.07, size = 2.2) +
  facet_wrap(~ app.mthd.nm, ncol = 1) +
  theme_bw() +
  theme(legend.position = 'top') +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = '', y = '168 h emission (frac. applied TAN)', shape = '', colour = '')
ggsave2x('../plots/sens_comp_1col', height = 8, width = 5)

set.seed(092615)
dd1 <- dat168[pars != 'ps03']
dd3 <- dat168[pars == 'ps03']
ggplot(dat168, aes(sid, er, colour = pars.nm, shape = pars.nm)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), alpha = 0.9, width = 0, lwd = 0.6, show.legend = FALSE) +
  geom_jitter(data = dd1, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  geom_point(data = dd3, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  geom_text(data = eb, aes(y = mx, label = sid, shape = NULL), colour = 'black', nudge_y = 0.07, size = 2.2) +
  facet_wrap(~ app.mthd.nm, ncol = 1) +
  theme_bw() +
  theme(legend.position = 'top') +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = '', y = '168 h emission (frac. applied TAN)', shape = '', colour = '')
ggsave2x('../plots/sens_comp_1col_ALFAM', height = 8, width = 5)


dd <- dat168[pars == 'ps03', ]
ggplot(dd, aes(er, er, colour = app.mthd.nm)) +
  geom_abline(intercept = 0, slope = 1.2, colour = 'gray45') +
  geom_abline(intercept = 0, slope = 0.8, colour = 'gray45') +
  geom_point() +
  geom_errorbar(aes(ymin = lwr, ymax = upr), width = 0) +
  facet_wrap(~ app.mthd.nm) 
ggsave2x('../plots/sens_ci', height = 5, width = 5)
