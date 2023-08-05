---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "05 August, 2023 Aug:08"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.7'
```

Parameter values.


```r
ALFAM2pars01
```

```
##            int.f0            int.r1            int.r2            int.r3 
##        -0.7364889        -1.1785848        -0.9543731        -2.9012937 
##    app.mthd.os.f0       app.rate.f0         man.dm.f0    incorp.deep.f4 
##        -1.1717859        -0.0134681         0.4074660        -3.6477259 
## incorp.shallow.f4    app.mthd.bc.r1         man.dm.r1       air.temp.r1 
##        -0.4121023         0.6283396        -0.0758220         0.0492777 
##        wind.2m.r1         man.ph.r1       air.temp.r3    incorp.deep.r3 
##         0.0486651         0.5327231         0.0152419        -0.3838862 
##    app.mthd.os.r3         man.ph.r3      rain.rate.r2       rain.cum.r3 
##        -0.1228830         0.2663616         0.4327281        -0.0300936
```

```r
ALFAM2pars02
```

```
##            int.f0    app.mthd.os.f0    app.rate.ni.f0         man.dm.f0 
##       -0.60568338       -1.74351499       -0.01114900        0.39967070 
## man.source.pig.f0    app.mthd.cs.f0            int.r1    app.mthd.bc.r1 
##       -0.59202858       -7.63373787       -0.93921516        0.79352480 
##         man.dm.r1       air.temp.r1        wind.2m.r1    app.mthd.ts.r1 
##       -0.13988189        0.07354268        0.15026720       -0.45907135 
## ts.cereal.hght.r1         man.ph.r1            int.r2      rain.rate.r2 
##       -0.24471238        0.66500000       -1.79918546        0.39402156 
##            int.r3    app.mthd.bc.r3    app.mthd.cs.r3         man.ph.r3 
##       -3.22841225        0.56153956       -0.66647417        0.23800000 
## incorp.shallow.f4 incorp.shallow.r3    incorp.deep.f4    incorp.deep.r3 
##       -0.96496655       -0.58052689       -3.69494954       -1.26569562
```

Run model 

Subset 1


```r
pars01 <- ALFAM2pars01
pars02 <- ALFAM2pars02
```


```r
d.pred1.ps1 <- as.data.table(alfam2(idat1, pars = pars01, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(idat1, pars = pars01, app.name = "tan.app", time.name = "cta", : dat data frame has some columns with reserved names.
## You can proceed, but there may be problems.
## Better to remove/rename the offending columns: __group__add.row__f4
```

```r
d.pred1.ps2 <- as.data.table(alfam2(idat1, pars = pars02, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(idat1, pars = pars02, app.name = "tan.app", time.name = "cta", : dat data frame has some columns with reserved names.
## You can proceed, but there may be problems.
## Better to remove/rename the offending columns: __group__add.row__f4
```

```
## Warning in alfam2(idat1, pars = pars02, app.name = "tan.app", time.name = "cta", : Running with 23 parameters. Dropped 1 with no match.
## These secondary parameters have been dropped:
##   ts.cereal.hght.r1
## 
## These secondary parameters are being used:
##   int.f0
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
##   man.ph.r1
##   int.r2
##   rain.rate.r2
##   int.r3
##   app.mthd.bc.r3
##   app.mthd.cs.r3
##   man.ph.r3
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
```


```r
names(d.pred1.ps1)[-1:-3] <- paste0(names(d.pred1.ps1)[-1:-3], '.pred')
names(d.pred1.ps2)[-1:-3] <- paste0(names(d.pred1.ps2)[-1:-3], '.pred')

d.pred1.ps1$pars <- 'ps1'
d.pred1.ps2$pars <- 'ps2'

d1 <- cbind(idat1, d.pred1.ps1[, -1:-3])
d2 <- cbind(idat1, d.pred1.ps2[, -1:-3])
dpreds1 <- rbind(d1, d2)
```

Subset 2  for null models


```r
pars01 <- ALFAM2pars01[!grepl('man.ph', names(ALFAM2pars01))]
pars02 <- ALFAM2pars02[!grepl('man.ph', names(ALFAM2pars02))]
```


```r
d.pred2.ps1 <- as.data.table(alfam2(idat2, pars = pars01, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(idat2, pars = pars01, app.name = "tan.app", time.name = "cta", : dat data frame has some columns with reserved names.
## You can proceed, but there may be problems.
## Better to remove/rename the offending columns: __group__f4
```

```
## Warning in alfam2(idat2, pars = pars01, app.name = "tan.app", time.name = "cta", : Running with 15 parameters. Dropped 3 with no match.
## These secondary parameters have been dropped:
##   incorp.deep.f4
##   incorp.shallow.f4
##   incorp.deep.r3
## 
## These secondary parameters are being used:
##   int.f0
##   int.r1
##   int.r2
##   int.r3
##   app.mthd.os.f0
##   app.rate.f0
##   man.dm.f0
##   app.mthd.bc.r1
##   man.dm.r1
##   air.temp.r1
##   wind.2m.r1
##   air.temp.r3
##   app.mthd.os.r3
##   rain.rate.r2
##   rain.cum.r3
```

```r
d.pred2.ps2 <- as.data.table(alfam2(idat2, pars = pars02, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(idat2, pars = pars02, app.name = "tan.app", time.name = "cta", : dat data frame has some columns with reserved names.
## You can proceed, but there may be problems.
## Better to remove/rename the offending columns: __group__f4
```

```
## Warning in alfam2(idat2, pars = pars02, app.name = "tan.app", time.name = "cta", : Running with 17 parameters. Dropped 5 with no match.
## These secondary parameters have been dropped:
##   ts.cereal.hght.r1
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
## 
## These secondary parameters are being used:
##   int.f0
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
```


```r
names(d.pred2.ps1)[-1:-3] <- paste0(names(d.pred2.ps1)[-1:-3], '.pred')
names(d.pred2.ps2)[-1:-3] <- paste0(names(d.pred2.ps2)[-1:-3], '.pred')

d.pred2.ps1$pars <- 'ps1'
d.pred2.ps2$pars <- 'ps2'

d1 <- cbind(idat2, d.pred2.ps1[, -1:-3])
d2 <- cbind(idat2, d.pred2.ps2[, -1:-3])
dpreds2 <- rbind(d1, d2)
```
