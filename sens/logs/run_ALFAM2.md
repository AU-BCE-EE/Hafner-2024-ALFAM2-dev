---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "24 May, 2023 May:05"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '2.22'
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
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
```

```r
preds <- preds[ct == 168]
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pdat <- cbind(dat, preds)
```

Run the others (boot)


```r
for (i in unique(bpars$parset)) {

  d <- bpars[parset == i, ]
  pars <- d[, value]
  names(pars) <- d[, parameter]

  preds <- data.table(ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars, prep = TRUE))
  preds <- preds[ct == 168]

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  pdat <- rbind(pdat, cbind(dat, preds))

}
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
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
##   app.mthd.os.f0
##   app.rate.ni.f0
##   man.dm.f0
##   man.source.pig.f0
##   app.mthd.cs.f0
##   int.r1
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   app.mthd.ts.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   int.r5
##   rain.rate.r5
##   air.temp.r3
##   man.ph.r1
##   man.ph.r3
```




