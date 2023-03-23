# Measurement subsets

# Add digestion to pdat
pdat[, digested := grepl('[Dd]igest', paste(man.trt1, man.trt2))]

ggplot(pdat1, aes(man.dm, man.ph, colour = digested)) +
  geom_point()

# Merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Add institute x experiment
pdat[, iexper := paste(inst, exper)]
idat[, iexper := paste(inst, exper)]

# NTS: drop digested stuff?
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


