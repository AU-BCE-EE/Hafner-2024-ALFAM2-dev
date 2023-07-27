
# Par set 3
pars <- fread('../../pars/output/pars.csv')
pars03 <- as.numeric(pars[pars == 'h4', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]
