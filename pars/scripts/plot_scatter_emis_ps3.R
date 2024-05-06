# Scatter plots of cumulative emission for model evaluation for par set 3

ddf <- droplevels(subset(dp168, pars == 'ps3' & dataset == 1))
ggplot(ddf, aes(er.pred, er, colour = inst, shape = set)) +
  geom_abline(intercept = 0, slope = 1, col = 'gray45') +
  geom_point(bg = 'gray45', size = 3, alpha = 0.8) +
  scale_shape_manual(values = c(20, 2, 3, 1)) +
  facet_wrap( ~ app.mthd.nm, ncol = 3) +
  #scale_color_viridis_d() +
  labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', 
       y = 'Measured emission (frac. applied TAN)',
       colour = '', shape = '') +
  theme_bw() +
  theme(legend.position = c(0.8, 0.27)) +
  guides(color = 'none') +
  xlim(0, 1) +
  ylim(0, 1) +
  coord_fixed()
ggsave2x('../plots-scatter/e168_comp_ps3_paper', height = 5.5, width = 6)

# Repeat, but highlight institutions
for (i in unique(ddf[, inst])) {

  dd <- ddf[inst == i, ]

  ggplot(ddf, aes(er.pred, er, shape = set)) +
    geom_abline(intercept = 0, slope = 1, col = 'gray45') +
    geom_point(colour = 'gray55', size = 3, alpha = 0.6) +
    geom_point(data = dd, colour = 'red', size = 3) +
    scale_shape_manual(values = c(20, 2, 3, 1)) +
    facet_wrap( ~ app.mthd.nm, ncol = 3) +
    scale_color_viridis_d() +
    labs(x = 'ALFAM2 par. set 3 calculated emission (frac. applied TAN)', 
         y = 'Measured emission (frac. applied TAN)',
         colour = '', shape = '') +
    theme_bw() +
  theme(legend.position = c(0.8, 0.27)) +
    xlim(0, 1) +
    ylim(0, 1) +
    coord_fixed()
  ggsave2x(paste0('../plots-scatter/e168_comp_ps3_', i), height = 5.5, width = 6)

}
