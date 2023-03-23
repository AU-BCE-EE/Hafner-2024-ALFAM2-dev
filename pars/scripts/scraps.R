
ggplot(dd, aes(wind.2m, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  theme_bw()

ggplot(dd, aes(air.temp, resid.j, colour = inst, group = pmid)) +
  geom_line(alpha = 0.1) +
  geom_point(alpha = 0.4) +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = interaction(inst, app.mthd))) +
  theme_bw() +
  coord_cartesian(ylim = c(-0.5, 0.5))


ggplot(ddf, aes(air.temp, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()

ggplot(ddf, aes(wind.2m, resid.er, colour = inst, group = pmid)) +
  geom_line(alpha = 0.2) +
  geom_point() +
  facet_wrap(~ app.mthd, scale = 'free') +
  geom_smooth(method = MASS::rlm, se = FALSE, aes(group = app.mthd)) +
  theme_bw()


