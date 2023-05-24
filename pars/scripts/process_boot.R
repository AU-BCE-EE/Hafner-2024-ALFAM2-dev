# Process bootstrap par model output to get range in predictions

# Get quantiles for final emission only
bpqdat <- bpdat[ct == ct.max & !is.na(er.pred), .(n = length(er.pred), er10 = quantile(er.pred, 0.1), 
                                                  er90 = quantile(er.pred, 0.9), ermed = median(er.pred)), 
             by = .(pmid, cta, app.mthd, man.source, inst)]

bpqdat[, `:=` (errange = er90 - er10, rerrange = (er90 - er10) / ermed)]

bpqdat <- merge(pdat, bpqdat, by = 'pmid', suffixes = c('', '.qp'))
