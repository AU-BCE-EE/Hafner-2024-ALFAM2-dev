
fit.168 <- rounddf(fit.168, 4, func = signif)
fit.168.am <- rounddf(fit.168.am, 4, func = signif)
fit.168.ami <- rounddf(fit.168.ami, 4, func = signif)

fwrite(fit.168, '../output/fit_168.csv')
fwrite(fit.168.am, '../output/fit_168_app_mthd.csv')
fwrite(fit.168.ami, '../output/fit_168_app_mthd_incorp.csv')
fwrite(fit.168.d, '../output/fit_168_dig.csv')

# Pars
fwrite(d.pars, '../output/pars.csv')
