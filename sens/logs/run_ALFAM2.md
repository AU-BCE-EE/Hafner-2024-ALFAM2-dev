---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "21 November, 2023 Nov:11"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.16'
```

Run model with par set 3

```r
preds <- data.table(ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, prep = TRUE))
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   int.r5
##   rain.rate.r5
##   wind.sqrt.r1
```

```r
names(preds) <- paste0(names(preds), '.pred')
preds[, parset := '3']
pdat <- cbind(dat, preds)

# Different for application methods
preds <- data.table(ALFAM2mod(dat.app.mthd, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars03, prep = TRUE))
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   int.r5
##   rain.rate.r5
##   wind.sqrt.r1
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

  preds <- data.table(ALFAM2mod(dat, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars, prep = TRUE))

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  pdat <- rbind(pdat, cbind(dat, preds))

  # Different for application methods
  preds <- data.table(ALFAM2mod(dat.app.mthd, app.name = 'tan.app', time.name = 'ct', group = 'id', pars = pars, prep = TRUE))

  names(preds) <- paste0(names(preds), '.pred')
  preds[, parset := i]
  pamdat <- rbind(pamdat, cbind(dat.app.mthd, preds))

}
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## Warning in calcPParms(pars[which2], dat, upr = 100): Some calculated primary
## parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5

## Warning in ALFAM2mod(dat, app.name = "tan.app", time.name = "ct", group = "id", : Some calculated primary parameters are at the limit. Check input parameters.
```

```
## User-supplied parameters are being used.
```

```
## Warning in ALFAM2mod(dat.app.mthd, app.name = "tan.app", time.name = "ct", : Running with 21 parameters. Dropped 4 with no match.
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
##   wind.sqrt.r1
##   app.mthd.ts.r1
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   rain.rate.r5
##   int.r5
```




