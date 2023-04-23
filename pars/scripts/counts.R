# Plot counts for table in paper

pdat3[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))] 
d3counts <- dcast(idat3, institute + inst + country ~ app.mthd, value.var = 'pmid', fun.aggregate = function(x) length(unique(x)))
d3counts$total <- rowSums(d3counts[, -1:-3])
d3counts <- rbind(d3counts, data.frame(institute = 'total', inst = 'total', country = 'total', t(colSums(d3counts[, -1:-3]))))
d3counts <- d3counts[order(inst), ]

fwrite(d3counts, '../output/d3_counts.csv')
