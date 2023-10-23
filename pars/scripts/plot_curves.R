# Base R plots of all emission curves for visual assessment of measurements or model

pdf('../plots-curves/emis_curves.pdf', height = 11, width = 8.5)
  par(mfrow = c(4, 3))
  for (i in unique(idat1[, pmid])) {
    dd <- dpreds[pmid == i & pars == 'ps3', ]  
    dd <- rbind(dd, data.table(cta = 0, er = 0, er.pred = 0), fill = TRUE)
    dd <- dd[order(cta), ]
    plot(er ~ cta, data = dd, type = 'o', col = 'blue', 
         main = paste('pmid', i, 'inst', dd[2, inst], dd[2, app.mthd.nm]), 
         xlab = 'Time after application (h)', ylab = 'Relative emission (frac. applied TAN)',
         ylim = c(0, 1))
         #ylim = c(0, max(na.omit(c(dd[, er], dd[, er.pred])))))
    lines(er.pred ~ cta, data = dd, type = 'o', col = 'red') 
  }
dev.off()
