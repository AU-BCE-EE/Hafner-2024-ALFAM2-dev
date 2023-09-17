
pars <- fread('../../pars/output/pars.csv')

pars03 <- as.numeric(pars[pars == 'ps3', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]
