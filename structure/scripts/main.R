# Exploring ALFAM2 model structure implications

rm(list = ls())

source('packages.R')
source('functions.R')
source('load.R')
source('load_pars03.R')
source('subset.R')





source('prep.R')
knit('run1.Rmd', output = '../logs/run1.md')

dd <- subset(pdat, meas.tech2 == 'micro met' & e.rel.final < 1.1 & app.mthd %in% c('bsth', 'ts', 'bc', 'os'))
dd$app.mthd <- factor(dd$app.mthd, levels = c('bsth', 'ts', 'bc', 'os'))
m1 <- lm(e.rel.final ~ man.source + app.mthd * (air.temp.24 + wind.2m.24) + man.dm, data = dd)
summary(m1)
plot(m1)

ggplot(dd, aes(app.mthd, e.rel.final)) + geom_jitter()

library(lme4)
dd <- subset(pdat, meas.tech2 == 'micro met')
dd$inst <- factor(dd$inst)
dd$inst.mm <- interaction(dd$inst, dd$meas.tech2)
dd$app.mthd <- factor(dd$app.mthd, levels = c('bsth', 'ts', 'bc', 'os', 'cs'))
m1 <- lmer(e.rel.final ~ man.source + app.mthd + (air.temp.24 + wind.2m.24) + man.dm + (1|inst), data = dd)
summary(m1)
drop1(m1)

pdat


os.summ <- pdat[, .(n.os = sum(app.mthd == 'os'), n.bc = sum(app.mthd == 'bc'), n.bsth = sum(app.mthd == 'bsth')), by = .(country, institute, iexper)]
os.summ <- os.summ[n.os > 0 & n.bc > 0 | n.bsth > 0, ]

ii <- os.summ$iexper

dd <- subset(pdat, iexper %in% ii)
dd[, wthr := air.temp.24 + 2 * wind.2m.24]

ALFAM2pars02
ALFAM2pars01
pdat[, wthr := air.temp.24 + 2 * wind.2m.24]
ggplot(dd, aes(wthr, e.rel.final, colour = factor(inst))) +
  geom_smooth(method = lm, se = FALSE, aes(group = 1)) +
  geom_point() +
  facet_wrap(~ app.mthd) +
  ylim(0, 1)
ggsave('../plots/wthr_effect.png', height = 3, width = 6)

# Experiments with incorporation and none for reference
incorp.summ <- pdat[, .(n.incorp = sum(incorp != 'none'), n.ref = sum(incorp == 'none')), by = .(country, institute, iexper)]
incorp.summ <- incorp.summ[n.incorp > 0, ]

library(lme4)
dd$inst <- factor(dd$inst)
dd$inst.mm <- interaction(dd$inst, dd$meas.tech2)
dd$app.mthd <- factor(dd$app.mthd, levels = c('bsth', 'ts', 'bc', 'os', 'cs'))
m1 <- lmer(e.rel.final ~ man.source + app.mthd + air.temp.24 + wind.2m.24 + (1|inst), data = dd)

pdat[, inst.mm := interaction(inst, meas.tech2)]
pdat[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))]
m1 <- lmer(e.rel.final ~ man.dm + man.source + app.mthd * wthr + (1|inst.mm), data = pdat)
m2 <- lmer(e.rel.final ~ man.dm + man.source + app.mthd * (air.temp.48 + wind.2m.48) + (1|inst.mm), data = pdat)
summary(m1)
summary(m2)
drop1(m1, test = 'Chisq')
table(pdat$meas.tech2)

d2 <- subset(pdat, meas.tech2 %in% c('micro met', 'wt') & !inst %in% c(102, 107, 108) & app.mthd %in% c('bsth', 'os'))  # Exclude AUN, old Swiss (IUL/FAT), and JTI
d2[, inst.mm := interaction(inst, meas.tech2)]
d2[, app.mthd := factor(app.mthd, levels = c('bc', 'bsth', 'ts', 'os', 'cs'))]
d2[, wthr := air.temp.24 + 2 * wind.2m.24]
m1 <- lmer(e.rel.final ~ app.mthd * wthr + (1|inst.mm), data = d2)
m2 <- lmer(e.rel.final ~ man.dm + man.source + app.mthd * (air.temp.48 + wind.2m.48) + (1|inst.mm), data = d2)
summary(m1)
summary(m2)
drop1(m1, test = 'Chisq')
drop1(m2, test = 'Chisq')
table(pdat$meas.tech2)
table(d2$app.mthd)


