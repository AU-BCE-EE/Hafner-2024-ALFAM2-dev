
ggplot(idat, aes(j.NH3, jrank, colour = inst, group = pmid))  +
  geom_vline(xintercept = 0, colour = 'gray45') +
  geom_line(alpha = 0.8) +
  geom_point(data = mn, shape = 21, colour = 'black', aes(fill = inst)) +
  facet_wrap(~ inst) +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = 'Average interval flux', y = 'Relative rank', colour = 'Institution code') +
  coord_cartesian(xlim = c(-0.05, 0.05))
ggsave('../plots/ranks.png', height = 4, width = 4)

mn[, clr := ifelse(j.NH3 < 0, 'a', ifelse(j.NH3 > 0, 'b', 'c'))]
ggplot(mn, aes(inst, j.NH3, colour = clr, group = pmid)) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  theme_bw() +
  theme(legend.position = 'none', axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(x = 'Institution code', y = expression('Minimum flux'~(kg~N~ha^'-1'~h^'-1'))) +
  coord_cartesian(ylim = c(-0.05, 0.05))
ggsave('../plots/min.png', height = 3, width = 3.5)

mnsub1[, clr := ifelse(j.NH3 < 0, 'a', ifelse(j.NH3 > 0, 'b', 'c'))]
ggplot(mnsub1, aes(inst, j.NH3, colour = clr, group = pmid)) +
  geom_jitter(width = 0.2, alpha = 0.5) +
  theme_bw() +
  theme(legend.position = 'none', axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  labs(x = 'Institution code', y = expression('Minimum flux'~(kg~N~ha^'-1'~h^'-1'))) +
  coord_cartesian(ylim = c(-0.05, 0.05))
ggsave('../plots/min_sub1.png', height = 3, width = 3.5)

