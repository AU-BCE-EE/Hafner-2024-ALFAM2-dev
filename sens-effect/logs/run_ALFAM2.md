---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "19 April, 2024 Apr:04"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.83'
```

Run model with par set 3

```r
preds <- data.table(alfam2(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, prep.dum = TRUE))
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
```
