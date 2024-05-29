# Scatter plots of cumulative emission for model evaluation

for (i in unique(dp168[, pars])) {

  fname <- paste0('../plots-scatter/e168_comp_', i, '.png')

  if (!file.exists(fname)) {

    ddf <- subset(dp168, pars == i & dataset == 1)
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
      scale_x_continuous(labels = formatLabels) +
      coord_fixed(xlim = c(0, 1), ylim = c(0, 1))
    ggsave(fname, height = 5.5, width = 6)

  }
}
