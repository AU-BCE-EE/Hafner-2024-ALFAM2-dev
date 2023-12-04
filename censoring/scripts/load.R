# Load ALFAM2 data

pdat <- fread('../../data-emission/data/ALFAM2_plot.csv')
idat <- fread('../../data-emission/data/ALFAM2_interval.csv')

# Couple minor changes
pdat[, app.mthd := app.method]
pdat[, inst := factor(inst)]
