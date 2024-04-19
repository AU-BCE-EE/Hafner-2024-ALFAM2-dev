# Download latest ALFAM2 data from a specific release or commit and save copy

rm(list = ls())

## Set release tag for download
#ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/'
#rtag <- 'v2.45'

# Alternative below to get particular commit (if not yet in release)
ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/df16789bb823a27fcf857126d36c207e5c49e8b4/'
rtag <- ''

source('packages.R')
source('load.R')
source('export.R')
