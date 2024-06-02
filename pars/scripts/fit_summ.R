# Summarize model fit/performance

# Residuals, always calculated minus measured value
dpreds[, `:=` (resid.j = j.pred - j, lrresid.j = log10(j.pred / j), resid.er = er.pred - er)]

# No need to take copy with subsetting (I think, see issue #2 in love-hate-data.table repo)
derr <- dpreds[!is.na(resid.er), ]

# Get cta closest to 24 and 168 hours to use these times for model evaluation
derr[, ct.168 := cta[which.min(abs(cta - 168))], by = pmid]
derr[, ct.24 := cta[which.min(abs(cta - 24))], by = pmid]

# Fit stats
dp168 <- derr[cta == ct.168, ]
dp24 <- derr[cta == ct.24, ]

# Data table with fit statistics, by various variables
fit.168 <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     nu = length(unique(pmid)),
                     er.mn = mean(er.pred),
                     er.md = median(er.pred),
                     n = length(er)), by = .(pars, dataset)]

fit.24 <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                   me = me(m = er, p = er.pred),
                   mae = mae(m = er, p = er.pred),
                   mbe = mbe(m = er, p = er.pred),
                   er.mn = mean(er.pred),
                   er.md = median(er.pred),
                   n = length(er)), by = .(pars, dataset)]

fit.168.am <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        er.mn = mean(er.pred),
                        er.md = median(er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd)]

fit.168.ami <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        er.mn = mean(er.pred),
                        er.md = median(er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd, incorp)]

fit.24.am <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                      me = me(m = er, p = er.pred),
                      mae = mae(m = er, p = er.pred),
                      mbe = mbe(m = er, p = er.pred),
                      er.mn = mean(er.pred),
                      er.md = median(er.pred),
                      n = length(er)), by = .(pars, dataset, app.mthd)]

# For par set 3 only
fit.168.ps3.am <- dp168[pars == 'ps3', .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        er.mn = mean(er.pred),
                        er.md = median(er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd)]

# Incorporation
fit.168.i <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                       me = me(m = er, p = er.pred),
                       mae = mae(m = er, p = er.pred),
                       mbe = mbe(m = er, p = er.pred),
                       er.mn = mean(er.pred),
                       er.md = median(er.pred),
                       n = length(er)), by = .(pars, dataset, incorp)]

fit.24.i <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     er.mn = mean(er.pred),
                     er.md = median(er.pred),
                     n = length(er)), by = .(pars, dataset, incorp)]

# By digestation status
fit.168.d <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                       me = me(m = er, p = er.pred),
                       mae = mae(m = er, p = er.pred),
                       mbe = mbe(m = er, p = er.pred),
                       er.mn = mean(er.pred),
                       er.md = median(er.pred),
                       n = length(er)), by = .(pars, dataset, digested)]

fit.24.d <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     er.mn = mean(er.pred),
                     er.md = median(er.pred),
                     n = length(er)), by = .(pars, dataset, digested)]

# Export these after some rounding for easier viewing
fit.168 <- rounddf(fit.168, 4, func = signif)
fit.168.am <- rounddf(fit.168.am, 4, func = signif)
fit.168.ami <- rounddf(fit.168.ami, 4, func = signif)

fwrite(fit.168, '../output/fit_168.csv')
fwrite(fit.168.am, '../output/fit_168_app_mthd.csv')
fwrite(fit.168.ami, '../output/fit_168_app_mthd_incorp.csv')
fwrite(fit.168.d, '../output/fit_168_dig.csv')

fit.168.am.sorted <- fit.168.am[order(dataset, app.mthd, -me), ] 
fwrite(fit.168.am.sorted, '../output/fit_168_app_mthd_me_sort.csv')

# Fit summary table for paper
fit.3ps <- fit.168.am[pars %in% c('ps1', 'ps2', 'ps3') & dataset == 1]
fit.3ps[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                                labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
                                           'Open slot injection', 'Closed slot injection'))]


fit.3ps <- fit.3ps[order(app.mthd.nm, pars), .(app.mthd.nm, n, pars, rmse, mae, mbe, me)]
fit.3ps[, pars := gsub('ps', '', pars)]
fit.3ps <- rounddf(fit.3ps, digits = c(0, 0, 2, 2, 2, 3, 2))

# Export table
fwrite(fit.3ps, '../output/fit_168_table.csv')
