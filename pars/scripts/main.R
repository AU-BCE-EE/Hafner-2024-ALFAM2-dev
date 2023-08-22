# Parameter estimation - par set 3

rm(list = ls())

#NTS: need to get ps1 ps2 in dpreds, check dpreds <- in cal.R

source('packages.R')
source('functions.R')
#source('load_image.R')
source('load.R')
source('subset.R')
source('prep.R')
source('export_pmid.R')
source('counts.R')
source('ranges.R')
knit('subset_summ.Rmd', output = '../logs/subset_summary.md')
knit('run1.Rmd', output = '../logs/run1.md')

source('cal_final.R')

source('cal.R')
source('cal_incorp.R')
source('cal_pH.R')
#source('cal_temp.R')
#source('cal_polish.R')
#source('boot.R')
#source('apply_boot.R')

source('fit_summ.R')
source('pars.R')
source('export.R')
source('labels.R')
source('save_image.R')
#source('plot.R')
source('plot_pars.R')
source('plot_wthr_resids.R')
source('plot_boot.R')
source('plot_resids.R')
#source('plot_.R')

boxplot(idat1$j.NH3)
