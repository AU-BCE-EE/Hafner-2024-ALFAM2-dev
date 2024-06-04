# Get par sets

pars025 <- alfam2pars02
pars025 <- c(pars025, int.r5 = -1.8, rain.rate.r5 = 0.5)

# Par set 3
pars <- fread('../../pars/output/pars.csv')
pars03 <- as.numeric(pars[pars == pn, ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]
