
pdat[, man.trts := paste(man.trt1, man.trt2, man.trt3)]
pdat[, digested := grepl('[Dd]igest', man.trts)]
pdat[, separated := grepl('[Ss]epar', man.trts)]
pdat[, treat.nm := factor(ifelse(acid, 'Acid', ifelse(digested, 'AD', ifelse(separated, 'Separated', 'None/other'))),
                          levels = c('Acid', 'AD', 'Separated', 'None/other'))]
pdat[is.na(treat.nm), treat.nm := 'None/other']

mms <- c(chamber = 'Other chamber', cps = 'Other chamber', wt = 'Wind tunnel', `micro met` = 'Micromet.')
pdat[, meas.tech.nm := factor(mms[meas.tech2], levels = c('Micromet.', 'Wind tunnel', 'Other chamber'))]

pdat <- pdat[!is.na(app.mthd) & app.mthd != 'pi' & app.mthd != 'bss', ]
pdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'),
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

pdat[, app.mthd.simp := as.character(app.mthd)]
pdat[app.mthd.simp %in% c('bsth', 'ts'), app.mthd.simp := 'bs'] 
pdat[app.mthd.simp %in% c('os', 'cs'), app.mthd.simp := 'i'] 
pdat[, app.mthd.simp.nm := factor(app.mthd.simp, levels = c('bc', 'bs', 'i'), labels = c('Broadcast', 'Band application', 'Injection'))]

pdat[, period := as.character(sub.period)]
pdat[corr.period == 3, period := '2/3']
pdat[, period.nm := factor(paste('Period', period))]
pdat[, sub.period.nm := factor(paste('Period', sub.period))]


