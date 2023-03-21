# Measurement subsets

pdat[, iexper := paste(inst, exper)]

# Merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# Find experiments with both os and bsth or bc
os.summ <- pdat[, .(n.os = sum(app.mthd == 'os'), n.bc = sum(app.mthd == 'bc'), n.bsth = sum(app.mthd == 'bsth')), by = .(country, institute, iexper)]
os.summ <- os.summ[n.os > 0 & n.bc > 0 | n.bsth > 0, ]

ii <- os.summ$iexper

ospdat <- pdat[iexper %in% ii, ]

# Cast to wide
dl <- melt(ospdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'pmid'),
           measure.vars = patterns('e\\.rel\\.'))

dw <- dcast(dl, inst + iexper + exper + variable ~ app.mthd, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := as.numeric(sub('e\\.rel\\.', '', variable))]

dw[, rred := 1 - os / bc]
dw[, descrip := 'os v bc']
dw1 <- dw[!is.na(rred), ]

dw[, rred := 1 - os / bsth]
dw[, descrip := 'os v bsth']
dw2 <- dw[!is.na(rred), ]

acid.summ <- pdat[, .(n.acid = sum(acid), n.ref = sum(!acid)), by = .(country, institute, iexper)]
acid.summ <- acid.summ[n.acid > 0 & n.ref > 0, ]

ii <- acid.summ$iexper

acidpdat <- pdat[iexper %in% ii, ]
acidpdat[, acid.cond := ifelse(acid, 'acid', 'ref')]


# Cast to wide
dl <- melt(acidpdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'acid', 'acid.cond', 'pmid'),
           measure.vars = patterns('e\\.rel\\.'))

dw <- dcast(dl, inst + iexper + exper + variable + app.mthd ~ acid.cond, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := as.numeric(sub('e\\.rel\\.', '', variable))]
dw[, `:=` (rred = 1 - acid / ref)]
dw[, descrip := 'acid']
dw3 <- dw[!is.na(rred), ]

dcomp <- rbindf(dw1, dw2, dw3)

ggplot(dcomp, aes(ct, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  coord_cartesian(xlim = c(0, 100), ylim = c(-0.1, 1.1)) +
  facet_wrap(~ descrip)

ggplot(dw1, aes(ct, rred.bsth, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() +
  coord_cartesian(xlim = c(0, 100), ylim = c(-0.1, 1.1)) +
  geom_smooth(method = lm, se = FALSE, aes(group = inst))

ggplot(dw2, aes(ct, rred.bc, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() 

# Repeat for acidification
# Find experiments with acidification and reference
acid.summ <- pdat[, .(n.acid = sum(acid), n.ref = sum(!acid)), by = .(country, institute, iexper)]
acid.summ <- acid.summ[n.acid > 0 & n.ref > 0, ]

ii <- acid.summ$iexper

acidpdat <- pdat[iexper %in% ii, ]
acidpdat[, acid.cond := ifelse(acid, 'acid', 'ref')]


# Cast to wide
dl <- melt(acidpdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'acid', 'acid.cond', 'pmid'),
           measure.vars = patterns('e\\.rel\\.'))

dw <- dcast(dl, inst + iexper + exper + variable + app.mthd ~ acid.cond, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := as.numeric(sub('e\\.rel\\.', '', variable))]
dw[, `:=` (rred = 1 - acid / ref)]
dw <- dw[!is.na(rred), ]

ggplot(dw, aes(ct, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, aes(group = inst))



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

# Wind speed focused subset
idat1[meas.tech2 == 'micro met', .(wind.2m.range = diff(range(wind.2m))), by = .(country, iexper, app.mthd, meas.tech2)]
