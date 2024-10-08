# Plot counts for table

# *dat1
pdat1[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))] 
idat1[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))] 

# Group INRA(E)
pdat1[, institute := gsub('INRA$', 'INRAE', institute)]
idat1[, institute := gsub('INRA$', 'INRAE', institute)]
setorder(pdat1, app.mthd)
setorder(idat1, app.mthd)
d1counts <- dcast(idat1, institute + inst + country ~ app.mthd, value.var = 'pmid', fun.aggregate = function(x) length(unique(x)))
d1counts$total <- rowSums(d1counts[, -1:-3])
d1counts <- rbind(d1counts, data.frame(institute = 'Total', inst = 'total', country = 'total', t(colSums(d1counts[, -1:-3]))))
d1counts <- d1counts[order(inst), ]

# Export
fwrite(d1counts, '../output/d1_counts.csv')

d1incorp <- pdat1[incorp != 'none', ]
d1icounts <- dcast(d1incorp, institute + inst + country ~ incorp, value.var = 'pmid', fun.aggregate = function(x) length(unique(x)))
d1icounts$total <- rowSums(d1icounts[, -1:-3])
d1icounts <- rbind(d1icounts, data.frame(institute = 'Total', inst = '', country = '', t(colSums(d1icounts[, -1:-3]))))

fwrite(d1icounts, '../output/d1_incorp_counts.csv')

# *dat2
pdat2[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))] 
d2counts <- dcast(idat2, institute + inst + country ~ app.mthd, value.var = 'pmid', fun.aggregate = function(x) length(unique(x)))
d2counts$total <- rowSums(d2counts[, -1:-3])
d2counts <- rbind(d2counts, data.frame(institute = 'total', inst = 'total', country = 'total', t(colSums(d2counts[, -1:-3]))))
d2counts <- d2counts[order(inst), ]

# Export
fwrite(d2counts, '../output/d2_counts.csv')
