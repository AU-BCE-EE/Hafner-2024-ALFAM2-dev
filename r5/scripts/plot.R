vl <- data.table(ct = c(12, 100), rain = 'Rain')

ggplot(preds, aes(ct, er, colour = pars, lty = rain, group = sim)) +
  geom_line() +
  theme_bw() +
  theme(legend.position = 'right') +
  labs(x = 'Time since application (h)', y = 'Relative emis. (frac. TAN)', colour = 'Parameter set', lty = '')
ggsave2x('../plots/r5_demo', height = 2.3, width = 3.5)
