# Download latest ALFAM2 data from a specific release or commit and save copy

rm(list = ls())

# Set release tag for download
#ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/'
#rtag <- 'v2.33'

## Alternative below to get particular commit (if not yet in release)
ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/fb072bacfb467da426c3228df211e3e2d73f2393/'
rtag <- ''

source('packages.R')
source('load.R')
source('export.R')
