---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "28 September, 2023 Sep:09"
---

# Summary of main data subset


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   547    26
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
##   AU          67    3
##   CAU-LU       0    9
##   DIAS        28    0
##   IMAG        86    0
##   INH-HAFL    45    0
##   INRA         9    4
##   MU           5    0
##   NMI-WUR      8    0
##   TEAGASC     49    0
##   UNIMI        0    4
##   UNINA        1    1
##   WUR        121    0
```

```r
table(pdat1[, .(uptake, digested)])
```

```
##       digested
## uptake FALSE TRUE
##      1   114    0
##      2   431   18
##      3     2    8
```

```r
table(pdat1[, .(uptake, acid)])
```

```
##       acid
## uptake FALSE TRUE
##      1   114    0
##      2   418   31
##      3    10    0
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
##   AU          44   26
##   CAU-LU       9    0
##   DIAS        28    0
##   IMAG        86    0
##   INH-HAFL    45    0
##   INRA        13    0
##   MU           5    0
##   NMI-WUR      3    5
##   TEAGASC     49    0
##   UNIMI        4    0
##   UNINA        2    0
##   WUR        121    0
```

```r
table(pdat1[, .(uptake, incorp)])
```

```
##       incorp
## uptake deep none shallow
##      1    0  114       0
##      2    3  411      35
##      3    0    7       3
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
##   AU          0   70       0
##   CAU-LU      0    9       0
##   DIAS        0   28       0
##   IMAG        0   86       0
##   INH-HAFL    0   45       0
##   INRA        0    7       6
##   MU          0    1       4
##   NMI-WUR     0    8       0
##   TEAGASC     0   49       0
##   UNIMI       0    1       3
##   UNINA       0    2       0
##   WUR         3   93      25
```


```r
table(idat1[, rain.missing])
```

```
## 
## FALSE  TRUE 
## 14170  1223
```

```r
100 * mean(idat1[, rain.missing])
```

```
## [1] 7.94517
```

```r
table(idat1[, interp.wind])
```

```
## 
## FALSE  TRUE 
## 15377    16
```

```r
100 * mean(idat1[, interp.wind])
```

```
## [1] 0.1039434
```

```r
table(idat1[, interp.air.temp])
```

```
## 
## FALSE  TRUE 
## 15389     4
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## [1] 0.02598584
```

```r
table(idat1[, man.ph.missing])
```

```
## 
## FALSE  TRUE 
## 14667   726
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## [1] 4.71643
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   430   143
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
##   557    16
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
##   569     4
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
##   526    47
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
## country 7.12 7.3 7.47 7.5 7.76 7.9 8 8.36
##      FR    4   4    0   2    0   1 0    0
##      IT    0   0    1   0    1   0 2    4
##      NL    0   0    0   0    0   0 0    0
```

```r
table(pdati[, c('incorp', 'man.ph')])
```

```
##          man.ph
## incorp    7.12 7.3 7.47 7.5 7.76 7.9 8 8.36
##   deep       0   0    0   0    0   0 0    0
##   none       2   2    0   2    0   0 0    1
##   shallow    2   2    1   0    1   1 2    3
```

Low pH for shallow incorp plots probably causing wrong sign for shallow incorp pars.

