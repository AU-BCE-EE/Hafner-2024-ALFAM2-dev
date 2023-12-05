
datc[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot injection', 'Closed slot injection'))]
datc[, pars.nm := factor(pars, levels = c('ps01', 'ps02', 'ps03'), labels = 1:3)]

datc <- datc[pars != 'ps01' | app.mthd != 'cs', ]
datc[, mx := max(er), by = .(sid, app.mthd)]
datc[order(app.mthd, sid), ]
txt <- datc[er == mx, ]

ggplot(datc, aes(sid, er, colour = pars.nm)) +
  #geom_line(aes(group = sid), colour = 'gray55') +
  geom_point(alpha = 0.6, size = 0.4) +
  geom_line(alpha = 0.6) +
  geom_text(data = txt, aes(label = sid), colour = 'black', nudge_y = 0.06, size = 1.3, angle = 90) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  theme(legend.position = c(0.83, 0.21)) +
  labs(x = 'Simulation key', y = '168 h emission (frac. applied TAN)', colour = 'Parameter set')
ggsave2x('../plots/sens_comp', height = 3, width = 5)
