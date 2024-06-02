
dpreds[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'ps3'), labels = 1:3)]

dd <- subset(dpreds, pars %in%  c('ps1', 'ps2', 'ps3') & dataset == 1)
ggplot(dd, aes(cta, resid.er, colour = factor(country), group = pmid)) +
  geom_line(alpha = 0.6) +
  facet_grid(app.mthd.nm ~ pars.nm) +
  coord_cartesian(xlim = c(0, 500)) +
  labs(x = 'Time (h)', y = 'Model error (frac. applied TAN)', colour = 'Country') +
  theme(legend.position = 'top') +
  theme_bw() +
ggsave2x('../plots-resids/long_resids', height = 6, width = 7)

dd <- subset(dpreds, pars %in%  c('ps1', 'ps2', 'ps3') & dataset == 1 & cta <= 24)
ggplot(dd, aes(app.mthd.nm, resid.j, fill = pars.nm)) +
  geom_boxplot() +
  labs(x = 'Time (h)', y = 'Model error (frac. applied TAN)', colour = 'Country') +
  theme(legend.position = 'top') +
  coord_cartesian(ylim = c(-2, 2)) +
  theme_bw() +
ggsave2x('../plots-resids/short_resids_box', height = 6, width = 7)

dd <- subset(dpreds, pars %in%  c('ps1', 'ps2', 'ps3') & dataset == 1 & cta > 48 & !is.na(resid.er) & !(app.mthd == 'cs' & pars == 'ps1'))
dls <- dd[, as.list(coef(lm(resid.er ~ cta))), by = .(pmid, app.mthd, app.mthd.nm, pars,  pars.nm)]
ggplot(dls, aes(app.mthd.nm, 1000 * cta, fill = pars.nm)) +
  geom_boxplot() +
  theme_bw() +
  theme(legend.position = 'top') +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
  labs(x = 'Application method', y = expression(1000 %*% 'slope in error'), fill = 'Parameter set') 
ggsave2x('../plots-resids/long_resids_box', height = 4, width = 4)
