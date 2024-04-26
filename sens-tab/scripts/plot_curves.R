
dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                            labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dat[, pars.nm := factor(pars, levels = c('ps01', 'ps02', 'ps03'), labels = 1:3)]
dat[, sid.nm := factor(paste('Scenario', sid), levels = paste('Scenario', sort(as.numeric(unique(sid)))))]

dd <- dat[sid %in% c(1, 2, 3, 10, 11) & (app.mthd != 'cs' | pars != 'ps01'), ]
t0 <- copy(dd)
t0[, `:=` (ct = 0, er = 0)]
t0 <- t0[!duplicated(t0[, .(sid, app.mthd, pars, ct, er)]), ]
dd <- rbind(t0, dd)

ggplot(dd, aes(ct, er, colour = pars.nm)) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'top') +
  facet_grid(sid.nm ~ app.mthd.nm) +
  labs(x = 'Time since application (h)', y = 'Cumulative emission (frac. applied TAN)', colour = 'Parameter set')
ggsave2x('../plots/sens_curves', height = 7, width = 6.6)
