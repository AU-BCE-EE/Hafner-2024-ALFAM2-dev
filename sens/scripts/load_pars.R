
# Par set 3
pars <- fread('../../pars/output/pars.csv')
#pars03 <- as.numeric(pars[pars == 'bc2', ])
pars03 <- as.numeric(pars[pars == pn, ])
names(pars03) <- colnames(pars)
pars03 <- pars03[!is.na(pars03)]

# Bootstrap stuff
bpars <- fread('../../pars/output/pars_boot_long.csv')
