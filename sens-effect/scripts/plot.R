
pdat <- pdat[set != 'ref', ]

pdat[, xmx := max(xval.norm), by = set]
pdat[, xmn := min(xval.norm), by = set]
pdat[, man.source.nm := oneupper(man.source)]
lbs <- pdat[xval.norm == xmx, ]
lbs[, txt := as.integer(factor(set))]
lbs[, txt := factor(set, levels = c('air.temp', 'wind.2m', 'rain.rate', 'man.dm', 'man.ph', 'app.mthd'),
                    labels = c('T', 'Wind', 'Rain', 'DM', 'pH', 'App.'))]

lbs[man.source == 'pig' & txt == 'T', txt := '\nT'] 
lbs[man.source == 'pig' & txt == 'pH', txt := '\npH'] 

# Subset of points for CLs
dc <- pdat[xval.norm == xmx | xval.norm == xmn, ]

d0 <- pdat[set != 'app.mthd', ]
dd <- pdat[set == 'app.mthd', ]
 ggplot(d0, aes(xval.norm, er.pred, colour = set)) + 
   geom_line() +
   geom_point(data = dd) +
   geom_line(data = dd, lty = '1111') +
   #geom_errorbar(data = dc, aes(ymin = er.lwr.pred, ymax = er.upr.pred), width = 0, alpha = 0.3) +
   geom_text(data = lbs, aes(label = txt), nudge_x = 0.03, hjust = 0, size = 2.2) +
   facet_wrap(~ man.source.nm) +
   labs(x = 'Normalized predictor variable value', y = 'Pred. 168 h emis. (frac. TAN)') +
   ylim(0, 0.55) +
   xlim(-1.1, 1.2) +
   theme_bw() +
   theme(legend.position = 'null')
ggsave2x('../plots/effect_size', height = 2.5, width = 5)
