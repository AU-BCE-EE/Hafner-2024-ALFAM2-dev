# Evaluation plots

dpreds.plot <- copy(dpreds)
dp168.plot <- copy(dp168)

# NTS: Clean up this crap
dp168.plot[, digested := grepl('[Dd]igest', paste(man.trt1, man.trt2))]

dpreds.plot[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dp168.plot[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dp168.plot[, `:=` (acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
                    digested.nm = factor(ifelse(digested, 'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
                    pig.nm = factor(ifelse(man.source.pig == 1, 'Pig', 'Cattle &\nothers'), levels = c('Cattle &\nothers', 'Pig')),
                    incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]


#dpreds.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]
#dp168.plot[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'nullA', 'nullB', 'nullC', 'a', 'b', 'c', 'd', 'i1', 'i2', 'p1', 'w1', 'w2', 'w3', 'w4'))]

dp168w <- dcast(dp168.plot, inst + institute + country + exper + pmid + uptake + man.source + man.source.pig + pig.nm + app.mthd + incorp + incorp.nm + app.mthd.nm + digested + digested.nm + acid + acid.nm + man.dm + man.ph + air.temp.24 + wind.2m.24 + er ~ pars + dataset, value.var = 'er.pred')

dp168.plot$set <- ifelse(dp168.plot$incorp != 'none', 'Incorporation', ifelse(dp168.plot$acid, 'Acidification', 'Neither'))

for (i in unique(dp168.plot$pars)) {

  ddf <- subset(dp168.plot, pars == i & dataset == 1)
  ggplot(ddf, aes(er.pred, er, colour = country, shape = set)) +
    geom_abline(intercept = 0, slope = 1, col = 'gray45') +
    geom_point(bg = 'gray45') +
    #geom_line(stat = 'smooth', method = 'lm', se = FALSE, alpha = 0.6) +
    scale_shape_manual(values = c(1, 2, 20)) +
    facet_grid(pig.nm ~ app.mthd) +
    labs(x = 'Calculated', 
         y = 'Measured',
         colour = '', shape = '') +
    theme(legend.position = 'top') +
    xlim(0, 0.9) +
    guides(colour = guide_legend(nrow = 1))
  ggsave(paste0('../plots-scatter/e168_comp_', i, '.png'), height = 4.5, width = 7)
}
