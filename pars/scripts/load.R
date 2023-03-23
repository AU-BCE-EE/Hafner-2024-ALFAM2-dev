# Loads ALFAM2 data

pdat <- fread('../../data-emission/data/ALFAM2_plot.csv')
idat <- fread('../../data-emission/data/ALFAM2_interval.csv')

pdat[, app.mthd := app.method]
