---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "27 February, 2024 Feb:02"
---

# Summary of main data subset


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   591    29
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
##   MU           5    0
##   NMI-WUR      8    0
##   TEAGASC     49    0
##   UNIMI        0    4
##   UNINA        1    1
##   WUR        251    0
```

```r
table(pdat1[, .(uptake, digested)])
```

```
##       digested
## uptake FALSE TRUE
##      1    28    0
##      2   310   18
##      3   253   11
```

```r
table(pdat1[, .(uptake, acid)])
```

```
##       acid
## uptake FALSE TRUE
##      1    28    0
##      2   297   31
##      3   264    0
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
##   MU           5    0
##   NMI-WUR      3    5
##   TEAGASC     49    0
##   UNIMI        4    0
##   UNINA        2    0
##   WUR        251    0
```

```r
table(pdat1[, .(uptake, incorp)])
```

```
##       incorp
## uptake none shallow
##      1   28       0
##      2  318      10
##      3  221      43
```

```r
table(pdat1[, .(institute, incorp)])
```

```
##           incorp
## institute  none shallow
##   ADAS-RR   109       0
##   ARDC        7       0
##   AT         17       0
##   AU         73       0
##   CAU-LU      9       0
##   DIAS       28       0
##   INH-HAFL   45       0
##   INRA        7       6
##   MU          1       4
##   NMI-WUR     8       0
##   TEAGASC    49       0
##   UNIMI       1       3
##   UNINA       2       0
##   WUR       211      40
```


```r
table(idat1[, rain.missing])
```

```
## 
## FALSE  TRUE 
## 16675    87
```

```r
100 * mean(idat1[, rain.missing])
```

```
## [1] 0.5190311
```

```r
table(idat1[, interp.wind])
```

```
## 
## FALSE  TRUE 
## 16749    13
```

```r
100 * mean(idat1[, interp.wind])
```

```
## [1] 0.07755638
```

```r
table(idat1[, interp.air.temp])
```

```
## 
## FALSE  TRUE 
## 16760     2
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## [1] 0.01193175
```

```r
table(idat1[, man.ph.missing])
```

```
## 
## FALSE  TRUE 
## 16084   678
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## [1] 4.044863
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   610    10
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
##   607    13
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
##   618     2
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
##   578    42
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
## country 7.12 7.2 7.3 7.47 7.5 7.6 7.7 7.76 7.8 7.9 8 8.1 8.36 8.5
##      FR    4   0   4    0   2   0   0    0   0   1 0   0    0   0
##      IT    0   0   0    1   0   0   0    1   0   0 2   0    4   0
##      NL    0   4   4    0   0   2   2    0   3   0 6   6    0   4
```

```r
table(pdati[, c('incorp', 'man.ph')])
```

```
##          man.ph
## incorp    7.12 7.2 7.3 7.47 7.5 7.6 7.7 7.76 7.8 7.9 8 8.1 8.36 8.5
##   none       2   2   4    0   2   0   0    0   1   0 5   3    1   1
##   shallow    2   2   4    1   0   2   2    1   2   1 3   3    3   3
```

Low pH for shallow incorp plots probably causing wrong sign for shallow incorp pars.

