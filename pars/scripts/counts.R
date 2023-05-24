# Plot counts for table in paper

# Plot counts of calibration data
pdat3[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))] 
d3counts <- dcast(idat3, institute + inst + country ~ app.mthd, value.var = 'pmid', fun.aggregate = function(x) length(unique(x)))
d3counts$total <- rowSums(d3counts[, -1:-3])
d3counts <- rbind(d3counts, data.frame(institute = 'total', inst = 'total', country = 'total', t(colSums(d3counts[, -1:-3]))))
d3counts <- d3counts[order(inst), ]

# Export
fwrite(d3counts, '../output/d3_counts.csv')

# Predictor ranges
d3l <- data.table::melt(pdat3, id.vars = c('pmid', 'app.mthd'), 
                        measure.vars = c('man.dm', 'man.ph', 'man.tan', 'app.rate', 
                                         'tan.app', 'wind.2m.24', 'air.temp.24', 'rain.1')) 

pvsumm <- d3l[!is.na(value), .(n = length(value), min = min(value), max = max(value), 
                               mean = mean(value), q10 = quantile(value, 0.1), 
                               q90 = quantile(value, 0.9)), by = .(variable, app.mthd)]

pvsumm <- rounddf(pvsumm, 1)
# Export
fwrite(pvsumm, '../output/d3_var_summ.csv')
