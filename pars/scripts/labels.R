# Sort out factor level names

# Parameters
parsl[, ppar := gsub('^.+([fr][0-5])$', '\\1', parameter)]
spars <- unique(parsl[, parameter])
parsl[, parameter := factor(parameter, levels = spars[order(gsub('^.+[fr]([0-5])$', '\\1', spars))])]
parsl[, parameter := gsub('\\.ni', '', parameter)]
parsl[, parameter := factor(parameter, levels = c('int.f0', 
                                                  'int.r1', 
                                                  'int.r2', 
                                                  'int.r3', 
                                                  'int.r5', 
                                                  'app.mthd.bc.r1', 
                                                  'app.mthd.ts.r1', 
                                                  'app.mthd.os.f0', 
                                                  'app.mthd.cs.f0', 
                                                  'app.rate.f0', 
                                                  'man.dm.f0', 
                                                  'man.dm.r1', 
                                                  'man.source.pig.f0',
                                                  'air.temp.r1', 
                                                  'wind.2m.r1', 
                                                  'man.ph.r1', 
                                                  'rain.rate.r2', 
                                                  'app.mthd.bc.r3', 
                                                  'app.mthd.os.r3', 
                                                  'app.mthd.cs.r3', 
                                                  'man.ph.r3', 
                                                  'incorp.shallow.f4', 
                                                  'incorp.shallow.r3', 
                                                  'incorp.deep.f4', 
                                                  'incorp.deep.r3', 
                                                  'rain.rate.r5', 
                                                  'wind.sqrt.r1', 
                                                  'man.dm.sqrt.f0', 
                                                  'air.temp.r3', 
                                                  'rain.cum.r3', 
                                                  'ts.cereal.hght.r1'))]
parsl[, pars.nm := factor(pars, levels = c('ps1', 'ps2', 'ps3'), labels = 1:3)]

# Add some descriptive variables for plots
dp168[, `:=` (acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
              digested.nm = factor(ifelse(grepl('[Dd]igest', paste(man.trt1, man.trt2)), 
                                          'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
              pig.nm = factor(ifelse(man.source.pig == 1, 'Pig', 'Cattle &\nothers'), levels = c('Cattle &\nothers', 'Pig')),
              app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection')),
              set = ifelse(incorp != 'none', 'Incorporation', ifelse(acid, 'Acidification', 'Neither')),
              incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]

dpreds[, `:=` (acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
               digested.nm = factor(ifelse(grepl('[Dd]igest', paste(man.trt1, man.trt2)), 
                                           'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
               pig.nm = factor(ifelse(man.source.pig == 1, 'Pig', 'Cattle &\nothers'), levels = c('Cattle &\nothers', 'Pig')),
               app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                                labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection')),
               set = ifelse(incorp != 'none', 'Incorporation', ifelse(acid, 'Acidification', 'Neither')),
               incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]


# Plots ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


pdat1[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

dpreds1[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                               labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

#bpqdat[, app.mthd.nm := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
#                               labels = c('Broadcast', 'Trailing\nhose', 'Trailing\nshoe', 'Open slot\ninjection', 'Closed slot\ninjection'))]

cvdat168[, `:=` (pig.nm = factor(ifelse(man.source == 'pig', 'Pig', 'Cattle & others'), levels = c('Pig', 'Cattle & others')),
                 acid.nm = factor(ifelse(acid, 'Acidified', 'Reference'), levels = c('Reference', 'Acidified')), 
                 digested.nm = factor(ifelse(digested, 'Anaerobically\ndigested', 'Raw'), levels = c('Raw', 'Anaerobically\ndigested')),
                 incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')), 
                 app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                              labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
					 'Open slot\ninjection', 'Closed slot\ninjection')))]

cvdat168[, set := ifelse(incorp != 'none', 'Incorporation', ifelse(acid, 'Acidification', ifelse(digested, 'Digestate', 'Other')))]


