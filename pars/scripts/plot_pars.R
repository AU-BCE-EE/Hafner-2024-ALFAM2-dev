# Plot parameter values

ggplot(parsl, aes(reorder(parameter, ppar), value, colour = pars, group = pars)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, shape = 1, alpha = 0.5) +
  geom_line() +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Parameter value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_all', height = 5, width = 9)

dd <- subset(parsl, pars %in% c('ps1', 'ps2', 'ps3'))
ggplot(dd, aes(reorder(parameter, ppar), value, colour = pars, group = pars)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, shape = 1, alpha = 0.5) +
  geom_line() +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Parameter value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_sel', height = 5, width = 9)
