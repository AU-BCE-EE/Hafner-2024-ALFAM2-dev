---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "20 July, 2023 Jul:07"
---

# Summary of main data subset


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   549    26
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
##   MU           6    0
##   NMI-WUR      8    0
##   TEAGASC     49    0
##   UNIMI        0    4
##   UNINA        1    1
##   WUR        122    0
```

```r
table(pdat1[, .(uptake, digested)])
```

```
##       digested
## uptake FALSE TRUE
##      1   114    0
##      2   433   18
##      3     2    8
```

```r
table(pdat1[, .(uptake, acid)])
```

```
##       acid
## uptake FALSE TRUE
##      1   114    0
##      2   420   31
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
##   MU           6    0
##   NMI-WUR      3    5
##   TEAGASC     49    0
##   UNIMI        4    0
##   UNINA        2    0
##   WUR        122    0
```

```r
table(pdat1[, .(uptake, incorp)])
```

```
##       incorp
## uptake deep none shallow
##      1    0  114       0
##      2    5  411      35
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
##   MU          1    1       4
##   NMI-WUR     0    8       0
##   TEAGASC     0   49       0
##   UNIMI       0    1       3
##   UNINA       0    2       0
##   WUR         4   93      25
```


```r
table(idat1[, rain.missing])
```

```
## 
## FALSE  TRUE 
## 14337  1233
```

```r
100 * mean(idat1[, rain.missing])
```

```
## [1] 7.919075
```

```r
table(idat1[, interp.wind])
```

```
## 
## FALSE  TRUE 
## 15554    16
```

```r
100 * mean(idat1[, interp.wind])
```

```
## [1] 0.1027617
```

```r
table(idat1[, interp.air.temp])
```

```
## 
## FALSE  TRUE 
## 15566     4
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## [1] 0.02569043
```

```r
table(idat1[, man.ph.missing])
```

```
## 
## FALSE  TRUE 
## 14834   736
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## [1] 4.727039
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   431   144
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
##   559    16
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
##   571     4
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
##   527    48
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

