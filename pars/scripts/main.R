# Parameter estimation - par set 3

rm(list = ls())

#NTS: need to get ps1 ps2 in dpreds, check dpreds <- in cal.R

source('packages.R')
source('functions.R')
#source('load_image.R')
load('../workspace/mods.RData')
source('load.R')
source('subset.R')
source('prep.R')
source('export_pmid.R')
source('counts.R')
source('ranges.R')
knit('subset_summ.Rmd', output = '../logs/subset_summary.md')
knit('run1.Rmd', output = '../logs/run1.md')
source('cal_final.R')
source('ps3.R')
source('crossval.R')

#source('cal.R')
#source('cal_incorp.R')
#source('cal_pH.R')
#source('cal_temp.R')
#source('cal_polish.R')
#source('boot.R')
#source('apply_boot.R')

source('fit_summ.R')
source('pars.R')
source('export.R')

render('tail.Rmd', output_file = '../logs/tail.pdf')

source('labels.R')
source('save_image.R')
#source('plot.R')

source('plot_pars.R')
source('plot_wthr_resids.R')
source('plot_country_curves.R')
source('plot_scatter_eval.R')
#source('plot_boot.R')
#source('plot_resids.R')
#source('plot_.R')



table(dp168$pmid, dp168$pars, dp168$dataset)
plot(air.temp.log ~ air.temp, data = idat1)

names(mods)
boxplot(idat1$j.NH3)

x <- dpreds[country == 'NL' & pars %in% c('ps1', 'ps2', 'f3', 'f4') & dataset == 1, ]
y <- subset(x, country == 'NL' & app.mthd == 'os')
unique(x$pmid)


ggplot(y, aes(cta, j, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, j.pred), colour = 'gray45') +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()
ggsave('x.png', height = 20, width = 8)

ggplot(y, aes(cta, r1.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

ggplot(y, aes(cta, f.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars, scale = 'free') +
  theme_bw()

ggplot(y, aes(cta, f0.pred, colour = app.mthd)) +
  geom_line() +
  facet_grid(pmid ~ pars) +
  theme_bw()

pp

