
pdat <- pdat[set != 'ref', ]

pdat[, xmx := max(xval.norm), by = set]
pdat[, man.source.nm := oneupper(man.source)]
lbs <- pdat[xval.norm == xmx, ]
lbs[, txt := as.integer(factor(set))]

unique(lbs[, .(set, txt)])

d0 <- pdat[set != 'app.mthd', ]
dd <- pdat[set == 'app.mthd', ]
ggplot(d0, aes(xval.norm, er.pred, colour = set)) + 
  geom_line() +
  geom_point(data = dd) +
  geom_line(data = dd, lty = '1111') +
  geom_text(data = lbs, aes(label = txt), nudge_x = 0.07) +
  facet_wrap(~ man.source.nm) +
  labs(x = 'Normalized variable value', y = 'Predicted 168 h emission (frac. TAN)') +
  ylim(0, 0.6) +
  theme_bw() +
  theme(legend.position = 'null')
ggsave2x('../plots/effect_size', height = 3, width = 5)
