# Plot cross-validation error estimates

# Set labels here
app.mthd.labels <- c('Broadcast DK', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection')
set.labels <- c('Incorporation DK', 'Acidification', 'Digestate', 'Other')
man.source.labels <- c('DK Pig', 'Cattle & others')

# Apply labels
cvdat168[, `:=` (pig.nm = factor(ifelse(man.source == 'pig', 'Pig', 'Cattle & others'), levels = c('Pig', 'Cattle & others'), labels = man.source.labels),
                 app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), labels = app.mthd.labels))]

cvdat168[, set.nm := factor(ifelse(incorp != 'none', 'Incorporation', ifelse(acid, 'Acidification', ifelse(digested, 'Digestate', 'Other'))), 
                         levels = c('Incorporation', 'Acidification', 'Digestate', 'Other'), labels = set.labels)]



ggplot(cvdat168, aes(app.mthd.nm, abs(ererr), fill = set.nm)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Model error (frac. applied TAN)', fill = '') +
  theme_bw() +
  coord_cartesian(ylim = c(0, 0.4)) +
  theme(legend.position = 'top', axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1))
ggsave2x('../plots-cross-val-pres/cross_val_error', height = 3.3, width = 6)

dd <- cvdat168[!app.mthd %in% c('os', 'cs')]
ggplot(dd, aes(app.mthd.nm, abs(rerr), fill = set.nm)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Error (frac. meas. emis.)', fill = '') +
  theme_bw() +
  coord_cartesian(ylim = c(0, 2)) +
  theme(legend.position = 'top')
ggsave2x('../plots-cross-val-pres/cross_val_rel_error', height = 2.7, width = 6)

ggplot(cvdat168, aes(app.mthd.nm, abs(rerr), fill = set.nm)) +
  geom_boxplot() +
  facet_grid(~ pig.nm) +
  labs(x = 'Application method', y = 'Error (frac. meas. emis.)', fill = '') +
  theme_bw() +
  theme(legend.position = 'top', axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  coord_cartesian(ylim = c(0, 3)) +
  theme(legend.position = 'top')
ggsave2x('../plots-cross-val-pres/cross_val_rel_error_all', height = 3.3, width = 6)


