---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "04 October, 2024 Oct:10"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '4.1.3'
```

Check values of pars03.


```r
pars03[order(names(pars03))]
```

```
##       air.temp.r1    app.mthd.bc.r1    app.mthd.cs.f0    app.mthd.cs.r3 
##        0.03321186        0.73714111       -7.09642528       -0.38439637 
##    app.mthd.os.f0    app.mthd.ts.r1    incorp.deep.f4    incorp.deep.r3 
##       -2.89718049       -0.07393662       -2.94966810       -5.35112099 
## incorp.shallow.f4            int.f0            int.r1            int.r2 
##       -1.41820869        0.45305451       -1.45119862       -1.16953266 
##            int.r3            int.r5         man.dm.f0         man.dm.r1 
##       -2.68829766       -1.80000000        0.49956176       -0.03300931 
##         man.ph.r1         man.ph.r3 man.source.pig.f0      rain.rate.r2 
##        0.42121280        0.11776977       -0.95213804        0.60163865 
##      rain.rate.r5      wind.sqrt.r1 
##        0.48425409        0.46104870
```

Compare to:


```r
alfam2pars03[order(names(alfam2pars03))]
```

```
##       air.temp.r1    app.mthd.bc.r1    app.mthd.cs.f0    app.mthd.cs.r3 
##        0.03454900        0.71991146       -7.80196997       -0.34883867 
##    app.mthd.os.f0    app.mthd.ts.r1    incorp.deep.f4    incorp.deep.r3 
##       -2.93492578       -0.09333684       -3.26822034       -1.96259695 
## incorp.shallow.f4            int.f0            int.r1            int.r2 
##       -1.37979544        0.43613933       -1.46760800       -1.20493824 
##            int.r3            int.r5         man.dm.f0         man.dm.r1 
##       -2.71593590       -1.80000000        0.49659337       -0.02843126 
##         man.ph.r1         man.ph.r3 man.source.pig.f0      rain.rate.r2 
##        0.44886708        0.03557064       -0.85171386        0.62051420 
##      rain.rate.r5      wind.sqrt.r1 
##        0.34944126        0.46628989
```

Run model with par set 3


```r
pr3 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = pars03, flatout = TRUE)
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : You are using the flatout = TRUE option.
##    Be sure to verify output.
```

```r
#pr3 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
#              group = 'sida', pars = alfam2pars03, flatout = TRUE)
setDT(pr3)
```

Run with par set 2


```r
pr2 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = alfam2pars02, flatout = TRUE)
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : You are using the flatout = TRUE option.
##    Be sure to verify output.
```

```r
setDT(pr2)
```

Run with par set 1


```r
pr1 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = alfam2pars01, flatout = TRUE)
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : You are using the flatout = TRUE option.
##    Be sure to verify output.
```

```r
setDT(pr1)
```

ALFAM(1) model


```r
dat[, app.mthd.bsth := 0]
dat[app.mthd == 'bsth', app.mthd.bsth := 1]
dat[, incorp.none := 0]
dat[incorp == 'none', incorp.none := 1]
dat[, meas.tech.mm := 1]
pr0 <- ALFAM1mod(as.data.frame(dat), time.name = 'ct', group = 'sida')
```

```
## Warning in ALFAM1mod(as.data.frame(dat), time.name = "ct", group = "sida"):
## Some parameters not used: wetsoil, app.mthd.pi, meas.tech.wt
```

```r
pr0 <- as.data.table(pr0)
pr0[er > 1, er := 1]
```


