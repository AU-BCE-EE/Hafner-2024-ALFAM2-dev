# AU bLS measurements
x <- dpreds[institute == 'AU' & meas.tech == 'bLS' & dataset == 1, ]

ggplot(x, aes(cta, er, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/AU1.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/AU3.png', height = 8.5, width = 11)


x <- dpreds[country == 'NL' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars) +
  theme_bw()
ggsave('../plots/NL1.png', height = 8.5, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(app.mthd ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/NL2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/NL3.png', height = 8.5, width = 11)

x <- dpreds[country == 'CH' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots/CH1.png', height = 30, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/CH2.png', height = 30, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/CH3.png', height = 30, width = 11)


x <- dpreds[country == 'UK' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars) +
  theme_bw()
ggsave('../plots/UK1.png', height = 8.5, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(app.mthd ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/UK2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/UK3.png', height = 8.5, width = 11)

x <- dpreds[country == 'IT' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots/IT1.png', height = 8.5, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/IT2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/IT3.png', height = 8.5, width = 11)

x <- dpreds[country == 'DE' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(iexper ~ pars) +
  theme_bw()
ggsave('../plots/DE1.png', height = 8.5, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(iexper ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/DE2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(iexper ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/DE3.png', height = 8.5, width = 11)

x <- dpreds[country == 'FR' & dataset == 1, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line(alpha = 0.5) +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots/FR1.png', height = 15, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(iexper ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/FR2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line(alpha = 0.5) +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(iexper ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/FR3.png', height = 8.5, width = 11)

