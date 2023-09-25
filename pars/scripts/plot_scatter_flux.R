# Evaluation plots

dpreds.plot <- copy(dpreds)

dpreds.plot[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dpreds.plot[, `:=` (acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
                    digested.nm = factor(ifelse(digested, 'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
                    pig.nm = factor(ifelse(man.source.pig == 1, 'Pig', 'Cattle &\nothers'), levels = c('Cattle &\nothers', 'Pig')),
                    incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]


dpreds.plot$set <- ifelse(dpreds.plot$incorp != 'none', 'Incorporation', ifelse(dpreds.plot$acid, 'Acidification', 'Neither'))

dpreds.plot <- dpreds.plot[!is.na(j + j.pred), ]
dpreds.plot <- dpreds.plot[j < 1E-3, j := 1E-3 ]

for (i in unique(dpreds.plot$pars)) {

  ddf <- subset(dpreds.plot, pars == i & dataset == 1)
  ggplot(ddf, aes(log10(j.pred), log10(j), colour = app.mthd, shape = set)) +
    geom_abline(intercept = 0, slope = 1, col = 'gray45') +
    geom_line(alpha = 0.3) +
    scale_shape_manual(values = c(1, 2, 20)) +
    labs(x = 'Calculated', 
         y = 'Measured',
         colour = '', shape = '') +
    theme(legend.position = 'top') +
    theme(aspect.ratio = 1) +
    guides(colour = guide_legend(nrow = 1))
  ggsave(paste0('../plots-scatter/log_flux_comp_', i, '.png'), height = 5, width = 5)

  ddf <- subset(dpreds.plot, pars == i & dataset == 1)
  ggplot(ddf, aes(j.pred, j, colour = app.mthd, shape = set)) +
    geom_abline(intercept = 0, slope = 1, col = 'gray45') +
    geom_line(alpha = 0.3) +
    geom_point(alpha = 0.8) +
    scale_shape_manual(values = c(1, 2, 20)) +
    labs(x = 'Calculated', 
         y = 'Measured',
         colour = '', shape = '') +
    theme(legend.position = 'top') +
    theme(aspect.ratio = 1) +
    guides(colour = guide_legend(nrow = 1))
  ggsave(paste0('../plots-scatter/flux_comp_', i, '.png'), height = 5, width = 5)
}
