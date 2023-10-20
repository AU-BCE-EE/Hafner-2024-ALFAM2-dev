# Scatter plots of cumulative emission for model evaluation

for (i in unique(dp168[, pars])) {

  fname <- paste0('../plots-scatter/e168_comp_', i, '.png')

  if (!file.exists(fname)) {

    ddf <- subset(dp168, pars == i & dataset == 1)
    ggplot(ddf, aes(er.pred, er, colour = country, shape = set)) +
      geom_abline(intercept = 0, slope = 1, col = 'gray45') +
      geom_point(bg = 'gray45') +
      #geom_line(stat = 'smooth', method = 'lm', se = FALSE, alpha = 0.6) +
      scale_shape_manual(values = c(1, 2, 20)) +
      facet_grid(pig.nm ~ app.mthd.nm) +
      labs(x = 'Calculated', 
           y = 'Measured',
           colour = '', shape = '') +
      theme_bw() +
      theme(legend.position = 'top') +
      xlim(0, 0.9) +
      guides(colour = guide_legend(nrow = 1))
    ggsave(fname, height = 6.2, width = 11.02)

  }
}
