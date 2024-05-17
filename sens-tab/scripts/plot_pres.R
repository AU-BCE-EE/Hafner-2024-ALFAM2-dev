
# Presentation figure 

set.seed(120812)
dd0 <- dat168[app.mthd %in% c('bc', 'bsth', 'os')]
dd1 <- dat168[pars != 'ps03' & app.mthd %in% c('bc', 'bsth', 'os')]
dd3 <- dat168[pars == 'ps03' & app.mthd %in% c('bc', 'bsth', 'os')]
ggplot(dd0, aes(sid, er, colour = pars.nm)) +
  geom_errorbar(aes(ymin = lwr, ymax = upr), alpha = 0.9, width = 0, lwd = 0.6, show.legend = FALSE) +
  geom_jitter(data = dd1, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  geom_point(data = dd3, alpha = 0.8, size = 1.7, width = 0.3, aes(shape = pars.nm)) +
  facet_wrap(~ app.mthd.nm, nrow = 1) +
  theme_bw() +
  theme(legend.position = 'top') +
  theme(axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x=element_blank()) +
  labs(x = '', y = '168 h emission (frac. applied TAN)', shape = '', colour = '')
ggsave2x('../plots/sens_comp_1row', height = 6/2.2, width = 16/2.2)

