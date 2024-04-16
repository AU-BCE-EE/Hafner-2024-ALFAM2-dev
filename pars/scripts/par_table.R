# Create table for paper

parstab <- parsl[pars == 'ps3', ]
# Change name
bootsumm[parameter == 'app.rate.ni.f0', parameter := 'app.rate.f0'] 
parstab <- merge(parstab, bootsumm, by = 'parameter', all = TRUE)

parstab[, l90 := round(l90, 3)]
parstab[, u90 := round(u90, 3)]

# Columns used in table
parstab[, valcol := round(value, 3)]
parstab[, secol := round(se, 3)] 
parstab[, cicol := paste0(l90, ', ', u90)] 

# Sort
parstab[, parameter := factor(parameter, 
                              levels = c('int.f0',
                                         'app.mthd.os.f0',
                                         'app.mthd.cs.f0',
                                         'app.rate.f0',
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
                                         'app.mthd.bc.r3',
                                         'app.mthd.cs.r3',
                                         'incorp.shallow.r3',
                                         'incorp.deep.r3',
                                         'man.ph.r3',
                                         'incorp.shallow.f4',
                                         'incorp.deep.f4',
                                         'int.r5',
                                         'rain.rate.r5'))]


parstab <- parstab[order(parameter), ]

fwrite(parstab, '../output/pars_table.csv')
