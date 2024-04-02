---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "19 March, 2024 Mar:03"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.78'
```

Run model with par set 3

```r
args(alfam2)
```

```
## function (dat, pars = ALFAM2::alfam2pars02, add.pars = NULL, 
##     app.name = "TAN.app", time.name = "ct", time.incorp = NULL, 
##     group = NULL, center = c(app.rate = 40, man.dm = 6, man.tan = 1.2, 
##         man.ph = 7.5, air.temp = 13, wind.2m = 2.7, wind.sqrt = sqrt(2.7), 
##         crop.z = 10), pass.col = NULL, incorp.names = c("incorp", 
##         "deep", "shallow"), prep.dum = TRUE, prep.incorp = TRUE, 
##     add.incorp.rows = FALSE, check = TRUE, warn = TRUE, value = "emis", 
##     conf.int = NULL, pars.ci = NULL, n.ci = NULL, var.ci = "er", 
##     ...) 
## NULL
```

```r
preds <- data.table(alfam2(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```r
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pdat <- cbind(dat, preds)

# Different for application methods
preds <- data.table(alfam2(dat.app.mthd, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```r
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pamdat <- cbind(dat.app.mthd, preds)
```

Run the others (boot)


```r
for (i in unique(bpars$parset)) {

  d <- bpars[parset == i, ]
  pars <- d[, value]
  names(pars) <- d[, parameter]

  preds <- data.table(alfam2(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars))

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  pdat <- rbind(pdat, cbind(dat, preds))

  # Different for application methods
  preds <- data.table(alfam2(dat.app.mthd, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars))

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  pamdat <- rbind(pamdat, cbind(dat.app.mthd, preds))

}
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## Warning in calcPParms(pars[which2], dat, warn = warn, upr = 1e+15): Some
## calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```




