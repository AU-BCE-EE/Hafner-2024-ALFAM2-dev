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
source('cal_sel.R')
source('cal_drop.R')
source('ps3.R')

# Generate all predictions
source('preds.R')
source('fit_summ.R')
source('pars.R')
source('export.R')

# Cross-validation
source('crossval.R')
source('export_cv.R')
source('preds_cv.R')
source('boot.R')
source('export_boot.R')

source('labels.R')
#source('save_image.R')

source('plot_pars.R')
source('plot_wthr_resids.R')
source('plot_country_curves.R')
source('plot_scatter_flux.R')
source('plot_scatter_eval.R')
#source('plot_boot.R')
#source('plot_resids.R')
#source('plot_.R')
dev.off()

x <- subset(dpreds1, pmid %in% 1937:1938)
x <- subset(idat1, pmid %in% 1937:1938)
x <- x[!duplicated(x[, pmid]), ]
x$cta <- 0
x$app.mthd.os
x$tan.app
x$man.dm <- 20
x$tan.app <- 100
x$man.dm.app.mthd.inj
x$man.source.pig
pp
x$app.mthd.cs
x$app.rate
x$man.ph
x[1, app.mthd.os := 0]
cmns
x <- data.frame(app.mthd.os = c(1, 0), man.dm = 6, app.rate = 30, tan.app = 100, cta = 0, pmid = 1:2)
alfam2(x, pars = pp, app.name = 'tan.app', time.name = 'cta', group = 'pmid', cmns = cmns)

