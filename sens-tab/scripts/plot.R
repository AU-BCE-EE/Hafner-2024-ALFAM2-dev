
datc[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot injection', 'Closed slot injection'))]
datc[, pars.nm := factor(pars, levels = c('ps01', 'ps02', 'ps03'), labels = 1:3)]

datc <- datc[pars != 'ps01' | app.mthd != 'cs', ]

# Set cs and incorporation CI to NA
#datc[rain.cum > 0 | app.mthd.cs == 1, `:=` (lwr = NA, upr = NA)]
datc[app.mthd.cs == 1, `:=` (lwr = NA, upr = NA)]
datc[incorp != 'none', `:=` (lwr = NA, upr = NA)]
datc$app.mthd.cs
datc[app.mthd.cs == 1, ]

# Get position for text
eb <- datc[, .(mx = max(c(er, upr), na.rm = TRUE)), by = .(sid, app.mthd.nm)]

ggplot(datc, aes(sid, er, colour = pars.nm)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), alpha = 0.9, width = 0, lwd = 0.6, show.legend = FALSE) +
  geom_point(alpha = 0.8, size = 0.9) +
  geom_text(data = eb, aes(y = mx, label = sid), colour = 'black', nudge_y = 0.07, size = 1.9, angle = 90) +
  facet_wrap(~ app.mthd.nm, ncol = 2) +
  theme_bw() +
  theme(legend.position = c(0.77, 0.15)) +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = '', y = '168 h emission (frac. applied TAN)', colour = 'Parameter set')
ggsave2x('../plots/sens_comp', height = 5, width = 5)

dd <- datc[pars == 'ps03', ]
ggplot(dd, aes(er, er, colour = app.mthd.nm)) +
  geom_abline(intercept = 0, slope = 1.2, colour = 'gray45') +
  geom_abline(intercept = 0, slope = 0.8, colour = 'gray45') +
  geom_point() +
  geom_errorbar(aes(ymin = lwr, ymax = upr), width = 0) +
  facet_wrap(~ app.mthd.nm) 
ggsave2x('../plots/sens_ci', height = 5, width = 5)
