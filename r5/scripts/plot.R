vl <- data.table(ct = c(12, 100), rain = 'Rain')

ggplot(preds, aes(ct, er, colour = pars, lty = rain, group = sim)) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'right') +
  labs(x = 'Time since application (h)', y = 'Relative emis. (frac. TAN)', colour = 'Parameter set', lty = '')
ggsave2x('../plots/r5_demo_emis', height = 2.3, width = 3.5)

ggplot(preds, aes(ct, log10(j), colour = pars, lty = rain, group = sim)) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'right') +
  labs(x = 'Time since application (h)', y = expression(Log[10]~'flux'~(kg~h^'-1'~ha^'-1')), colour = 'Parameter set', lty = '')
ggsave2x('../plots/r5_demo_flux', height = 2.3, width = 3.5)

ggplot(preds, aes(ct, s, colour = pars, lty = rain, group = sim)) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'right') +
  labs(x = 'Time since application (h)', y = expression(Log[10]~'flux'~(kg~h^'-1'~ha^'-1')), colour = 'Parameter set', lty = '')
ggsave2x('../plots/r5_demo_slow', height = 2.3, width = 3.5)
