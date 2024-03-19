

ggplot(idati, aes(cta, j.NH3, colour = incorp)) +
  geom_line() +
  facet_wrap(~ institute)

table(idat1$incorp)
