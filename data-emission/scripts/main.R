# Download latest ALFAM2 data from a specific release or commit and save copy

rm(list = ls())

# Set release tag for download
ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/'
rtag <- 'v2.45'

## Alternative below to get particular commit (if not yet in release)
#ghpath <- 'https://github.com/sashahafner/ALFAM2-data/raw/adb3b8c6a745dc91062cf0f0020d63492b604b27/'
#rtag <- ''

source('packages.R')
source('load.R')
source('export.R')
