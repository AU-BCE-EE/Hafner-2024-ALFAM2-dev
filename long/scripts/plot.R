
dat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                             labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot injection', 'Closed slot injection'))]


ggplot(dat, aes(e.final, demis, colour = factor(inst))) +
  geom_smooth(aes(colour = 'a'), method = lm, formula = y ~ x - 1, se = FALSE, colour = 'gray45') +
  geom_smooth(method = lm, se = FALSE, alpha = 0.6) +
  geom_point(alpha = 0.6) +
  coord_cartesian(ylim = c(0, 10)) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = expression('Total emission'~(kg~N~ha^'-1')), y = expression('Late emission'~(kg~N~ha^'-1')), colour = 'Institution key')
ggsave2x('../plots/late_emis', height = 3, width = 5)

mean(dat$rdemis / dat$e.final)

# Relative
ggplot(dat, aes(e.final, rdemis, colour = factor(inst))) +
  geom_abline(intercept = 0, slope = 0.00129, colour = 'gray45', linewidth = 0.6) +
  geom_smooth(method = lm, se = FALSE, alpha = 0.6, linewidth = 0.5) +
  geom_point(alpha = 0.4, size = 1) +
  coord_cartesian(ylim = c(0, 0.2)) +
  facet_wrap(~ app.mthd.nm) +
  theme_bw() +
  theme(legend.position = 'none') +
  labs(x = expression('Total emission'~(kg~N~ha^'-1')), y = expression('Late ave. flux'~(kg~N~ha^'-1'~h^'-1')), colour = 'Institution key')
ggsave2x('../plots/rel_late_emis', height = 3, width = 5)

