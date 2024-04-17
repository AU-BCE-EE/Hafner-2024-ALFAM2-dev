# Runs sensitivity simulations, puts results in handy tables

rm(list = ls())

source('functions.R')
source('packages.R')
source('load_pars03.R')
source('load.R')
source('inputs.R')
source('pre_process.R')
knit('run_ALFAM2.Rmd', output = '../logs/run_ALFAM2.md')
source('run_boot.R')
source('merge.R')
source('export.R')
source('plot.R')
