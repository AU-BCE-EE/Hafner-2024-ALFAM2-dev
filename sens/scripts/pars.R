
pars <- fread('../../pars/output/pars.csv')
pars03 <- as.numeric(pars[pars == 'c', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]
