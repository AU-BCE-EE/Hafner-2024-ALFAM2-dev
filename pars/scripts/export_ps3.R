# Get par set 3 pars only for ALFAM2 R package
parlevels <- c('int.f0',
               'app.mthd.os.f0',
               'app.mthd.cs.f0',
               'man.source.pig.f0',
               'man.dm.f0',
               'int.r1',
               'app.mthd.bc.r1',
               'app.mthd.ts.r1',
               'man.dm.r1',
               'man.ph.r1',
               'air.temp.r1',
               'wind.sqrt.r1',
               'int.r2',
               'rain.rate.r2',
               'int.r3',
               'app.mthd.cs.r3',
               'incorp.deep.r3',
               'man.ph.r3',
               'incorp.shallow.f4',
               'incorp.deep.f4',
               'int.r5',
               'rain.rate.r5')

pars03 <- parsl[pars == 'ps3' & !is.na(value), -1]
pars03[, parameter := factor(parameter, levels = parlevels)]
pars03 <- pars03[order(parameter), ]
fwrite(pars03, '../output/pars_set3.csv')

parsboot <- d.parsb[, -1]
parsboot <- parsboot[, ..parlevels]
fwrite(parsboot, '../output/pars_set3_var.csv')
