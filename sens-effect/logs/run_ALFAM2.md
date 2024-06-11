---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "05 June, 2024 Jun:06"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '4.0'
```

Run model with par set 3

```r
preds <- data.table(alfam2(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, conf.int = 0.9, pars.ci = pars03var))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(dat = dat, pars = pars, add.pars = add.pars, app.name = app.name, : Input data dat had application rate app.rate.ni > 0 for injection application methods app.mthd.os or app.mthd.cs.
##     But app.rate.ni should not affect emissions from injection
##    (ni = no injection), so app.rate.ni was set to 0 for these rows.
```

```
## Warning in alfam2(dat = dat, pars = pars, add.pars = add.pars, app.name = app.name, : Running with 19 parameters. Dropped 3 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.deep.f4
##   incorp.deep.r3
```

```r
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pdat <- cbind(dat, preds)
```
