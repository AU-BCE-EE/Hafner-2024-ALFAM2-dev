# Predictor variable ranges for paper etc.

d1l <- melt(pdat1, id.vars = c('pmid', 'app.mthd'), 
            measure.vars = c('man.dm', 'man.ph', 'man.tan', 'app.rate', 'tan.app', 'wind.2m.24', 'air.temp.24', 'rain.1')) 

# Get mean
pvsumm <- d1l[!is.na(value), .(n = length(value), min = min(value), max = max(value), 
                               mean = mean(value), q10 = quantile(value, 0.1), 
                               q90 = quantile(value, 0.9), 
                               b3 = sort(value)[4], a3 = sort(value)[length(value) - 4]), by = .(variable, app.mthd)]

# pv for predictor variable
pvsumm <- rounddf(pvsumm, 1)

# Export
fwrite(pvsumm, '../output/d1_var_summ.csv')

# Overall
pvsumm2 <- d1l[!is.na(value), .(n = length(value), min = min(value), max = max(value), 
                               mean = mean(value), q10 = quantile(value, 0.1), 
                               q90 = quantile(value, 0.9), 
                               b3 = sort(value)[4], a3 = sort(value)[length(value) - 4]), by = .(variable)]

# pv for predictor variable
pvsumm2 <- rounddf(pvsumm2, 1)

# Export
fwrite(pvsumm2, '../output/d1_var_summ2.csv')



