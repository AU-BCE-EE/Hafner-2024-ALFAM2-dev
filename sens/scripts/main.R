# Runs sensitivity simulations and plots results

rm(list = ls())

pn <- 'f8'

source('functions.R')
source('packages.R')
source('settings.R')
source('load_pars.R')
#pars03['air.temp.r3'] <- 0.009
source('inputs.R')
knit('run_ALFAM2.Rmd', output = '../logs/run_ALFAM2.md')
source('process.R')
source('plot.R')
source('plot_sep.R')
source('plot_pres.R')
source('plot_app_mthd.R')

print(pars03)
