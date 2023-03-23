
pars <- fread('../../pars/output/pars.csv')

pars03 <- as.numeric(pars[pars == 'c', ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]

# Add incorp pars from pars02
pars03 <- c(pars03, ALFAM2pars02[grepl('incorp', names(ALFAM2pars02))])
