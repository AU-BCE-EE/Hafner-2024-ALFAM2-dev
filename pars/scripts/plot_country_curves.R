# Plot emission curves for specific countries

# All par sets
whichpars <- unique(dpreds[, pars])

# Or some
whichpars <- c('f6', 'f7', 'f8', 'ps1', 'ps2')

# AU bLS measurements
x <- dpreds[institute == 'AU' & meas.tech == 'bLS' & dataset == 1 & pars %in% whichpars, ]

ggplot(x, aes(cta, er, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/AU_emis.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/AU_flux.png', height = 8.5, width = 11)


x <- dpreds[country == 'NL' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars) +
  theme_bw()
ggsave('../plots-country/NL_emis.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/NL_flux.png', height = 8.5, width = 11)

x <- dpreds[country == 'CH' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots-country/CH_emis.png', height = 30, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/CH_flux.png', height = 30, width = 11)


x <- dpreds[country == 'UK' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars) +
  xlim(0, 200) +
  theme_bw()
ggsave('../plots-country/UK_emis.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(app.mthd ~ pars, scale = 'free') +
  xlim(0, 200) +
  theme_bw()
ggsave('../plots-country/UK_flux.png', height = 8.5, width = 11)

x <- dpreds[country == 'IT' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots-country/IT_emis.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/IT_flux.png', height = 8.5, width = 11)

x <- dpreds[country == 'DE' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line() +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots-country/DE_emis.png', height = 8.5, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/DE_flux.png', height = 8.5, width = 11)

x <- dpreds[country == 'FR' & dataset == 1 & pars %in% whichpars, ]
ggplot(x, aes(cta, er, colour = app.mthd, group = pmid)) +
  geom_line(alpha = 0.5) +
  geom_line(aes(cta, er.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars) +
  theme_bw()
ggsave('../plots-country/FR_emis.png', height = 15, width = 11)

ggplot(x, aes(cta, j, colour = app.mthd)) +
  geom_line(alpha = 0.5) +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('../plots-country/FR_flux.png', height = 8.5, width = 11)

