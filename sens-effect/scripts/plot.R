
dd <- pdat[set == 'app.mthd', ]
ggplot(pdat, aes(xval.norm, er.pred, colour = set)) + 
  geom_point(data = dd) +
  geom_line() +
  facet_wrap(~ man.source)
ggsave2x('../plots/effect_size', height = 3, width = 5)
