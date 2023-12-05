# Load ALFAM2 data

pdat <- fread('../../data-emission/data/ALFAM2_plot.csv')
idat <- fread('../../data-emission/data/ALFAM2_interval.csv')

# Couple minor changes
pdat[, app.mthd := app.method]
pdat[, inst := factor(inst)]

# Get pmid from par est subset 1
ps3pmid <- scan('../../pars/output/pmid_sub1.txt')
