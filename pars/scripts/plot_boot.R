
ggplot(bpqdat, aes(app.mthd.nm, errange)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = 'Application method', y = 'Uncertainty (frac. TAN)')
ggsave2x('../plots/boot_box_1', height = 2.5, width = 3.9)

ggplot(bpqdat, aes(app.mthd.nm, rerrange)) +
  geom_boxplot() +
  theme_bw() +
  labs(x = 'Application method', y = 'Pred. uncertainty (frac. median emis.)')
ggsave2x('../plots/boot_box_2', height = 3, width = 4)
