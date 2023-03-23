# Run ALFAM2 model


pred1 <- data.table(alfam2(dat.ref, app.name = 'TAN.app', time.name = 'ct'))
pred2 <- data.table(alfam2(dat.rain, app.name = 'TAN.app', time.name = 'ct'))
pred3 <- data.table(alfam2(dat.ref, pars = pars03, app.name = 'TAN.app', time.name = 'ct'))
pred4 <- data.table(alfam2(dat.rain, pars = pars03, app.name = 'TAN.app', time.name = 'ct'))
pred5 <- data.table(alfam2(dat.rain, pars = pars025, app.name = 'TAN.app', time.name = 'ct'))

pred1[, `:=` (sim = 'A', rain = 'No rain', pars = '2')]
pred2[, `:=` (sim = 'B', rain = 'Rain', pars = '2')]
pred3[, `:=` (sim = 'C', rain = 'No rain', pars = '3')]
pred4[, `:=` (sim = 'D', rain = 'Rain', pars = '3')]
pred5[, `:=` (sim = 'E', rain = 'No rain', pars = '2 + r5')]

preds <- rbind(pred1, pred2, pred3, pred4, pred5)
