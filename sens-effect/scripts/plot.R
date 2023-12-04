
pdat <- pdat[set != 'ref', ]

pdat[, xmx := max(xval.norm), by = set]
pdat[, man.source.nm := oneupper(man.source)]
lbs <- pdat[xval.norm == xmx, ]
lbs[, txt := as.integer(factor(set))]

d0 <- pdat[set != 'app.mthd', ]
dd <- pdat[set == 'app.mthd', ]
p <- ggplot(d0, aes(xval.norm, er.pred, colour = set)) + 
       geom_line() +
       geom_point(data = dd) +
       geom_line(data = dd, lty = '1111') +
       geom_text(data = lbs, aes(label = txt), nudge_x = 0.07) +
       facet_wrap(~ man.source.nm) +
       labs(x = 'Normalized variable value', y = 'Pred. 168 h emis. (frac. TAN)') +
       ylim(0, 0.6) +
       theme_bw() +
       theme(legend.position = 'null')
ggsave2x('../plots/effect_size', p, height = 2.5, width = 5)

# Make plot with set info for caption details
p <- p + geom_text(data = lbs, aes(label = set), nudge_x = 0.07) +
  xlim(-1, 1.4)
ggsave2x('../plots/effect_size_labs', p, height = 3, width = 5)
