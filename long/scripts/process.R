#

dat <- pdat[pmid %in% ps3pmid & ct.max > 120, ]
dat[, `:=` (dcta = ct.max - 96, demis = e.final - e.96, rdemis = (e.final - e.96) / (ct.max - 96)), by = pmid]

