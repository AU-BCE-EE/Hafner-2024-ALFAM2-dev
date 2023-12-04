
rm(list = ls())

source('packages.R')
source('load.R')
source('merge.R')

idat[is.na(cta), cta := ct]
idat <- idat[meas.tech2 == 'micro met' & cta >= 0, ]
idat[, minj := j.NH3 == min(j.NH3), by = pmid]
idat[, jrank := rank(j.NH3) / length(j.NH3), by = pmid]
mn <- idat[minj == TRUE, ]

table(idat$inst)

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
