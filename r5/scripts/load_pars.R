
pars <- fread('../../pars/output/pars.csv')
pars03 <- as.numeric(pars[pars == 'c', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]

pars025 <- ALFAM2pars02
pars025 <- c(pars025, int.r5 = -2.2)
