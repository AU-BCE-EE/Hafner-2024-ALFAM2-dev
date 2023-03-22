vl <- data.table(ct = c(12, 100), rain = 'Rain')

ggplot(preds, aes(ct, er, colour = pars)) +
  geom_vline(data = vl, aes(xintercept = ct), lty = '1111') +
  geom_line() +
  facet_wrap(~ rain) +
  theme_bw() +
  theme(legend.position = 'top') +
  labs(x = 'Time since application (h)', y = 'Relative emis. (frac. TAN)', colour = 'Parameter set')
ggsave2x('../plots/r5_demo', height = 3, width = 4)
