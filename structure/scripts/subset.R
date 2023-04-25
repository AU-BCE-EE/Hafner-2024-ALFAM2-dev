# Subsets

pdat[, iexper := paste(inst, exper)]

# Merge
idat <- merge(pdat, idat, by = c('pid', 'pmid'))

# os vs. bc or bsth ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Find experiments with both os and bsth or bc
os.summ <- pdat[, .(n.os = sum(app.mthd == 'os'), n.bc = sum(app.mthd == 'bc'), n.bsth = sum(app.mthd == 'bsth')), by = .(country, institute, iexper)]
os.summ <- os.summ[n.os > 0 & n.bc > 0 | n.bsth > 0, ]

ii <- os.summ$iexper

ospdat <- pdat[iexper %in% ii, ]

# Cast to wide
dl <- melt(ospdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'pmid'),
           measure.vars = patterns('e\\.rel\\.'))

dw <- dcast(dl, inst + iexper + exper + variable ~ app.mthd, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := sub('e\\.rel\\.', '', variable)]

dw[, rred := 1 - os / bc]
dw[, descrip := 'os v bc']
dw1 <- dw[!is.na(rred), ]

dw[, rred := 1 - os / bsth]
dw[, descrip := 'os v bsth']
dw2 <- dw[!is.na(rred), ]


# Acidification ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
acid.summ <- pdat[, .(n.acid = sum(acid), n.ref = sum(!acid)), by = .(country, institute, iexper)]
acid.summ <- acid.summ[n.acid > 0 & n.ref > 0, ]

ii <- acid.summ$iexper

acidpdat <- pdat[iexper %in% ii, ]
acidpdat[, acid.cond := ifelse(acid, 'acid', 'ref')]


# Cast to wide
dl <- melt(acidpdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'acid', 'acid.cond', 'pmid', 'ct.max'),
           measure.vars = patterns('e\\.rel\\.'))

dl[, ct.max := mean(ct.max), by = iexper]

dw <- dcast(dl, inst + iexper + exper + variable + app.mthd + ct.max ~ acid.cond, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := sub('e\\.rel\\.', '', variable)]
dw[, `:=` (rred = 1 - acid / ref)]
dw[, descrip := 'acid']
dw3 <- dw[!is.na(rred), ]

