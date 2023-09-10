# Apply bootstrap parameters through ALFAM2 model to get uncertainty in predictions

bpdat <- data.table()

i <- '3-001'
for (i in unique(parsbl[, parset])) {

  cat(i, ' ')
  d <- parsbl[parset == i, ]
  pars <- d[, value]
  names(pars) <- d[, parameter]

  preds <- data.table(ALFAM2mod(idat1, app.name = 'tan.app', time.name = 'cta', group = 'pmid', pars = pars, flatout = TRUE))

  # Keep pmid and cta for merge
  names(preds)[-1:-2] <- paste0(names(preds)[-1:-2], '.pred')
  preds[, parset := i]
  bpdat <- rbind(bpdat, preds)

}

# Hmm, I guess I don't need this
......


bpdat <- merge(idat3, bpdat, by = c('pmid', 'cta'))

# NTS: this cbind() call causes slow evaluation and ultimately a crash
#  bpdat <- rbind(bpdat, cbind(idat3, preds))
# NTS: so idat3 details are merged in later


# Get quantiles for *final* emission only
bpqdat <- bpdat[ct == ct.max & !is.na(er.pred), .(n = length(er.pred), er10 = quantile(er.pred, 0.1), 
                                                  er90 = quantile(er.pred, 0.9), ermed = median(er.pred)), 
             by = .(pmid, cta, app.mthd, man.source, inst)]

bpqdat[, `:=` (errange = er90 - er10, rerrange = (er90 - er10) / ermed)]

bpqdat <- merge(pdat, bpqdat, by = 'pmid', suffixes = c('', '.qp'))

# Remove bpdat (1.6 million rows) to try to avoid crashes
rm(bpdat)
