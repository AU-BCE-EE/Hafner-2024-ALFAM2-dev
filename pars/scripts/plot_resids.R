# Plots of residuals, looking for trends

for (p in sort(unique(dp168$pars))) {

  ddf <- subset(dp168, pars == p & dataset == 1)

  ggplot(ddf, aes(air.temp.24, resid.er, colour = inst, group = pmid)) +
    geom_point(alpha = 0.4) +
    facet_wrap(~ app.mthd.nm, scale = 'free') +
    geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
    theme_bw() +
    labs(colour = 'Institution', x = expression('24 h ave. air temperature'~(degree*C)), y = 'Emission residual (frac. applied TAN)')
  ggsave2x(paste0('../plots-resids/resids_emis_temp_', p), height = 4.2, width = 6)

  ggplot(ddf, aes(man.ph, resid.er, colour = inst, group = pmid)) +
    geom_point(alpha = 0.4) +
    facet_wrap(~ app.mthd.nm, scale = 'free') +
    geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
    theme_bw() +
    labs(colour = 'Institution', x = 'Slurry pH', y = 'Emission residual (frac. applied TAN)')
  ggsave2x(paste0('../plots-resids/resids_emis_pH_', p), height = 4.2, width = 6)

  ggplot(ddf, aes(man.dm, resid.er, colour = inst, group = pmid)) +
    geom_point(alpha = 0.4) +
    facet_wrap(~ app.mthd.nm, scale = 'free') +
    geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
    theme_bw() +
    labs(colour = 'Institution', x = 'Slurry DM', y = 'Emission residual (frac. applied TAN)')
  ggsave2x(paste0('../plots-resids/resids_emis_DM_', p), height = 4.2, width = 6)

}
