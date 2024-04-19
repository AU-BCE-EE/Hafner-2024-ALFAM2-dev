
bootcor <- round(cor(d.parsb), 3)

write.csv(bootcor, '../output/boot_correlation.csv')
args(fwrite)
