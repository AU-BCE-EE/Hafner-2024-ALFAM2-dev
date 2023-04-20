# Measurement subsets

# Add digestion to pdat
pdat[, digested := grepl('[Dd]igest', paste(man.trt1, man.trt2))]
idat[, rain.missing := FALSE]
pdat[, man.ph.missing := FALSE]

# To help with rbind() later

# Add institute x experiment
pdat[, iexper := paste(inst, exper)]

# Merge pdat and idat
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

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

# Subset 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Same as 1 but include incorporation (more plots)
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

pmid.keep <- pdat2[, pmid]
idat2 <- idat[pmid %in% pmid.keep, ]
idat2[, dataset := 2]

# Subset 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Require pH, including acidification and incorporation
pdat3 <- pdat[!is.na(e.24) &
              !is.na(app.mthd) &
              !is.na(man.ph) &
              !is.na(man.dm) &
              !is.na(man.source) & 
              !is.na(air.temp.24) & 
              !is.na(wind.2m.24) & 
              !is.na(till) & 
              !is.na(incorp) & 
              !is.na(crop) & 
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

pmid.keep <- pdat3[, pmid]
idat3 <- idat[pmid %in% pmid.keep, ]
idat3[, dataset := 3]

# Subset i ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Incorporation experiments, with missing variables filled in with averages as needed
# Will be combined with 2 and 3 
incorp.exper <- unique(pdat[incorp != 'none', c('inst', 'exper', 'iexper')])

pdati <- pdat[iexper %in% incorp.exper[, iexper] &
              !is.na(e.24) &
              !is.na(app.mthd) &
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

idati <- idat[pmid %in% pdati[, pmid], ]
idati[, dataset := 3]

# Subset 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Johanna's wind tunnel data

pdat4 <- pdat[inst == 205 &
              meas.tech2 == 'wt' &
	      !is.na(e.24) &
              !is.na(app.mthd) &
              !is.na(man.ph) &
              !is.na(man.dm) &
              !is.na(man.source) & 
              !is.na(air.temp.24) & 
              !is.na(wind.2m.24) & 
              !is.na(till) & 
              !is.na(incorp) & 
              !is.na(crop) & 
              e.24 > 0 & 
              e.rel.24 < 1.0 &
              e.rel.final < 1.05 &
              e.rel.final > - 0.05 &
              man.source != 'conc' &
              man.dm <= 15, ]

pmid.keep <- pdat4[, pmid]
idat4 <- idat[pmid %in% pmid.keep, ]
idat4[, dataset := 4]


