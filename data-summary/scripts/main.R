# Plot data to show old/new

rm(list = ls())

source('packages.R')
source('load.R')
source('labels.R')
render('summary.Rmd', output_dir = '../summary')
source('plot.R')
