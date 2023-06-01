# Predictor ranges for paper etc.

d3l <- data.table::melt(pdat3, id.vars = c('pmid', 'app.mthd'), 
                        measure.vars = c('man.dm', 'man.ph', 'man.tan', 'app.rate', 
                                         'tan.app', 'wind.2m.24', 'air.temp.24', 'rain.1')) 

pvsumm <- d3l[!is.na(value), .(n = length(value), min = min(value), max = max(value), 
                               mean = mean(value), q10 = quantile(value, 0.1), 
                               q90 = quantile(value, 0.9)), by = .(variable, app.mthd)]

pvsumm <- rounddf(pvsumm, 1)
# Export
fwrite(pvsumm, '../output/d3_var_summ.csv')

