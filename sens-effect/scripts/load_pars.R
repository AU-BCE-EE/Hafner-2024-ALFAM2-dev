
# Par set 3
pars <- fread('../../pars/output/pars.csv')
pars03 <- as.numeric(pars[pars == 'ps3', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]

pars03var <- fread('../../pars/output/pars_boot.csv')
pars03var <- pars03var[, -1]
