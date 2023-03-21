# Summarize fit

derr <- dpreds

derr[, ct.168 := cta[which.min(abs(cta - 168))], by = pmid]
derr[, ct.24 := cta[which.min(abs(cta - 24))], by = pmid]

# Fit stats

dp168 <- derr[cta == ct.168, ]
dp24 <- derr[cta == ct.24, ]

fit.168 <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                 mae = mae(m = er, p = er.pred),
                 mbe = mbe(m = er, p = er.pred)), by = pars]

fit.24 <- dp24[, .(rmse = rmse(m = er, p = er.pred),
               mae = mae(m = er, p = er.pred),
               mbe = mbe(m = er, p = er.pred)), by = pars]

fit.168.am <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                    mae = mae(m = er, p = er.pred),
                    mbe = mbe(m = er, p = er.pred)), by = .(pars, app.mthd)]

fit.24.am <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                  mae = mae(m = er, p = er.pred),
                  mbe = mbe(m = er, p = er.pred)), by = .(pars, app.mthd)]

fit.168.i <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                    mae = mae(m = er, p = er.pred),
                    mbe = mbe(m = er, p = er.pred)), by = .(pars, inst, institute)]

fit.24.i <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                  mae = mae(m = er, p = er.pred),
                  mbe = mbe(m = er, p = er.pred)), by = .(pars, inst, institute)]

fit.168.i[pars %in% c('ps2', 'b'), ][order(mbe), ]

fwrite(fit.168, '../output/fit_168.csv')
fwrite(fit.168.am, '../output/fit_168_app_mthd.csv')
