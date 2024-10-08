
# Acidification
dd <- dw3[ct %in% c('24', 'final')]
dd[ct == 'final', ct := ct.max]
dd[, ct := as.numeric(ct)]
dl <- subset(dd, ct > 24 & ((inst == 205 & rred < 0.1) | (inst == 211 & rred < 0.55) | (inst == 210 & rred < 0.6)))
dl[inst == 211, ct := -27]

ggplot(dd, aes(ct, rred, colour = factor(inst), group = iexper)) +
  geom_label(data = dl, aes(label = inst), nudge_x = 25, alpha = 0.5) +
  geom_line() +
  ylim(0, 1) +
  xlim(-27, 265) +
  theme_bw() +
  theme(legend.position = 'none', panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  labs(x = 'Time after application (h)', y = 'Relative acidification effect')
ggsave2x('../plots/acid_effect', height = 2.5, width = 3)

# Emission curves
#dd <- subset(idat, pmid %in% c(1529:1532))
dd <- idatp
d0 <- subset(dd, ct == ct.min)[, `:=` (ct = 0, e.rel = 0)]
dd <- rbind(d0, dd)
dl <- subset(dd, ct == ct.max)[man.ph == 5.2, e.rel := 0.35]
ep <- ggplot(dd, aes(ct, e.rel, colour = acid, group = pmid)) +
  geom_line(aes(y = e.rel.pred), lty = '1111', alpha = 0.85) +
  geom_line() +
  geom_text(data = dl, aes(label = man.ph), nudge_x = 9, size = 2, colour = 'black') +
  theme_bw() +
  theme(legend.position = 'none') +
  #scale_color_viridis_d(option = 'D') +
  labs(x = '', y = 'Emis. (frac. TAN)')

d0 <- subset(dd, ct == ct.min)[, `:=` (ct = 0, e.rel = 0)]
dd <- rbind(d0, dd)
dl <- subset(dd, ct == ct.min)[, ct := 0][man.ph == 5.2, j.NH3 := 0.4]
jp <- ggplot(dd, aes(ct, j.NH3 / tan.app, colour = acid, group = pmid)) +
  geom_step(aes(y = j.NH3.pred / tan.app), lty = '1111', alpha = 0.85) +
  geom_step() +
  geom_text(data = dl, aes(label = man.ph), nudge_x = -3, size = 2, colour = 'black') +
  theme_bw() +
  coord_cartesian(xlim = c(-5, 50)) +
  theme(legend.position = 'none') +
  #scale_color_viridis_d(option = 'D') +
  labs(x = 'Time after application (h)', y = expression('Flux'~('Frac. TAN'~h^'-1')))

p <- grid.arrange(ep, jp)
ggsave2x('../plots/acid_curves', p, height = 4, width = 2.5)

p <- grid.arrange(ep, jp, ncol = 2)
ggsave2x('../plots/acid_curves_wide', p, height = 2.7, width = 7)


