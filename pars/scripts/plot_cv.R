

#cvsumm[, `:=` (pig.nm = factor(ifelse(man.source == 'pig', 'Pig', 'Cattle &\nothers'), levels = c('Pig', 'Cattle &\nothers')),
#               app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
#                              labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
#					 'Open slot\ninjection', 'Closed slot\ninjection')),
#                    incorp.nm = factor(oneupper(incorp), levels = c('None', 'Shallow', 'Deep')))]

cvsumm[, `:=` (pig.nm = factor(ifelse(man.source, 'Pig', 'Cattle &\nothers'), levels = c('Pig', 'Cattle &\nothers')),
               app.mthd.nm = factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'), 
                              labels = c('Broadcast', 'Trailing hose', 'Trailing shoe', 
					 'Open slot\ninjection', 'Closed slot\ninjection')))]

ggplot(cvsumm, aes(app.mthd.nm, ererr, shape = pig.nm, colour = pig.nm)) + 
  geom_point(size = 4) +
  theme_bw() +
  coord_cartesian(ylim = c(0, NA))  +
  labs(x = 'Application method', y = 'Ave. emission error (frac. TAN)', colour = 'Slurry type', shape = 'Slurry type')
ggsave2x('../plots-cv/cross_val_error', height = 3.3, width = 7)


ggplot(cvsumm, aes(app.mthd.nm, rerr, shape = pig.nm, colour = pig.nm)) + 
  geom_point(size = 4) +
  theme_bw() +
  coord_cartesian(ylim = c(0, NA)) +
  labs(x = 'Application method', y = 'Ave. emission error (frac. meas.)', colour = 'Slurry type', shape = 'Slurry type')
ggsave2x('../plots-cv/cross_val_rel_error', height = 3.3, width = 7)
