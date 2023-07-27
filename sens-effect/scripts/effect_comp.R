# Some processing to compare effects of predictor variables


i <- 'air.temp'
pdat[, ref := FALSE]
i <- 'cattle/other'
j <- 'air.temp'
for (i in unique(pdat[, man.source]) {
  for (j in unique(pdat[, set])) {
  
    refval <- dat.ref[man.source == i, ..j]
    pdat[man.source == i & set == j,][which.min(abs(xval - refval)), ]
    pdat[man.source == i & set == j,][which.min(abs(xval - refval)), ref := TRUE]
    pdat[ref == TRUE, ]
  which.min(abs(
                pdat$xval - refval
  )
  )
  }
}
