# Plot counts for table in paper

d3counts <- dcast(pdat3, country ~ app.mthd.nm, fun.aggregate = length)
d3counts$tot <- rowSums(d3counts[, -1])
d3counts <- rbind(d3counts, c(country = 'all', colSums(d3counts[, -1])))

