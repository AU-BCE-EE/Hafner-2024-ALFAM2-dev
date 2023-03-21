# Evaluation plots

# # Set cs to NA
# Does not work, not cool data.table!
# cc <- grepl('\\.pred', names(dpreds))
# dpreds[app.mthd == 'cs' & pars == 'ps1', ..cc]
# dpreds[app.mthd == 'cs' & pars == 'ps1', ..cc := NA]
# dpreds[app.mthd == 'cs' & pars == 'ps1', ..cc] <- NA
dpreds <- dpreds[app.mthd != 'cs' | pars != 'ps1', ]

# AU bLS measurements
x <- dpreds[institute == 'AU' & meas.tech == 'bLS', ]

ggplot(x, aes(cta, er, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/AU1.png', height = 8.5, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/AU2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/AU3.png', height = 8.5, width = 11)

ggplot(x, aes(cta, f.pred, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, s.pred), lty = '11') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/AU4.png', height = 8.5, width = 11)

ggplot(x, aes(cta, wind.2m, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, air.temp), lty = '11') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots/AU5.png', height = 8.5, width = 11)


x <- dpreds[country == 'NL', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
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
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/NL3.png', height = 8.5, width = 11)

x <- dpreds[country == 'CH', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
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
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/CH3.png', height = 30, width = 11)

x <- dpreds[country == 'UK', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
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
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/UK3.png', height = 8.5, width = 11)

x <- dpreds[country == 'IT', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
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
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/IT3.png', height = 30, width = 11)

x <- dpreds[country == 'DE', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
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
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(iexper ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/DE3.png', height = 30, width = 11)

x <- dpreds[country == 'FR', ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots/FR1.png', height = 20, width = 11)

ggplot(x, aes(er, er.pred, colour = app.mthd, group = pmid)) +
  geom_line() +
  facet_grid(iexper ~ pars) +
  geom_abline(aes(intercept = 0, slope = 1)) +
  theme_bw()
ggsave('../plots/FR2.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), lty = '11') +
  facet_grid(iexper ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots/FR3.png', height = 30, width = 11)

