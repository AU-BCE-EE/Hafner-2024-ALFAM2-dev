
bootcor <- round(cor(d.parsb), 3)
bootcorspear <- round(cor(d.parsb, method = 'spearman'), 3)

write.csv(bootcor, '../output/boot_correlation.csv')
write.csv(bootcorspear, '../output/boot_correlation_spearman.csv')
