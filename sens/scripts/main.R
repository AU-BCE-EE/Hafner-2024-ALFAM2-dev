# Runs sensitivity simulations and plots results

rm(list = ls())

source('functions.R')
source('packages.R')
source('load_pars.R')
source('inputs.R')
knit('run_ALFAM2.Rmd', output = '../logs/run_ALFAM2.md')
source('process.R')
source('plot.R')
source('plot_sep.R')
source('plot_app_mthd.R')

head(pdat)
table(pdat$set)

# Export for Sven
ddm <- pdat[set == 'man.dm' & app.mthd == 'bsth' & man.source != 'pig', ]
plot(er.pred ~ man.dm, data = ddm)
write.csv(ddm, 'dm_effect_draft.csv', row.names = FALSE)
ddm$man.source
ddm$app.mthd
