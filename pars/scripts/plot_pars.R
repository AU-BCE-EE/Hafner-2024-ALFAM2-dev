

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

dd <- subset(parsl, pars %in% c('ps1', 'ps2', 'p1'))
dd[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'p1'), labels = 1:3)]
ggplot(dd, aes(reorder(parameter, ppar), value, colour = pars.nm, group = pars)) +
  geom_point(size = 2, shape = 1) +
  geom_line() +
  labs(x = 'Secondary parameter', y = 'Value', colour = 'Parameter\nset') +
  scale_colour_viridis_d() +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_sel', height = 3.4, width = 5)
