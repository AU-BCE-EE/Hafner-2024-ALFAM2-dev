---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "11 April, 2024 Apr:04"
---

# Summary of main data subset


```r
nrow(pdat1)
```

```
## [1] 729
```



```r
table(pdat1[, inst])
```

```
## 
## 101 102 103 104 105 106 107 108 201 202 203 204 205 206 207 208 209 210 211 212 
##   0   0   0  28   0   0   0   0   0 109   7  17  73   9  45  29   5   8   0  49 
## 213 214 301 302 303 304 
##   0 344   0   0   4   2
```

```r
table(pdat1[, country])
```

```
## 
##  CA  CH  DE  DK  FR  IE  IT  NL  UK 
##   7  45   9 117  29  49  11 353 109
```


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   688    41
```

```r
table(pdat1[, .(institute, digested)])
```

```
##           digested
## institute  FALSE TRUE
##   ADAS-RR    109    0
##   ARDC         7    0
##   AT          12    5
##   AU          67    6
##   CAU-LU       0    9
##   DIAS        28    0
##   INH-HAFL    45    0
##   INRA         9    4
##   INRAE        4   12
##   MU           5    0
##   NMI-WUR      8    0
##   TEAGASC     49    0
##   UNIMI        0    4
##   UNINA        1    1
##   WUR        344    0
```

```r
table(pdat1[, .(uptake, digested)])
```

```
##       digested
## uptake FALSE TRUE
##      1    28    0
##      2   310   18
##      3   350   23
```

```r
table(pdat1[, .(uptake, acid)])
```

```
##       acid
## uptake FALSE TRUE
##      1    28    0
##      2   297   31
##      3   365    8
```

```r
table(pdat1[, .(institute, acid)])
```

```
##           acid
## institute  FALSE TRUE
##   ADAS-RR    109    0
##   ARDC         7    0
##   AT          17    0
##   AU          47   26
##   CAU-LU       9    0
##   DIAS        28    0
##   INH-HAFL    45    0
##   INRA        13    0
##   INRAE       16    0
##   MU           5    0
##   NMI-WUR      3    5
##   TEAGASC     49    0
##   UNIMI        4    0
##   UNINA        2    0
##   WUR        336    8
```

```r
table(pdat1[, .(uptake, incorp)])
```

```
##       incorp
## uptake deep none shallow
##      1    0   28       0
##      2    0  318      10
##      3    3  325      45
```

```r
table(pdat1[, .(institute, incorp)])
```

```
##           incorp
## institute  deep none shallow
##   ADAS-RR     0  109       0
##   ARDC        0    7       0
##   AT          0   17       0
##   AU          0   73       0
##   CAU-LU      0    9       0
##   DIAS        0   28       0
##   INH-HAFL    0   45       0
##   INRA        0    7       6
##   INRAE       0   14       2
##   MU          0    1       4
##   NMI-WUR     0    8       0
##   TEAGASC     0   49       0
##   UNIMI       0    1       3
##   UNINA       0    2       0
##   WUR         3  301      40
```


```r
nrow(dat1)
```

```
## Error in eval(expr, envir, enclos): object 'dat1' not found
```


```r
table(idat1[, rain.missing])
```

```
## 
## FALSE  TRUE 
## 17465    87
```

```r
100 * mean(idat1[, rain.missing])
```

```
## [1] 0.49567
```

```r
table(idat1[, interp.wind])
```

```
## 
## FALSE  TRUE 
## 17539    13
```

```r
100 * mean(idat1[, interp.wind])
```

```
## [1] 0.07406563
```

```r
table(idat1[, interp.air.temp])
```

```
## 
## FALSE  TRUE 
## 17550     2
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## [1] 0.01139471
```

```r
table(idat1[, man.ph.missing])
```

```
## 
## FALSE  TRUE 
## 16846   706
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## [1] 4.022334
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   719    10
```

```r
100 * mean(xx[, 2])
```

```
## Warning in mean.default(xx[, 2]): argument is not numeric or logical: returning
## NA
```

```
## [1] NA
```

```r
xx <- idat1[, any(interp.wind), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   716    13
```

```r
100 * mean(xx[, 2])
```

```
## Warning in mean.default(xx[, 2]): argument is not numeric or logical: returning
## NA
```

```
## [1] NA
```

```r
xx <- idat1[, any(interp.air.temp), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   727     2
```

```r
100 * mean(xx[, 2])
```

```
## Warning in mean.default(xx[, 2]): argument is not numeric or logical: returning
## NA
```

```
## [1] NA
```

```r
xx <- idat1[, any(man.ph.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   684    45
```

```r
100 * mean(xx[, 2])
```

```
## Warning in mean.default(xx[, 2]): argument is not numeric or logical: returning
## NA
```

```
## [1] NA
```

# Problems with incorporation


```r
table(pdati[, c('country', 'man.ph')])
```

```
##        man.ph
## country 7.12 7.2 7.3 7.47 7.5 7.6 7.7 7.76 7.8 7.9 8 8.09 8.1 8.2 8.36 8.5
##      FR    4   0   4    0   2   0   0    0   0   1 0    1   0   1    0   0
##      IT    0   0   0    1   0   0   0    1   0   0 2    0   0   0    4   0
##      NL    0   4   4    0   0   2   2    0   3   0 6    0   6   0    0   4
```

```r
table(pdati[, c('incorp', 'man.ph')])
```

```
##          man.ph
## incorp    7.12 7.2 7.3 7.47 7.5 7.6 7.7 7.76 7.8 7.9 8 8.09 8.1 8.2 8.36 8.5
##   deep       0   0   0    0   0   0   0    0   0   0 0    0   0   0    0   0
##   none       2   2   4    0   2   0   0    0   1   0 5    0   3   0    1   1
##   shallow    2   2   4    1   0   2   2    1   2   1 3    1   3   1    3   3
```

Low pH for shallow incorp plots probably causing wrong sign for shallow incorp pars.

