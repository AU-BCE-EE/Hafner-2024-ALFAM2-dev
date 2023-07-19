# Save pmid for each subset (after adding in plots in prep.R) for reproducibility

pmid1 <- sort(pdat1[, pmid])
write.table(pmid1, '../output/pmid_sub1.txt', row.names = FALSE, col.names = FALSE)

pmid2 <- sort(pdat2[, pmid])
write.table(pmid2, '../output/pmid_sub2.txt', row.names = FALSE, col.names = FALSE)
