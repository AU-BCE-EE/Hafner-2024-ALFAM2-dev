# Summarize fit

dpreds <- rbindf(dpreds1, dpreds2)

# Residuals
dpreds[, `:=` (resid.j = j.pred - j, resid.er = er.pred - er, inst = factor(inst))]

derr <- copy(dpreds)
derr <- derr[!is.na(resid.er), ]

derr[, ct.168 := cta[which.min(abs(cta - 168))], by = pmid]
derr[, ct.24 := cta[which.min(abs(cta - 24))], by = pmid]

# Fit stats
dp168 <- derr[cta == ct.168, ]
dp24 <- derr[cta == ct.24, ]

length(unique(idat1$pmid))
length(unique(dpreds1$pmid))

fit.168 <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     nu = length(unique(pmid)),
                     n = length(er)), by = .(pars, dataset)]

fit.24 <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                   me = me(m = er, p = er.pred),
                   mae = mae(m = er, p = er.pred),
                   mbe = mbe(m = er, p = er.pred),
                   n = length(er)), by = .(pars, dataset)]

fit.168.am <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd)]

fit.168.ami <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd, incorp)]

fit.24.am <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                      me = me(m = er, p = er.pred),
                      mae = mae(m = er, p = er.pred),
                      mbe = mbe(m = er, p = er.pred),
                      n = length(er)), by = .(pars, dataset, app.mthd)]

# For par set 3 only
fit.168.ps3.am <- dp168[pars == 'p1', .(rmse = rmse(m = er, p = er.pred),
                        me = me(m = er, p = er.pred),
                        mae = mae(m = er, p = er.pred),
                        mbe = mbe(m = er, p = er.pred),
                        n = length(er)), by = .(pars, dataset, app.mthd)]

# 'i' seems to be for incorporation
fit.168.i <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                       me = me(m = er, p = er.pred),
                       mae = mae(m = er, p = er.pred),
                       mbe = mbe(m = er, p = er.pred),
                       n = length(er)), by = .(pars, dataset, incorp)]

fit.24.i <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     n = length(er)), by = .(pars, dataset, incorp)]

# By digestation status
fit.168.d <- dp168[, .(rmse = rmse(m = er, p = er.pred),
                       me = me(m = er, p = er.pred),
                       mae = mae(m = er, p = er.pred),
                       mbe = mbe(m = er, p = er.pred),
                       n = length(er)), by = .(pars, dataset, digested)]

fit.24.d <- dp24[, .(rmse = rmse(m = er, p = er.pred),
                     me = me(m = er, p = er.pred),
                     mae = mae(m = er, p = er.pred),
                     mbe = mbe(m = er, p = er.pred),
                     n = length(er)), by = .(pars, dataset, digested)]

