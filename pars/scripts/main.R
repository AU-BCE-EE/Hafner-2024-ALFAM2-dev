# Parameter estimation - par set 3

rm(list = ls())

source('packages.R')
source('functions.R')
source('settings.R')
#source('load_image.R')
source('load.R')
source('subset.R')
source('prep.R')
source('export_pmid.R')
source('counts.R')
source('ranges.R')
knit('subset_summ.Rmd', output = '../logs/subset_summary.md')
source('cal.R')
source('ps3.R')
source('cal_drop.R')

# Generate all predictions
source('preds.R')
source('fit_summ.R')
source('pars.R')
source('export.R')

# Cross-validation and bootstrap analysis
source('crossval.R')
source('preds_cv.R')
source('export_cv.R')

# Bootstrap
source('boot.R')
source('export_boot.R')

source('labels.R')
#source('save_image.R')

source('plot_pars.R')
source('plot_wthr_resids.R')
source('plot_country_curves.R')
#source('plot_scatter_flux.R')
source('plot_scatter_eval.R')
#source('plot_boot.R')
#source('plot_resids.R')
#source('plot_.R')
