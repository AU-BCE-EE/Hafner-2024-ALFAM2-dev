# Plot cross-validation error estimates

ggplot(cvdat168, aes(app.mthd.nm, abs(aerr), fill = set)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Absolute error (frac. TAN)', fill = '') +
  theme_bw() +
  coord_flip(ylim = c(0, 0.4)) +
  theme(legend.position = 'top') +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))
ggsave2x('../plots-cross-val/cross_val_error', height = 3.3, width = 4)

#dd <- cvdat168[!app.mthd %in% c('os', 'cs')]
ggplot(cvdat168, aes(app.mthd.nm, abs(rerr), fill = set)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Relative error (frac. meas. emis.)', fill = '') +
  theme_bw() +
  coord_flip(ylim = c(0, 5)) +
  #coord_flip() +
  theme(legend.position = 'top') +
  guides(fill = guide_legend(nrow = 2, byrow = TRUE))
ggsave2x('../plots-cross-val/cross_val_rel_error', height = 3.3, width = 4)

