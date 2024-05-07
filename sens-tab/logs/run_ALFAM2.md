---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "07 May, 2024 May:05"
---

Check package version.


```r
packageVersion('ALFAM2')
```

```
## [1] '3.100'
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
```


