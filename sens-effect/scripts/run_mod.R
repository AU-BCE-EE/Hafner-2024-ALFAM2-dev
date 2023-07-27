# Run model

# Run with new par set
preds <- ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, prep = TRUE)

names(preds) <- paste0(names(preds), '.pred')
dat <- cbind(dat, preds)
