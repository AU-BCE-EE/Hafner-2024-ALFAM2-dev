# Plot cross-validation error estimates

ggplot(cvdat168, aes(app.mthd.nm, abs(ererr), fill = set)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Model error (frac. applied TAN)', fill = '') +
  theme_bw() +
  coord_cartesian(ylim = c(0, 0.4)) +
  theme(legend.position = 'top', axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
ggsave2x('../plots-cross-val/cross_val_error', height = 3.3, width = 6)

dd <- cvdat168[!app.mthd %in% c('os', 'cs')]
ggplot(dd, aes(app.mthd.nm, abs(rerr), fill = set)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Error (frac. meas. emis.)', fill = '') +
  theme_bw() +
  coord_cartesian(ylim = c(0, 2)) +
  theme(legend.position = 'top')
ggsave2x('../plots-cross-val/cross_val_rel_error', height = 2.7, width = 6)


