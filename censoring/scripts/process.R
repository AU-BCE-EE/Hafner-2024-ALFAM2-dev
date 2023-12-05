# Sort out minimum values, rank

idat[is.na(cta), cta := ct]
idat <- idat[meas.tech2 == 'micro met' & cta >= 0, ]
idat[, minj := j.NH3 == min(j.NH3), by = pmid]
idat[, jrank := rank(j.NH3) / length(j.NH3), by = pmid]

# Minimum flux only
mn <- idat[minj == TRUE, ]
mn <- mn[!duplicated(mn[, .(pmid, j.NH3)]), ]

# For subset 1 pars 03 pmid only
# Note that dup removal isn't really important
mnsub1 <- mn[pmid %in% ps3pmid, ]
mnsub1 <- mnsub1[!duplicated(mnsub1[, .(pmid, j.NH3)]), ]
