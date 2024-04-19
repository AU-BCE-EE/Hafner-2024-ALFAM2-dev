
# Open slot injection
dw4 <- rbind(dw1, dw2)
dd <- dw4[ct %in% c('24', 'final')]
dd[, ct.nm := factor(ct, levels = c('24', 'final'), labels = c('24 h', 'Final'))]
dd[, ct.nm := factor(ct, levels = c('24', 'final'), labels = c('24 h', 'Final'))]

ggplot(dd, aes(ct.nm, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  ylim(0, 1) +
  theme_bw() +
  facet_wrap(~ descrip) +
  theme(legend.position = 'right', panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  guides(colour = guide_legend(ncol = 2)) 
  labs(x = 'Emission period', y = 'Relative acidification effect')
ggsave2x('../plots/os_effect', height = 2.5, width = 5)


m1 <- lm(rred ~ iexper + ct, data = dd)
summary(m1)
summary.aov(m1)


dcomp <- rbindf(dw1, dw2, dw3)

ggplot(dcomp, aes(ct, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  facet_wrap(~ descrip)

ggplot(dw1, aes(ct, rred.bsth, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() +
  coord_cartesian(xlim = c(0, 100), ylim = c(-0.1, 1.1)) +
  geom_smooth(method = lm, se = FALSE, aes(group = inst))

ggplot(dw2, aes(ct, rred.bc, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() 

# Repeat for acidification
# Find experiments with acidification and reference
acid.summ <- pdat[, .(n.acid = sum(acid), n.ref = sum(!acid)), by = .(country, institute, iexper)]
acid.summ <- acid.summ[n.acid > 0 & n.ref > 0, ]

ii <- acid.summ$iexper

acidpdat <- pdat[iexper %in% ii, ]
acidpdat[, acid.cond := ifelse(acid, 'acid', 'ref')]


# Cast to wide
dl <- melt(acidpdat, id.vars = c('inst', 'iexper', 'exper', 'app.mthd', 'acid', 'acid.cond', 'pmid'),
           measure.vars = patterns('e\\.rel\\.'))

dw <- dcast(dl, inst + iexper + exper + variable + app.mthd ~ acid.cond, fun.aggregate = mean, na.rm = TRUE)
dw[, ct := as.numeric(sub('e\\.rel\\.', '', variable))]
dw[, `:=` (rred = 1 - acid / ref)]
dw <- dw[!is.na(rred), ]

ggplot(dw, aes(ct, rred, colour = factor(inst), group = iexper)) +
  geom_line() +
  geom_point() +
  geom_smooth(method = lm, se = FALSE, aes(group = inst))



# Main subset
# No acidification, no incorporation
# Manure pH not required
pdat1 <- pdat[!is.na(e.24) &
              !is.na(app.mthd) &
              !is.na(man.dm) &
              !is.na(man.source) & 
              !is.na(air.temp.24) & 
              !is.na(wind.2m.24) & 
              !is.na(till) & 
              !is.na(incorp) & 
              !is.na(crop) & 
              !acid &
              incorp == 'none' &
              e.24 > 0 & 
              e.rel.24 < 1.0 &
              e.rel.final < 1.05 &
              e.rel.final > - 0.05 &
              man.source != 'conc' &
              man.dm <= 15 &
              app.mthd != 'pi' &
              app.mthd != 'bss' &
              meas.tech2 %in% c('micro met') &
              !inst %in% c(102, 107, 108) & # Exclude AUN, old Swiss (IUL/FAT), and JTI
              pmid != 1526 &                # See rows 1703 and 1728 and others in MU data. Check with Marco
              !grepl('Exclude data from analysis', notes.plot) , ]

# These pmid will be retained
pmid.keep <- pdat1[, pmid]

idat1 <- idat[pmid %in% pmid.keep, ]

# Wind speed focused subset
idat1[meas.tech2 == 'micro met', .(wind.2m.range = diff(range(wind.2m))), by = .(country, iexper, app.mthd, meas.tech2)]






dd$app.mthd
dl <- subset(dd, ct == ct.min)[, ct := 0][man.ph == 5.2, ct := -2.8]
ggplot(dd, aes(ct, j.pred, colour = acid, group = pmid)) +
  geom_step() +
  theme_bw() +
  xlim(-5, 50) +
  theme(legend.position = 'none') +
#  scale_color_viridis_d(option = 'D') +
  labs(x = 'Time since application', y = 'Emission (frac. TAN)')
ggsave2x('../plots/acid_flux', height = 2.0, width = 2.5)

dd <- subset(idat, pmid %in% c(1529:1532))
pred <- as.data.table(alfam2(dd, pars = pars03, app.name = 'tan.app', time.name = 'ct', group = 'pmid', prep = TRUE))
names(pred) <- paste0(names(pred), '.pred')
dd <- cbind(dd, pred[, -1:-3])


names(dd)
dd$j.pred
pred$j.pred
head(dd)



dp <- copy(dd)
pred <- alfam2(dd, 

idat$acid
names(idat)
table(dd$acid, dd$pmid)
subset(dd, inst == 210)
