---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "14 March, 2023 Mar:03"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '2.22'
```

Parameter values.


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

With sets 1 and 2 excluding pH.


```r
pars01 <- ALFAM2pars01[!grepl('man.ph', names(ALFAM2pars01))]
pars02 <- ALFAM2pars02[!grepl('man.ph', names(ALFAM2pars02))]
```


```r
d.pred.ps1 <- as.data.table(alfam2(as.data.frame(idat1), pars = pars01, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(as.data.frame(idat1), pars = pars01, app.name = "tan.app", : Running with 15 parameters. Dropped 3 with no match.
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
d.pred.ps2 <- as.data.table(alfam2(as.data.frame(idat1), pars = pars02, app.name = 'tan.app', time.name = 'cta', group = 'pmid'))
```

```
## User-supplied parameters are being used.
```

```
## Warning in alfam2(as.data.frame(idat1), pars = pars02, app.name = "tan.app", : Running with 16 parameters. Dropped 6 with no match.
## These secondary parameters have been dropped:
##   app.rate.ni.f0
##   ts.cereal.hght.r1
##   incorp.shallow.f4
##   incorp.shallow.r3
##   incorp.deep.f4
##   incorp.deep.r3
## 
## These secondary parameters are being used:
##   int.f0
##   app.mthd.os.f0
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
names(d.pred.ps1)[-1:-3] <- paste0(names(d.pred.ps1)[-1:-3], '.pred')
names(d.pred.ps2)[-1:-3] <- paste0(names(d.pred.ps2)[-1:-3], '.pred')

d.pred.ps1$pars <- 'ps1'
d.pred.ps2$pars <- 'ps2'

d1 <- cbind(idat1, d.pred.ps1[, -1:-3])
d2 <- cbind(idat1, d.pred.ps2[, -1:-3])
dpreds <- rbind(d1, d2)
```


Plot


```r
ggplot(dpreds, aes(cta, er, group = pmid)) +
  geom_line() +
  facet_wrap(~ app.mthd)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png)


```r
x <- dpreds[institute == 'AU' & meas.tech == 'bLS', ]
ggplot(x, aes(cta, er, colour = app.mthd)) +
  geom_line() +
  geom_line(aes(cta, er.pred), lty = '11') +
  facet_grid(pmid ~ pars)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png)

