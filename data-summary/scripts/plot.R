
# Without na.translate = FALSE I get an NA entry in legend although there are no NA values for treat.nm
ggplot(pdat, aes(app.mthd.nm, e.rel.final, colour = inst, shape = treat.nm)) +
  geom_jitter(height = 0) +
  stat_summary(aes(app.mthd.nm, e.rel.final, group = app.mthd.nm), colour = 'gray45', lwd = 1, geom = 'tile', fun = function(x) mean(x, na.rm = TRUE)) +
  scale_shape_discrete(na.translate = FALSE) +
  theme_bw() +
  labs(x = 'Application method', y = 'Total emission (frac. applied TAN)', shape = 'Slurry treatment', colour = 'Institution') +
  scale_x_discrete(guide = guide_axis(angle = 90)) +
  ylim(0, 1.5) +
  facet_grid(meas.tech.nm ~ sub.period.nm)
ggsave('../plots/emis_summ.png', height = 7, width = 6.5)

ggplot(pdat, aes(air.temp.24, wind.2m.24, colour = sub.period.nm, shape = sub.period.nm)) +
  geom_point(alpha = 0.5) +
  theme_bw() +
  labs(x = expression('Air temperature'~(degree*C)), y = expression('Wind speed'~(m~s^'-1')), 
       colour = '', shape =  '') +
  facet_grid(meas.tech.nm ~ app.mthd.simp.nm)
ggsave('../plots/weather.png', height = 5, width = 6.5)


ggplot(pdat, aes(air.temp.24, e.rel.24, colour = app.mthd.nm, shape = app.mthd.nm)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = lm, se = FALSE, show.legend = FALSE) +
  theme_bw() +
  ylim(0, 1) +
  facet_grid(meas.tech.nm ~ sub.period.nm)
ggsave('../plots/emis_temp.png', height = 5, width = 6.5)
