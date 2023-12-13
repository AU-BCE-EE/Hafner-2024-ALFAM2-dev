# Plot parameter values

ggplot(parsl, aes(reorder(parameter, ppar), value, colour = pars.nm, group = pars.nm)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, shape = 1, alpha = 0.5) +
  geom_line() +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Parameter value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_all', height = 5, width = 9)

# Keep NA values to get breaks in lines
dd <- droplevels(subset(parsl, pars %in% c('ps1', 'ps2', 'ps3') & !is.na(value)))
ggplot(dd, aes(reorder(parameter, ppar), value, colour = pars.nm, group = pars.nm)) +
  geom_hline(yintercept = 0, lty = 2) +
  geom_point(size = 2, alpha = 0.8) +
  geom_line(alpha = 0.5) +
  facet_wrap(~ ppar, scale = 'free') +
  labs(x = 'Secondary parameter', y = 'Parameter value', colour = 'Parameter\nset') +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) 
ggsave2x('../plots-pars/pars_sel', height = 5, width = 6)
