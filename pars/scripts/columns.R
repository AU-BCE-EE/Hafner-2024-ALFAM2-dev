# Finally, select only the necessary columns to reduce data table size, mainly for parallel stuff

idat1 <- idat1[, ..parestcols]
idat2 <- idat2[, ..parestcols]

