
parsl[, ppar := gsub('^.+([fr][0-5])$', '\\1', parameter)]
spars <- unique(parsl[, parameter])
parsl[, parameter := factor(parameter, levels = spars[order(gsub('^.+[fr]([0-5])$', '\\1', spars))])]

dd <- subset(parsl, pars == 'p1')
ggplot(parsl, aes(reorder(parameter, ppar), value, colour = pars, group = pars)) +
  geom_point(alpha = 0.5) +
  geom_line(alpha = 0.5) +
  geom_point(data = dd) +
  labs(x = 'Secondary parameter', y = 'Value', colour = 'Par. set') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
ggsave2x('../plots-pars/pars', height = 4.4, width = 6)

dd <- subset(parsl, pars %in% c('ps1', 'ps2', 'ps3', 'p1', 'h1', 'nullA', 'nullB', 'nullC'))
dd[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'ps3', 'p1', 'h1', 'nullA', 'nullB', 'nullC'), labels = c(1:3, 'p1', 'h1', 'Null A', 'Null B', 'Null C'))]
#dd[, parameter := gsub('\\.ni', '', parameter)]
dd3 <- subset(dd, pars == 'p1')
ggplot(dd, aes(reorder(parameter, ppar), value, colour = pars.nm, group = pars)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, shape = 1, alpha = 0.5) +
  geom_point(data = dd3, size = 2, alpha = 0.6) +
  geom_line() +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_sel', height = 6, width = 6)

dd <- subset(parsl, pars %in% c('p1', 'h1', 'h2', 'h3', 'h4', 'h5', 'ps1', 'ps2'))
dd3 <- subset(dd, pars == 'p1')
ggplot(dd, aes(reorder(parameter, ppar), value, colour = pars, group = pars)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, shape = 1, alpha = 0.5) +
  geom_point(data = dd3, size = 2, alpha = 0.6) +
  geom_line() +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_sel', height = 6, width = 6)
