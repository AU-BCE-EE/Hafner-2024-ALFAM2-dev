
# Settings to speed things up
# For intermediate par sets
maxit1 <-   400
maxit2 <-  5000
maxit3 <- 30000

# Default pH for idat2 application
man.ph.default <- 7.0

# Select columns to reduce data frame size for par est data
parestcols <- c('inst', 'institute', 'country', 'pmid', 'cta',
                'app.rate.ni',
                'app.mthd', 
                'app.mthd.cs', 'app.mthd.bc', 'app.mthd.os',
                'air.temp', 'wind.sqrt', 'wind.2m',
                'app.mthd.ts',
                'man.dm', 'man.source.pig', 'man.ph',
                'rain.rate',
                'incorp.shallow', 'incorp.deep',
                '__f4', '__group', '__orig.order', '__add.row',
                'weight.last', 'weight.lastc', 'weight.1c', 'weight.1a',
                'tan.app', 'er', 'j')
