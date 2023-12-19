---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "19 December, 2023 Dec:12"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.22'
```

Run model with par set 3


```r
pr3 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = pars03, prep = TRUE)
```

```
## User-supplied parameters are being used.
```

```
## Incorporation applied for groups: 25bc, 25bsth, 25cs, 25os, 25ts, 6bc, 6bsth, 6cs, 6os, 6ts, 7bc, 7bsth, 7cs, 7os, 7ts, 8bc, 8bsth, 8cs, 8os, 8ts.
```

Run with par set 2


```r
pr2 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = ALFAM2pars02, prep = TRUE)
```

```
## User-supplied parameters are being used.
```

```
## Incorporation applied for groups: 25bc, 25bsth, 25cs, 25os, 25ts, 6bc, 6bsth, 6cs, 6os, 6ts, 7bc, 7bsth, 7cs, 7os, 7ts, 8bc, 8bsth, 8cs, 8os, 8ts.
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : Running with 23 parameters. Dropped 1 with no match.
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

Run with par set 1


```r
pr1 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = ALFAM2pars01, prep = TRUE)
```

```
## User-supplied parameters are being used.
```

```
## Incorporation applied for groups: 25bc, 25bsth, 25cs, 25os, 25ts, 6bc, 6bsth, 6cs, 6os, 6ts, 7bc, 7bsth, 7cs, 7os, 7ts, 8bc, 8bsth, 8cs, 8os, 8ts.
```
