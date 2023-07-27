---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "21 July, 2023 Jul:07"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.7'
```

Run model with par set 3

```r
preds <- data.table(ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, prep = TRUE))
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 22 parameters. Dropped 4 with no match.
## These secondary parameters have been dropped:
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
## 
## These secondary parameters are being used:
##   int.f0
##   int.r1
##   int.r2
##   int.r3
##   int.r5
##   app.mthd.os.f0
##   app.mthd.cs.f0
##   app.mthd.bc.r1
##   app.mthd.ts.r1
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.dm.f0
##   man.dm.r1
##   app.rate.ni.f0
##   man.source.pig.f0
##   air.temp.r1
##   wind.2m.r1
##   rain.rate.r2
##   rain.rate.r5
##   man.ph.r1
##   man.ph.r3
##   air.temp.ave.r3
```

```r
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pdat <- cbind(dat, preds)
```
