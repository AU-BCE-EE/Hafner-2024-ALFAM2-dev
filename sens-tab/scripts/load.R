
inputs <- fread('../inputs/inputs.csv', skip = 2, stringsAsFactors = TRUE)
inputs[, air.temp := as.numeric(air.temp)]
