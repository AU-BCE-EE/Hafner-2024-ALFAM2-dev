# Measurement subsets

# Merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

pdat[, iexper := paste(inst, exper)]
idat[, iexper := paste(inst, exper)]

# Main subset
# No acidification, no incorporation
# Manure pH not required
pdat1 <- pdat[!is.na(e.24) &
              !is.na(app.mthd) &
              !is.na(man.dm) &
              !is.na(man.source) & 
              !is.na(air.temp.24) & 
              !is.na(wind.2m.24) & 
              !is.na(till) & 
              !is.na(incorp) & 
              !is.na(crop) & 
              !acid &
              incorp == 'none' &
              e.24 > 0 & 
              e.rel.24 < 1.0 &
              e.rel.final < 1.05 &
              e.rel.final > - 0.05 &
              man.source != 'conc' &
              man.dm <= 15 &
              app.mthd != 'pi' &
              app.mthd != 'bss' &
              meas.tech2 %in% c('micro met') &
              !inst %in% c(102, 107, 108) & # Exclude AUN, old Swiss (IUL/FAT), and JTI
              pmid != 1526 &                # See rows 1703 and 1728 and others in MU data. Check with Marco
              !grepl('Exclude data from analysis', notes.plot) , ]

# These pmid will be retained
pmid.keep <- pdat1[, pmid]

idat1 <- idat[pmid %in% pmid.keep, ]
idat1[, dataset := 1]

# Same as 1 but include incorporation
pdat2 <- pdat[!is.na(e.24) &
              !is.na(app.mthd) &
              !is.na(man.dm) &
              !is.na(man.source) & 
              !is.na(air.temp.24) & 
              !is.na(wind.2m.24) & 
              !is.na(till) & 
              !is.na(incorp) & 
              !is.na(crop) & 
              !acid &
              e.24 > 0 & 
              e.rel.24 < 1.0 &
              e.rel.final < 1.05 &
              e.rel.final > - 0.05 &
              man.source != 'conc' &
              man.dm <= 15 &
              app.mthd != 'pi' &
              app.mthd != 'bss' &
              meas.tech2 %in% c('micro met') &
              !inst %in% c(102, 107, 108) & # Exclude AUN, old Swiss (IUL/FAT), and JTI
              pmid != 1526 &                # See rows 1703 and 1728 and others in MU data. Check with Marco
              !grepl('Exclude data from analysis', notes.plot) , ]

# These pmid will be retained
pmid.keep <- pdat2[, pmid]

idat2 <- idat[pmid %in% pmid.keep, ]
idat2[, dataset := 2]
