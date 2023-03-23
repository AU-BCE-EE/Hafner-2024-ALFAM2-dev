

parsl[, ppar := gsub('^.+([fr][0-5])$', '\\1', parameter)]
spars <- unique(parsl[, parameter])
parsl[, parameter := factor(parameter, levels = spars[order(gsub('^.+([fr][0-5])$', '\\1', spars))])]

ggplot(parsl, aes(reorder(parameter, ppar), value, colour = pars, group = pars)) +
  geom_point() +
  geom_line() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
