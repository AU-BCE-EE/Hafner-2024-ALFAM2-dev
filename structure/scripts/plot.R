
# Acidification
dd <- dw3[ct %in% c('24', 'final')]
dd[, ct.nm := factor(ct, levels = c('24', 'final'), labels = c('24 h', 'Final'))]
dl <- subset(dd, ct == 'final' & ((inst == 205 & rred < 0.1) | (inst == 211 & rred > 0.75) | (inst == 210 & rred < 0.6)))

ggplot(dd, aes(ct.nm, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_label(data = dl, aes(label = inst), nudge_x = 0.2) +
  ylim(0, 1) +
  theme_bw() +
  theme(legend.position = 'none', panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  labs(x = 'Emission period', y = 'Relative acidification effect')
ggsave2x('../plots/acid_effect', height = 2.5, width = 3)

dd <- subset(idat, pmid %in% c(1529:1532))
d0 <- subset(dd, ct == ct.min)[, `:=` (ct = 0, e.rel = 0)]
dd <- rbind(d0, dd)
dl <- subset(dd, ct == ct.max)
ep <- ggplot(dd, aes(ct, e.rel, colour = acid, group = pmid)) +
  geom_line() +
  geom_text(data = dl, aes(label = man.ph), nudge_x = 7, size = 1.7, colour = 'black') +
  theme_bw() +
  theme(legend.position = 'none') +
  scale_color_viridis_d(option = 'D') +
  labs(x = '', y = 'Emis. (frac. TAN)')

d0 <- subset(dd, ct == ct.min)[, `:=` (ct = 0, e.rel = 0)]
dd <- rbind(d0, dd)
dl <- subset(dd, ct == ct.min)[, ct := 0][man.ph == 5.2, ct := -2.8]
jp <- ggplot(dd, aes(ct, j.NH3, colour = acid, group = pmid)) +
  geom_step() +
  geom_text(data = dl, aes(label = man.ph), nudge_x = -2, size = 1.7, colour = 'black') +
  theme_bw() +
  coord_cartesian(xlim = c(-5, 50)) +
  theme(legend.position = 'none') +
  scale_color_viridis_d(option = 'D') +
  labs(x = 'Time after application (h)', y = expression('Flux'~(kg~ha^'-1'~h^'-1')))

p <- grid.arrange(ep, jp)

ggsave2x('../plots/acid_curves', p, height = 3.2, width = 2.5)


