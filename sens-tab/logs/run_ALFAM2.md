---
title: 'Model call record'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "17 April, 2024 Apr:04"
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
pr3 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = pars03, flatout = TRUE)
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : You are using the flatout = TRUE option.
##    Be sure to verify output.
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

Run with par set 1


```r
pr1 <- alfam2(dat, app.name = 'tan.app', time.name = 'ct', time.incorp = 'time.incorp',
              group = 'sida', pars = alfam2pars01, flatout = TRUE)
```

```
## Warning in alfam2(dat, app.name = "tan.app", time.name = "ct", time.incorp = "time.incorp", : You are using the flatout = TRUE option.
##    Be sure to verify output.
```
