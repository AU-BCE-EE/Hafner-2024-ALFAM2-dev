
ggplot(pdat1, aes(man.dm, man.ph, colour = man.source)) +
  geom_point() +
  geom_smooth(aes(group = man.source), method = lm, se = FALSE)  +
  facet_wrap(~ paste(inst, institute, country)) +
  labs(x = 'Dry matter (%)', y = 'pH') 
ggsave('../plots/pH_v_DM.png', height = 8, width = 8)

ggplot(pdat1, aes(man.dm, man.tan, colour = man.source)) +
  geom_point() +
  geom_smooth(aes(group = man.source), method = lm, se = FALSE)  +
  facet_wrap(~ paste(inst, institute, country)) +
  labs(x = 'Dry matter (%)', y = 'TAN (g/kg)') 
ggsave('../plots/TAN_v_DM.png', height = 8, width = 8)

