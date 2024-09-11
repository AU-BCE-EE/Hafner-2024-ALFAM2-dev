# Parameter estimation - par set 3

rm(list = ls())

# Can load earlier saved image to use parameter estimates made earlier
#source('load_image.R')

source('packages.R')
source('functions.R')
source('settings.R')
source('load.R')
source('subset.R')
sink('../logs/prep.txt')
  source('prep.R', echo = TRUE, max.deparse.length = 300 )
sink()
source('export_subs.R')
source('export_pmid.R')
source('counts.R')
source('ranges.R')
knit('subset_summ.Rmd', output = '../logs/subset_summ.md')
source('columns.R')
sink('../logs/par_est.txt')
  source('par_est.R', echo = TRUE, max.deparse.length = 300)
  source('par_est_refine.R', echo = TRUE, max.deparse.length = 300)
sink()

# Pick par set 3
source('ps3.R')

source('par_est_drop.R')

# Cross-validation
source('crossval.R')
source('extract_cv_pars.R')
source('calc_emis_cv.R')
source('cv_error.R')

# Bootstrap analysis for uncertainty
source('boot.R')
source('extract_boot_pars.R')
source('boot_cor.R')

# Extract and apply parameter sets
source('calc_emis.R')
source('fit_summ.R')
source('extract_pars.R')
source('export_ps3.R')

# Combined parameter table for paper
source('par_table.R')

# Save work
source('save_image.R')

# Add labels for plots
source('labels.R')
# Plots
source('plot_pars.R')
source('plot_resids.R')
source('plot_country_curves.R')
source('plot_curves.R')
source('plot_scatter_emis.R')
source('plot_scatter_emis_ps3.R')
source('plot_cv.R')
#source('plot_cv_pres.R')
source('plot_long_resids.R')
