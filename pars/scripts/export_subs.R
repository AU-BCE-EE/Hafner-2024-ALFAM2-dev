# Export data subsets, for convenience

fwrite(idat1, '../data-subsets/ALFAM2_interval_sub1.csv')
fwrite(pdat1, '../data-subsets/ALFAM2_plot_sub1.csv')
fwrite(idat2, '../data-subsets/ALFAM2_interval_sub2.csv')
fwrite(pdat2, '../data-subsets/ALFAM2_plot_sub2.csv')

R.utils::gzip('../data-subsets/ALFAM2_interval_sub1.csv', overwrite = TRUE)
R.utils::gzip('../data-subsets/ALFAM2_plot_sub1.csv', overwrite = TRUE)
R.utils::gzip('../data-subsets/ALFAM2_interval_sub2.csv', overwrite = TRUE)
R.utils::gzip('../data-subsets/ALFAM2_plot_sub2.csv', overwrite = TRUE)

# Add log with version
file.copy('../../data-emission/data/data_version.txt', '../data-subsets/data_version.txt', overwrite = TRUE)
