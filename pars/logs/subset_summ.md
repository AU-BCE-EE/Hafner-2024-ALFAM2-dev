---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "19 August, 2024 Aug:08"
---

# Summary of main data subset


```r
nrow(pdat1)
```

```
## [1] 722
```



```r
table(pdat1[, inst])
```

```
## 
## 101 102 103 104 105 106 107 108 201 202 203 204 205 206 207 208 209 210 211 212 
##   0   0   0  28   0   0   0   0   0 109   7  17  74   9  45  32   6   8   0  49 
## 213 214 301 302 303 304 305 
##   0 332   0   0   0   4   2
```

```r
table(pdat1[, country])
```

```
## 
##  CA  CH  DE  DK  FR  IE  IT  NL  UK 
##   7  45   9 118  32  49  12 341 109
```

```r
table(pdat1[, .(inst, sub.period)])
```

```
##      sub.period
## inst    1   2   3
##   101   0   0   0
##   102   0   0   0
##   103   0   0   0
##   104  28   0   0
##   105   0   0   0
##   106   0   0   0
##   107   0   0   0
##   108   0   0   0
##   201   0   0   0
##   202   0 109   0
##   203   0   7   0
##   204   0  17   0
##   205   0  67   7
##   206   0   9   0
##   207   0  45   0
##   208   0  15  17
##   209   0   6   0
##   210   0   8   0
##   211   0   0   0
##   212   0  49   0
##   213   0   0   0
##   214 102 131  99
##   301   0   0   0
##   302   0   0   0
##   303   0   0   0
##   304   0   0   4
##   305   0   0   2
```

```r
table(pdat1[, .(institute, sub.period)])
```

```
##           sub.period
## institute    1   2   3
##   ADAS-RR    0 109   0
##   ARDC       0   7   0
##   AT         0  17   0
##   AU         0  67   7
##   CAU-LU     0   9   0
##   DIAS      28   0   0
##   INH-HAFL   0  45   0
##   INRA       0  15   0
##   INRAE      0   0  17
##   MU         0   6   0
##   NMI-WUR    0   8   0
##   TEAGASC    0  49   0
##   UNIMI      0   0   4
##   UNINA      0   0   2
##   WUR      102 131  99
```

```r
table(pdat1[, man.source])
```

```
## 
##   cat   mix other   pig 
##   475    18     8   221
```


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   681    41
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
##   AU          68    6
##   CAU-LU       0    9
##   DIAS        28    0
##   INH-HAFL    45    0
##   INRA        11    4
##   INRAE        5   12
##   MU           6    0
##   NMI-WUR      8    0
##   TEAGASC     49    0
##   UNIMI        0    4
##   UNINA        1    1
##   WUR        332    0
```

```r
names(pdat1)
```

```
##   [1] "inst"                  "eid"                   "pid"                  
##   [4] "pmid"                  "sub.period"            "corr.period"          
##   [7] "proj"                  "exper"                 "exper2"               
##  [10] "institute"             "country"               "submitter"            
##  [13] "file"                  "first.row.in.file.int" "last.row.in.file.int" 
##  [16] "row.in.file.plot"      "pub.id"                "pub.info"             
##  [19] "lat"                   "long"                  "topo"                 
##  [22] "field"                 "plot"                  "plot.area"            
##  [25] "treat"                 "rep"                   "rep2"                 
##  [28] "n.ints"                "t.start.p"             "t.end.p"              
##  [31] "dt1"                   "dt.min"                "dt.max"               
##  [34] "ct.min"                "ct.max"                "meas.tech"            
##  [37] "meas.tech2"            "meas.tech.orig"        "meas.tech.det"        
##  [40] "j.NH31"                "j.rel1"                "e.1"                  
##  [43] "e.4"                   "e.6"                   "e.12"                 
##  [46] "e.24"                  "e.48"                  "e.72"                 
##  [49] "e.96"                  "e.168"                 "e.final"              
##  [52] "e.cum.1"               "e.cum.4"               "e.cum.6"              
##  [55] "e.cum.12"              "e.cum.24"              "e.cum.48"             
##  [58] "e.cum.72"              "e.cum.96"              "e.cum.168"            
##  [61] "e.cum.final"           "e.rel.1"               "e.rel.4"              
##  [64] "e.rel.6"               "e.rel.12"              "e.rel.24"             
##  [67] "e.rel.48"              "e.rel.72"              "e.rel.96"             
##  [70] "e.rel.168"             "e.rel.final"           "clay"                 
##  [73] "silt"                  "sand"                  "oc"                   
##  [76] "soil.type"             "soil.type2"            "soil.water"           
##  [79] "soil.water.v"          "soil.moist"            "soil.ph"              
##  [82] "soil.dens"             "crop.res"              "till"                 
##  [85] "air.temp.1"            "air.temp.4"            "air.temp.6"           
##  [88] "air.temp.12"           "air.temp.24"           "air.temp.48"          
##  [91] "air.temp.72"           "air.temp.96"           "air.temp.168"         
##  [94] "air.temp.mn"           "air.temp.z"            "soil.temp.1"          
##  [97] "soil.temp.4"           "soil.temp.6"           "soil.temp.12"         
## [100] "soil.temp.24"          "soil.temp.48"          "soil.temp.72"         
## [103] "soil.temp.96"          "soil.temp.168"         "soil.temp.mn"         
## [106] "soil.temp.surf.1"      "soil.temp.surf.4"      "soil.temp.surf.6"     
## [109] "soil.temp.surf.12"     "soil.temp.surf.24"     "soil.temp.surf.48"    
## [112] "soil.temp.surf.72"     "soil.temp.surf.96"     "soil.temp.surf.168"   
## [115] "soil.temp.surf.mn"     "soil.temp.z"           "rad.1"                
## [118] "rad.4"                 "rad.6"                 "rad.12"               
## [121] "rad.24"                "rad.48"                "rad.72"               
## [124] "rad.96"                "rad.168"               "rad.mn"               
## [127] "wind.1"                "wind.4"                "wind.6"               
## [130] "wind.12"               "wind.24"               "wind.48"              
## [133] "wind.72"               "wind.96"               "wind.168"             
## [136] "wind.mn"               "wind.z"                "wind.2m.1"            
## [139] "wind.2m.4"             "wind.2m.6"             "wind.2m.12"           
## [142] "wind.2m.24"            "wind.2m.48"            "wind.2m.72"           
## [145] "wind.2m.96"            "wind.2m.168"           "wind.2m.mn"           
## [148] "wind.loc"              "rain.1"                "rain.4"               
## [151] "rain.6"                "rain.12"               "rain.24"              
## [154] "rain.48"               "rain.72"               "rain.96"              
## [157] "rain.168"              "rain.tot"              "rain.rate.1"          
## [160] "rain.rate.4"           "rain.rate.6"           "rain.rate.12"         
## [163] "rain.rate.24"          "rain.rate.48"          "rain.rate.72"         
## [166] "rain.rate.96"          "rain.rate.168"         "rain.rate.mn"         
## [169] "rh.1"                  "rh.4"                  "rh.6"                 
## [172] "rh.12"                 "rh.24"                 "rh.48"                
## [175] "rh.72"                 "rh.96"                 "rh.168"               
## [178] "rh.mn"                 "far.loc"               "man.source"           
## [181] "man.source.orig"       "man.source.det"        "man.bed"              
## [184] "man.con"               "man.trt1"              "man.trt2"             
## [187] "man.trt3"              "man.stor"              "man.dm"               
## [190] "man.vs"                "man.tkn"               "man.tan"              
## [193] "man.vfa"               "man.tic"               "man.ua"               
## [196] "man.ph"                "acid"                  "date.start"           
## [199] "app.start"             "app.start.orig"        "app.end"              
## [202] "app.end.orig"          "app.method"            "app.method.orig"      
## [205] "app.rate"              "tan.app"               "incorp"               
## [208] "incorp.orig"           "time.incorp"           "man.area"             
## [211] "dist.inj"              "furrow.z"              "furrow.w"             
## [214] "crop"                  "crop.orig"             "crop.z"               
## [217] "crop.area"             "lai"                   "notes.plot"           
## [220] "flag.plot"             "app.mthd"              "digested"             
## [223] "man.ph.missing"        "iexper"
```

```r
table(pdat1[, .(sub.period, digested)])
```

```
##           digested
## sub.period FALSE TRUE
##          1   130    0
##          2   445   18
##          3   106   23
```

```r
table(pdat1[, .(sub.period, acid)])
```

```
##           acid
## sub.period FALSE TRUE
##          1   130    0
##          2   432   31
##          3   121    8
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
##   AU          48   26
##   CAU-LU       9    0
##   DIAS        28    0
##   INH-HAFL    45    0
##   INRA        15    0
##   INRAE       17    0
##   MU           6    0
##   NMI-WUR      3    5
##   TEAGASC     49    0
##   UNIMI        4    0
##   UNINA        2    0
##   WUR        324    8
```

```r
table(pdat1[, .(sub.period, incorp)])
```

```
##           incorp
## sub.period deep none shallow
##          1    0  130       0
##          2    4  418      41
##          3    0  113      16
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
##   AU          0   74       0
##   CAU-LU      0    9       0
##   DIAS        0   28       0
##   INH-HAFL    0   45       0
##   INRA        0    7       8
##   INRAE       0   15       2
##   MU          1    1       4
##   NMI-WUR     0    8       0
##   TEAGASC     0   49       0
##   UNIMI       0    1       3
##   UNINA       0    2       0
##   WUR         3  289      40
```


```r
table(idat1[, rain.missing])
```

```
## 
## FALSE  TRUE 
## 18698    87
```

```r
100 * mean(idat1[, rain.missing])
```

```
## [1] 0.4631355
```

```r
table(idat1[, interp.wind])
```

```
## 
## FALSE  TRUE 
## 18772    13
```

```r
100 * mean(idat1[, interp.wind])
```

```
## [1] 0.06920415
```

```r
table(idat1[, interp.air.temp])
```

```
## 
## FALSE  TRUE 
## 18783     2
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## [1] 0.01064679
```

```r
table(idat1[, man.ph.missing])
```

```
## 
## FALSE  TRUE 
## 18079   706
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## [1] 3.758318
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
table(xx[, 2])
```

```
## V1
## FALSE  TRUE 
##   712    10
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
##   709    13
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
##   720     2
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
##   677    45
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
## country 7.12 7.2 7.3 7.35 7.47 7.5 7.52 7.6 7.7 7.76 7.79 7.8 7.83 7.85 7.87
##      DK    0   0   0    1    0   0    1   0   0    0    6   4    2    2    4
##      FR    4   0   4    0    0   2    0   0   0    0    0   0    0    0    0
##      IT    0   0   0    0    1   0    0   0   0    1    0   0    0    0    0
##      NL    0   4   4    0    0   0    0   2   2    0    0   3    0    0    0
##        man.ph
## country 7.88 7.9 8 8.09 8.1 8.2 8.36 8.5
##      DK    2   0 0    0   0   0    0   0
##      FR    0   1 0    1   0   1    0   0
##      IT    0   0 2    0   0   0    4   0
##      NL    0   0 6    0   6   0    0   4
```

```r
table(pdati[, c('incorp', 'man.ph')])
```

```
##          man.ph
## incorp    7.12 7.2 7.3 7.35 7.47 7.5 7.52 7.6 7.7 7.76 7.79 7.8 7.83 7.85 7.87
##   deep       0   0   0    0    0   0    0   0   0    0    0   0    0    0    0
##   none       2   2   4    1    0   2    1   0   0    0    6   5    2    2    4
##   shallow    2   2   4    0    1   0    0   2   2    1    0   2    0    0    0
##          man.ph
## incorp    7.88 7.9 8 8.09 8.1 8.2 8.36 8.5
##   deep       0   0 0    0   0   0    0   0
##   none       2   0 5    0   3   0    1   1
##   shallow    0   1 3    1   3   1    3   3
```

Low pH for shallow incorp plots probably causing wrong sign for shallow incorp pars.

# Correlation among predictor variables


```r
m1 <- aov(man.dm ~ app.mthd, data = pdat1)
summary(m1)
```

```
##              Df Sum Sq Mean Sq F value Pr(>F)    
## app.mthd      4   1498   374.4   84.66 <2e-16 ***
## Residuals   717   3171     4.4                   
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
TukeyHSD(m1)
```

```
##   Tukey multiple comparisons of means
##     95% family-wise confidence level
## 
## Fit: aov(formula = man.dm ~ app.mthd, data = pdat1)
## 
## $app.mthd
##               diff        lwr        upr     p adj
## bsth-bc -2.9898673 -3.5469594 -2.4327751 0.0000000
## ts-bc    0.1678965 -0.4253382  0.7611313 0.9380593
## os-bc    0.3990034 -0.2544186  1.0524254 0.4533213
## cs-bc   -2.7387859 -4.3799510 -1.0976208 0.0000579
## ts-bsth  3.1577638  2.5542049  3.7613227 0.0000000
## os-bsth  3.3888707  2.7260613  4.0516800 0.0000000
## cs-bsth  0.2510814 -1.3938438  1.8960066 0.9936401
## os-ts    0.2311069 -0.4623569  0.9245706 0.8925501
## cs-ts   -2.9066824 -4.5641970 -1.2491678 0.0000194
## cs-os   -3.1377893 -4.8177855 -1.4577930 0.0000041
```

```r
model.tables(m1, 'means')
```

```
## Tables of means
## Grand mean
##          
## 6.225756 
## 
##  app.mthd 
##         bc   bsth      ts      os     cs
##       7.02   4.03   7.188   7.419  4.282
## rep 222.00 205.00 163.000 119.000 13.000
```

# dfsumm


```r
dfsumm(pdat1)
```

```
## 
##  722 rows and 224 columns
##  722 unique rows
```

```
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
```

```
##                      inst     eid     pid    pmid sub.period corr.period
## Class              factor integer integer integer    integer     integer
## Minimum               101      44     182     182          1           3
## Maximum               305     686    3370    3380          3           3
## Mean                  209     406    2110    2110          2           3
## Unique (excld. NA)     14     228     720     722          3           1
## Missing values          0       0       0       0          0         489
## Sorted              FALSE    TRUE    TRUE    TRUE      FALSE        TRUE
##                                                                         
##                         proj     exper  exper2 institute   country
## Class              character character integer character character
## Minimum               1997sl         1       9   ADAS-RR        CA
## Maximum                Unter        Z2      23       WUR        UK
## Mean                    <NA>      <NA>    15.8      <NA>      <NA>
## Unique (excld. NA)       146       215      15        15         9
## Missing values            46         0     694         0         0
## Sorted                 FALSE     FALSE   FALSE     FALSE     FALSE
##                                                                   
##                                          submitter
## Class                                    character
## Minimum                      Ester Scotto di Perta
## Maximum            Pedersen, Johanna; Kamp, Jesper
## Mean                                          <NA>
## Unique (excld. NA)                               6
## Missing values                                 360
## Sorted                                       FALSE
##                                                   
##                                                                               file
## Class                                                                    character
## Minimum            ../../data-submitted/03/AU/ALFAM2_template_6_1_eGylle_JK_3.xlsx
## Maximum                                                     Bittman ALFAM2 v5.xlsx
## Mean                                                                          <NA>
## Unique (excld. NA)                                                              25
## Missing values                                                                   0
## Sorted                                                                       FALSE
##                                                                                   
##                    first.row.in.file.int last.row.in.file.int row.in.file.plot
## Class                            integer              integer          integer
## Minimum                                5                   10                5
## Maximum                             3620                 3960              281
## Mean                                 655                  684              111
## Unique (excld. NA)                   578                  590              253
## Missing values                         0                    0              360
## Sorted                             FALSE                FALSE            FALSE
##                                                                               
##                       pub.id
## Class              character
## Minimum                    1
## Maximum                  N/A
## Mean                    <NA>
## Unique (excld. NA)        10
## Missing values           403
## Sorted                 FALSE
##                             
##                                                                                                                                                                                                                                                                      pub.info
## Class                                                                                                                                                                                                                                                               character
## Minimum                                                     Bittman, S., van Vliet, L. J. P., Kowalenko, C. G., McGinn, S., Hunt, D. E., Bounaix, F., (2005) """"Surface-Banding Liquid Manure over Aeration Slots.""""  Agron. J.  7:1304–1313.  doi:10.2134/agronj2004.0277
## Maximum            Scotto di Perta, E., Fiorentino, N., Gioia, L., Cervelli, E., Faugno, S., & Pindozzi, S. (2019). Prolonged sampling time increases correlation between wind tunnel and integrated horizontal flux method. Agricultural and forest meteorology, 265, 48-55.
## Mean                                                                                                                                                                                                                                                                     <NA>
## Unique (excld. NA)                                                                                                                                                                                                                                                         21
## Missing values                                                                                                                                                                                                                                                            538
## Sorted                                                                                                                                                                                                                                                                  FALSE
##                                                                                                                                                                                                                                                                              
##                        lat    long                          topo     field
## Class              numeric numeric                     character character
## Minimum                 41    -122 Field flat, surrounding hilly         1
## Maximum               56.8    14.4                slightly hilly   Zegveld
## Mean                  51.8    1.56                          <NA>      <NA>
## Unique (excld. NA)      35      37                             5       286
## Missing values         360     360                           380        95
## Sorted               FALSE   FALSE                         FALSE     FALSE
##                                                                           
##                         plot plot.area     treat                     rep
## Class              character   numeric character               character
## Minimum                             47         0                       0
## Maximum                T3-B2     43200 untreated large neighbouring plot
## Mean                    <NA>      2640      <NA>                    <NA>
## Unique (excld. NA)       134       257       231                       8
## Missing values             9       174         0                     354
## Sorted                 FALSE     FALSE     FALSE                   FALSE
##                                                                         
##                       rep2  n.ints                  t.start.p
## Class              integer integer            POSIXct, POSIXt
## Minimum                  1       4        1990-06-12 13:30:00
## Maximum                  1    1310        2022-11-24 10:30:00
## Mean                     1    26.6 2008-10-29 23:38:59.842932
## Unique (excld. NA)       1      41                        325
## Missing values         694       0                        340
## Sorted                TRUE   FALSE                      FALSE
##                                                              
##                                       t.end.p     dt1  dt.min  dt.max  ct.min
## Class                         POSIXct, POSIXt numeric numeric numeric numeric
## Minimum                   1990-06-16 11:17:00    0.15    0.15    0.25    0.15
## Maximum                   2022-12-01 10:30:00      24      24     192      24
## Mean               2008-11-06 00:21:33.769634    1.61    1.58    40.5    1.61
## Unique (excld. NA)                        314     122     122     285     122
## Missing values                            340       0       0       0       0
## Sorted                                  FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                     ct.max meas.tech meas.tech2 meas.tech.orig meas.tech.det
## Class              numeric character  character      character     character
## Minimum                 24       agm  micro met            AGM 150 cm height
## Maximum                650     zinst  micro met      ZINST/bls     see notes
## Mean                   127      <NA>       <NA>           <NA>          <NA>
## Unique (excld. NA)     465        12          1             12             4
## Missing values           0         0          0              0           369
## Sorted               FALSE     FALSE       TRUE          FALSE         FALSE
##                                                                             
##                     j.NH31  j.rel1     e.1     e.4     e.6    e.12    e.24
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              -1.45 -0.0132   -1.45  -0.378  -0.402   -1.19  -0.087
## Maximum               41.2   0.572    30.3    86.6    99.5     107     110
## Mean                  2.91  0.0601     3.2    7.06    8.58    9.98    11.8
## Unique (excld. NA)     701     674     471     680     693     703     722
## Missing values           0       0     248      40      25      14       0
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                       e.48    e.72    e.96   e.168 e.final  e.cum.1 e.cum.4
## Class              numeric numeric numeric numeric numeric  numeric numeric
## Minimum             -0.169  0.0521   -1.11  0.0627   -12.2 -0.00918 -0.0474
## Maximum                117     121    99.9    37.6     125     30.3    86.6
## Mean                  13.9    15.3      15    13.9    15.8     4.02    9.02
## Unique (excld. NA)     655     586     411      16     720      273     348
## Missing values          66     136     309     706       0      448     374
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE    FALSE   FALSE
##                                                                            
##                    e.cum.6 e.cum.12 e.cum.24 e.cum.48 e.cum.72 e.cum.96
## Class              numeric  numeric  numeric  numeric  numeric  numeric
## Minimum            -0.0589   -0.141  0.00935    0.125    0.145    0.148
## Maximum               99.5      107      110      117      121     99.9
## Mean                  10.9     12.8     14.3     16.2     17.4     17.1
## Unique (excld. NA)     351      356      362      328      281      114
## Missing values         370      366      360      394      441      608
## Sorted               FALSE    FALSE    FALSE    FALSE    FALSE    FALSE
##                                                                        
##                    e.cum.168 e.cum.final e.rel.1  e.rel.4  e.rel.6 e.rel.12
## Class                numeric     numeric numeric  numeric  numeric  numeric
## Minimum               0.0627      -0.607 -0.0132 -0.00599 -0.00531  -0.0125
## Maximum                 37.6         125   0.437    0.841    0.894    0.913
## Mean                    13.9        17.5  0.0672    0.135    0.161    0.185
## Unique (excld. NA)        16         362     463      680      691      707
## Missing values           706         360     248       40       25       14
## Sorted                 FALSE       FALSE   FALSE    FALSE    FALSE    FALSE
##                                                                            
##                    e.rel.24 e.rel.48 e.rel.72 e.rel.96 e.rel.168 e.rel.final
## Class               numeric  numeric  numeric  numeric   numeric     numeric
## Minimum            -0.00222 -0.00184  0.00069  -0.0106   0.00267      -0.116
## Maximum                0.92    0.975    0.998    0.949     0.593           1
## Mean                  0.211    0.244    0.261    0.237     0.207       0.271
## Unique (excld. NA)      718      654      583      410        16         713
## Missing values            0       66      136      309       706           0
## Sorted                FALSE    FALSE    FALSE    FALSE     FALSE       FALSE
##                                                                             
##                       clay    silt    sand      oc       soil.type soil.type2
## Class              numeric numeric numeric numeric       character  character
## Minimum                2.4     2.4       7     0.9            clay       clay
## Maximum                 54    71.3    92.3    13.7 silty.clay.loam       sand
## Mean                  22.5    28.4    46.7    3.54            <NA>       <NA>
## Unique (excld. NA)      35      36      35      41              14          3
## Missing values         348     349     349     384              13        362
## Sorted               FALSE   FALSE   FALSE   FALSE           FALSE      FALSE
##                                                                              
##                    soil.water soil.water.v soil.moist soil.ph soil.dens
## Class                 numeric      numeric  character numeric   numeric
## Minimum                 0.005            9        dry       5       0.8
## Maximum                     1           67 wet frozen    8.21      1.55
## Mean                    0.306         28.7       <NA>    6.78      1.15
## Unique (excld. NA)         88           83          4      44        38
## Missing values            506          526        455     407       447
## Sorted                  FALSE        FALSE      FALSE   FALSE     FALSE
##                                                                        
##                     crop.res      till air.temp.1 air.temp.4 air.temp.6
## Class              character character    numeric    numeric    numeric
## Minimum                   No        no        2.4       2.22      -1.47
## Maximum                  Yes       Yes       28.7       32.6       32.6
## Mean                    <NA>      <NA>       14.8       15.9       14.9
## Unique (excld. NA)         2         4        179        331        550
## Missing values           386       247        448        374         25
## Sorted                 FALSE     FALSE      FALSE      FALSE      FALSE
##                                                                        
##                    air.temp.12 air.temp.24 air.temp.48 air.temp.72 air.temp.96
## Class                  numeric     numeric     numeric     numeric     numeric
## Minimum                  -1.27       -1.02      -0.758      -0.656       0.934
## Maximum                   31.9        28.9        28.2        28.2        28.2
## Mean                      15.1        13.2        12.9        12.8        13.9
## Unique (excld. NA)         580         627         636         645         352
## Missing values              14           0           0           0         360
## Sorted                   FALSE       FALSE       FALSE       FALSE       FALSE
##                                                                               
##                    air.temp.168 air.temp.mn air.temp.z soil.temp.1 soil.temp.4
## Class                   numeric     numeric    numeric     numeric     numeric
## Minimum                    1.08      -0.209        0.1           1           1
## Maximum                    28.2        49.6         10        16.9          17
## Mean                       13.9        13.3       1.67        6.63        6.64
## Unique (excld. NA)          351         636         10           4           4
## Missing values              360           2          0         716         716
## Sorted                    FALSE       FALSE      FALSE       FALSE       FALSE
##                                                                               
##                    soil.temp.6 soil.temp.12 soil.temp.24 soil.temp.48
## Class                  numeric      numeric      numeric      numeric
## Minimum                      1            1            1            1
## Maximum                     35         30.9         24.2         25.9
## Mean                      12.6         12.6         12.2           12
## Unique (excld. NA)         207          221          251          257
## Missing values             395          391          390          391
## Sorted                   FALSE        FALSE        FALSE        FALSE
##                                                                      
##                    soil.temp.72 soil.temp.96 soil.temp.168 soil.temp.mn
## Class                   numeric      numeric       numeric      numeric
## Minimum                       1            1             1        0.281
## Maximum                    24.3         16.6          16.6         24.5
## Mean                         12         6.39          6.37         12.3
## Unique (excld. NA)          268            4             4          260
## Missing values              391          716           716          393
## Sorted                    FALSE        FALSE         FALSE        FALSE
##                                                                        
##                    soil.temp.surf.1 soil.temp.surf.4 soil.temp.surf.6
## Class                       numeric          numeric          numeric
## Minimum                           1                1                1
## Maximum                        19.2             16.6             16.2
## Mean                           6.47             6.21             5.94
## Unique (excld. NA)                4                4                4
## Missing values                  716              716              716
## Sorted                        FALSE            FALSE            FALSE
##                                                                      
##                    soil.temp.surf.12 soil.temp.surf.24 soil.temp.surf.48
## Class                        numeric           numeric           numeric
## Minimum                            1                 1            -0.581
## Maximum                         16.5              15.2              15.3
## Mean                            5.72              5.46              5.12
## Unique (excld. NA)                 4                 4                 4
## Missing values                   716               716               716
## Sorted                         FALSE             FALSE             FALSE
##                                                                         
##                    soil.temp.surf.72 soil.temp.surf.96 soil.temp.surf.168
## Class                        numeric           numeric            numeric
## Minimum                      -0.0816             0.131              0.453
## Maximum                         15.8              16.1               15.6
## Mean                            5.28              5.47               5.53
## Unique (excld. NA)                 5                 5                  5
## Missing values                   716               716                716
## Sorted                         FALSE             FALSE              FALSE
##                                                                          
##                    soil.temp.surf.mn soil.temp.z   rad.1   rad.4   rad.6
## Class                        numeric   character numeric numeric numeric
## Minimum                        0.789           0       0       0       0
## Maximum                         21.1       FALSE     868    1380    1380
## Mean                             7.9        <NA>     363     657     563
## Unique (excld. NA)                 5           5     170     224     444
## Missing values                   716         388     505     488     205
## Sorted                         FALSE       FALSE   FALSE   FALSE   FALSE
##                                                                         
##                     rad.12  rad.24  rad.48  rad.72  rad.96 rad.168  rad.mn
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum                  0       0       0       0   0.354   0.339       0
## Maximum               1540    1500     991     971     991     991     991
## Mean                   562     371     293     298     439     453     323
## Unique (excld. NA)     460     475     476     477     241     241     474
## Missing values         195     188     188     188     474     474     190
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                     wind.1  wind.4  wind.6 wind.12 wind.24 wind.48 wind.72
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum             0.0612   0.198   0.223   0.363    0.52   0.511   0.511
## Maximum                  8    8.58      16      16     9.5      11      11
## Mean                  3.27    3.49     3.9    3.87    3.26    3.23    3.24
## Unique (excld. NA)     176     332     576     603     640     644     646
## Missing values         448     374      25      14       0       7      11
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                    wind.96 wind.168 wind.mn  wind.z wind.2m.1 wind.2m.4
## Class              numeric  numeric numeric numeric   numeric   numeric
## Minimum              0.826    0.923   0.511       1     0.065      0.21
## Maximum               6.62     6.62    19.9      10         8      8.58
## Mean                  2.91      2.9    3.36    2.92      3.28       3.5
## Unique (excld. NA)     353      354     642      21       176       332
## Missing values         360      360      13       0       448       374
## Sorted               FALSE    FALSE   FALSE   FALSE     FALSE     FALSE
##                                                                        
##                    wind.2m.6 wind.2m.12 wind.2m.24 wind.2m.48 wind.2m.72
## Class                numeric    numeric    numeric    numeric    numeric
## Minimum                0.237      0.385      0.586      0.588      0.588
## Maximum                 16.3       16.3       9.69       11.2       11.2
## Mean                    3.76       3.73       3.14       3.11       3.13
## Unique (excld. NA)       585        605        638        643        645
## Missing values            25         14          0          7         11
## Sorted                 FALSE      FALSE      FALSE      FALSE      FALSE
##                                                                         
##                    wind.2m.96 wind.2m.168 wind.2m.mn  wind.loc  rain.1  rain.4
## Class                 numeric     numeric    numeric character numeric numeric
## Minimum                 0.878       0.981      0.588                 0       0
## Maximum                  6.62        6.62       20.3      Plot     2.4     0.5
## Mean                     2.93        2.92       3.25      <NA>  0.0934 0.00144
## Unique (excld. NA)        354         355        643         5      10       2
## Missing values            360         360         13       385     251     374
## Sorted                  FALSE       FALSE      FALSE     FALSE   FALSE   FALSE
##                                                                               
##                     rain.6 rain.12 rain.24 rain.48 rain.72 rain.96 rain.168
## Class              numeric numeric numeric numeric numeric numeric  numeric
## Minimum                  0       0       0       0       0       0        0
## Maximum                  4     5.2    36.1    55.9    55.9    19.9     24.6
## Mean                 0.127    0.15   0.602    1.15     1.7    1.28     10.6
## Unique (excld. NA)      22      24      42      58      62      13       13
## Missing values          33      22       8      42      89     608      706
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE    FALSE
##                                                                            
##                    rain.tot rain.rate.1 rain.rate.4 rain.rate.6 rain.rate.12
## Class               numeric     numeric     numeric     numeric      numeric
## Minimum                   0           0           0           0            0
## Maximum                 113         2.4       0.125        1.19        0.706
## Mean                   4.68      0.0935    0.000359      0.0289        0.024
## Unique (excld. NA)       81          10           2          59           72
## Missing values           10         251         374          33           22
## Sorted                FALSE       FALSE       FALSE       FALSE        FALSE
##                                                                             
##                    rain.rate.24 rain.rate.48 rain.rate.72 rain.rate.96
## Class                   numeric      numeric      numeric      numeric
## Minimum                       0            0            0            0
## Maximum                    1.75         1.23        0.807        0.334
## Mean                      0.033       0.0298       0.0275      0.00482
## Unique (excld. NA)          110          159          185           12
## Missing values                8            8            8          360
## Sorted                    FALSE        FALSE        FALSE        FALSE
##                                                                       
##                    rain.rate.168 rain.rate.mn    rh.1    rh.4    rh.6   rh.12
## Class                    numeric      numeric numeric numeric numeric numeric
## Minimum                        0            0       1       1       1       1
## Maximum                    0.203        0.778      84    91.3     100     100
## Mean                     0.00465       0.0314    54.1    57.4    68.8    69.7
## Unique (excld. NA)            18          254       5      10     152     163
## Missing values               360           10     712     707     467     463
## Sorted                     FALSE        FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                      rh.24   rh.48   rh.72   rh.96  rh.168   rh.mn   far.loc
## Class              numeric numeric numeric numeric numeric numeric character
## Minimum                  1       1       1       1       1       1         0
## Maximum               98.7    98.7    97.9    97.9    89.8     354     Field
## Mean                  75.6      77    76.9    69.4    68.4      85      <NA>
## Unique (excld. NA)     196     212     214      21      21     216        15
## Missing values         449     449     449     693     693     449       523
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE     FALSE
##                                                                             
##                    man.source man.source.orig          man.source.det   man.bed
## Class               character       character               character character
## Minimum                   cat    Breeding Pig                 buffalo      None
## Maximum                   pig    silage maize see """"experiments""""     Straw
## Mean                     <NA>            <NA>                    <NA>      <NA>
## Unique (excld. NA)          4               9                       5         3
## Missing values              0               0                     693       381
## Sorted                  FALSE           FALSE                   FALSE     FALSE
##                                                                                
##                      man.con      man.trt1  man.trt2  man.trt3 man.stor  man.dm
## Class              character     character character character  integer numeric
## Minimum               liquid Acidification                <NA>       40   0.772
## Maximum                solid          None      None      <NA>      182    13.8
## Mean                    <NA>          <NA>      <NA>      <NA>     89.6    6.23
## Unique (excld. NA)         3            10         4         0        8     276
## Missing values           348             0       349       722      622       0
## Sorted                 FALSE         FALSE     FALSE      <NA>    FALSE   FALSE
##                                                                                
##                     man.vs man.tkn man.tan man.vfa man.tic  man.ua  man.ph
## Class              numeric numeric numeric numeric numeric integer numeric
## Minimum               5.74    0.98    0.57    0.16    0.31       0     4.3
## Maximum               5.74    5.53     6.4    0.51    0.31       0     8.9
## Mean                  5.74    2.97    2.32   0.323    0.31       0    7.37
## Unique (excld. NA)       1     155     280       3       1       1      93
## Missing values         721     404       0     719     721     694      45
## Sorted                TRUE   FALSE   FALSE   FALSE    TRUE    TRUE   FALSE
##                                                                           
##                                      acid  date.start
## Class                             logical IDate, Date
## Minimum                             FALSE  1990-06-12
## Maximum                              TRUE  2022-11-24
## Mean               0.054016620498615 TRUE        <NA>
## Unique (excld. NA)                      2         117
## Missing values                          0         340
## Sorted                              FALSE       FALSE
##                                                      
##                                     app.start   app.start.orig
## Class                         POSIXct, POSIXt        character
## Minimum                   1990-06-12 13:30:00 01-06-1999 08:40
## Maximum                   2022-11-24 11:42:00  5/01/2022 14:23
## Mean               2010-02-12 00:14:37.188498             <NA>
## Unique (excld. NA)                        256              256
## Missing values                            409              409
## Sorted                                  FALSE            FALSE
##                                                               
##                                app.end     app.end.orig app.method
## Class                  POSIXct, POSIXt        character  character
## Minimum            2013-06-19 13:30:00 02-08-2017 10:50         bc
## Maximum            2022-11-24 11:43:00  5/01/2022 14:23         ts
## Mean               2018-06-11 07:37:30             <NA>       <NA>
## Unique (excld. NA)                  27               27          5
## Missing values                     692              692          0
## Sorted                           FALSE            FALSE      FALSE
##                                                                   
##                                 app.method.orig app.rate tan.app    incorp
## Class                                 character  numeric numeric character
## Minimum            Band spread or trailing hose      6.6    10.9      deep
## Maximum                           Trailing shoe      133     235   shallow
## Mean                                       <NA>     30.4    64.1      <NA>
## Unique (excld. NA)                            9      407     571         3
## Missing values                                0        0       0         0
## Sorted                                    FALSE    FALSE   FALSE     FALSE
##                                                                           
##                    incorp.orig time.incorp man.area dist.inj  furrow.z
## Class                character     numeric  numeric  integer character
## Minimum                   Deep           0        1       22          
## Maximum                Shallow          48      100       30         8
## Mean                      <NA>        2.59     52.3     29.6      <NA>
## Unique (excld. NA)           6          12       12        2        15
## Missing values               0         633      573      702       681
## Sorted                   FALSE       FALSE    FALSE    FALSE     FALSE
##                                                                       
##                     furrow.w      crop    crop.orig  crop.z crop.area     lai
## Class              character character    character numeric   integer numeric
## Minimum                      bare soil    Bare soil       0         0       0
## Maximum                    3     wheat Winter Wheat      65       100     1.2
## Mean                    <NA>      <NA>         <NA>      11      69.7   0.433
## Unique (excld. NA)         5         9           16     121         8       3
## Missing values           695         0            0     131       633     719
## Sorted                 FALSE     FALSE        FALSE   FALSE     FALSE   FALSE
##                                                                              
##                                                                                        notes.plot
## Class                                                                                   character
## Minimum                                                                                          
## Maximum            NA  Incorporation (incorp/incorp.orig) not entered and was assumed to be none.
## Mean                                                                                         <NA>
## Unique (excld. NA)                                                                             21
## Missing values                                                                                350
## Sorted                                                                                      FALSE
##                                                                                                  
##                    flag.plot app.mthd               digested man.ph.missing
## Class              character   factor                logical        logical
## Minimum                            bc                  FALSE          FALSE
## Maximum                  m i       cs                   TRUE          FALSE
## Mean                    <NA>     bsth 0.056786703601108 TRUE         0 TRUE
## Unique (excld. NA)         4        5                      2              1
## Missing values             0        0                      0              0
## Sorted                 FALSE    FALSE                  FALSE           TRUE
##                                                                            
##                           iexper
## Class                  character
## Minimum                    104 1
## Maximum            305 3-BLD_IHF
## Mean                        <NA>
## Unique (excld. NA)           221
## Missing values                 0
## Sorted                     FALSE
## 
```

```r
dfsumm(pdat2)
```

```
## 
##  606 rows and 224 columns
##  606 unique rows
```

```
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
## Warning in as.character.POSIXt(c(min(yc), max(yc), mean(yc)), format =
## "%Y-%m-%d %H:%M:%S"): as.character(td, ..) no longer obeys a 'format' argument;
## use format(td, ..) ?
```

```
##                      inst     eid     pid    pmid sub.period corr.period
## Class              factor integer integer integer    integer     integer
## Minimum               101      44     182     182          1           3
## Maximum               305     686    3370    3380          3           3
## Mean                  209     398    2060    2060       1.96           3
## Unique (excld. NA)     14     204     605     606          3           1
## Missing values          0       0       0       0          0         423
## Sorted              FALSE    TRUE    TRUE    TRUE      FALSE        TRUE
##                                                                         
##                         proj     exper  exper2 institute   country
## Class              character character integer character character
## Minimum               1997sl         1       9   ADAS-RR        CA
## Maximum                Unter        Z2      23       WUR        UK
## Mean                    <NA>      <NA>    15.8      <NA>      <NA>
## Unique (excld. NA)       128       192      15        15         9
## Missing values            46         0     578         0         0
## Sorted                 FALSE     FALSE   FALSE     FALSE     FALSE
##                                                                   
##                                          submitter
## Class                                    character
## Minimum                      Ester Scotto di Perta
## Maximum            Pedersen, Johanna; Kamp, Jesper
## Mean                                          <NA>
## Unique (excld. NA)                               6
## Missing values                                 318
## Sorted                                       FALSE
##                                                   
##                                                                               file
## Class                                                                    character
## Minimum            ../../data-submitted/03/AU/ALFAM2_template_6_1_eGylle_JK_3.xlsx
## Maximum                                                     Bittman ALFAM2 v5.xlsx
## Mean                                                                          <NA>
## Unique (excld. NA)                                                              22
## Missing values                                                                   0
## Sorted                                                                       FALSE
##                                                                                   
##                    first.row.in.file.int last.row.in.file.int row.in.file.plot
## Class                            integer              integer          integer
## Minimum                                5                   10                5
## Maximum                             3620                 3960              281
## Mean                                 693                  716              122
## Unique (excld. NA)                   504                  517              244
## Missing values                         0                    0              318
## Sorted                             FALSE                FALSE            FALSE
##                                                                               
##                       pub.id
## Class              character
## Minimum                    1
## Maximum                  N/A
## Mean                    <NA>
## Unique (excld. NA)        10
## Missing values           331
## Sorted                 FALSE
##                             
##                                                                                                                                                                                                                                                                      pub.info
## Class                                                                                                                                                                                                                                                               character
## Minimum                                                     Bittman, S., van Vliet, L. J. P., Kowalenko, C. G., McGinn, S., Hunt, D. E., Bounaix, F., (2005) """"Surface-Banding Liquid Manure over Aeration Slots.""""  Agron. J.  7:1304–1313.  doi:10.2134/agronj2004.0277
## Maximum            Scotto di Perta, E., Fiorentino, N., Gioia, L., Cervelli, E., Faugno, S., & Pindozzi, S. (2019). Prolonged sampling time increases correlation between wind tunnel and integrated horizontal flux method. Agricultural and forest meteorology, 265, 48-55.
## Mean                                                                                                                                                                                                                                                                     <NA>
## Unique (excld. NA)                                                                                                                                                                                                                                                         16
## Missing values                                                                                                                                                                                                                                                            464
## Sorted                                                                                                                                                                                                                                                                  FALSE
##                                                                                                                                                                                                                                                                              
##                        lat    long                          topo     field
## Class              numeric numeric                     character character
## Minimum                 41    -122 Field flat, surrounding hilly         1
## Maximum               56.8    14.4                slightly hilly   Zegveld
## Mean                  51.8   0.707                          <NA>      <NA>
## Unique (excld. NA)      31      32                             5       238
## Missing values         291     291                           300        95
## Sorted               FALSE   FALSE                         FALSE     FALSE
##                                                                           
##                         plot plot.area     treat                     rep
## Class              character   numeric character               character
## Minimum                             47         0                       0
## Maximum                T2-B2     43200 untreated large neighbouring plot
## Mean                    <NA>      2090      <NA>                    <NA>
## Unique (excld. NA)       129       228       212                       8
## Missing values             4       130         0                     281
## Sorted                 FALSE     FALSE     FALSE                   FALSE
##                                                                         
##                       rep2  n.ints                  t.start.p
## Class              integer integer            POSIXct, POSIXt
## Minimum                  1       5        1990-06-12 13:30:00
## Maximum                  1    1310        2022-11-24 10:30:00
## Mean                     1    20.8 2008-11-27 23:03:06.447761
## Unique (excld. NA)       1      31                        303
## Missing values         578       0                        271
## Sorted                TRUE   FALSE                      FALSE
##                                                              
##                                       t.end.p     dt1  dt.min  dt.max  ct.min
## Class                         POSIXct, POSIXt numeric numeric numeric numeric
## Minimum                   1990-06-16 11:17:00    0.15    0.15    0.25    0.15
## Maximum                   2022-12-01 10:30:00      24      24     192      24
## Mean               2008-12-04 22:11:05.910448    1.73     1.7    41.8    1.73
## Unique (excld. NA)                        291     114     115     264     114
## Missing values                            271       0       0       0       0
## Sorted                                  FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                     ct.max meas.tech meas.tech2 meas.tech.orig meas.tech.det
## Class              numeric character  character      character     character
## Minimum                 24       agm  micro met            AGM 150 cm height
## Maximum                650     zinst  micro met      ZINST/bls     see notes
## Mean                   127      <NA>       <NA>           <NA>          <NA>
## Unique (excld. NA)     411         8          1              9             3
## Missing values           0         0          0              0           327
## Sorted               FALSE     FALSE       TRUE          FALSE         FALSE
##                                                                             
##                     j.NH31  j.rel1     e.1     e.4     e.6    e.12    e.24
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              -1.45 -0.0132   -1.45  -0.378  -0.281 -0.0127 0.00935
## Maximum               41.2   0.572    30.3    54.2    58.8    61.6    81.1
## Mean                  2.75  0.0646    2.97    6.63    8.08    9.36      11
## Unique (excld. NA)     591     573     387     571     582     588     606
## Missing values           0       0     217      35      21      14       0
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                       e.48    e.72    e.96   e.168 e.final  e.cum.1  e.cum.4
## Class              numeric numeric numeric numeric numeric  numeric  numeric
## Minimum              0.125   0.177   -1.11  0.0627   -12.2 -0.00214 -0.00248
## Maximum               90.1     117     128    37.6     166     30.3     54.2
## Mean                  13.1    14.4    15.3    13.9    14.9     3.55     7.92
## Unique (excld. NA)     546     486     353      16     605      214      276
## Missing values          60     120     251     590       0      392      330
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE    FALSE    FALSE
##                                                                             
##                     e.cum.6 e.cum.12 e.cum.24 e.cum.48 e.cum.72 e.cum.96
## Class               numeric  numeric  numeric  numeric  numeric  numeric
## Minimum            -0.00484  -0.0127  0.00935    0.125    0.177    0.148
## Maximum                58.8     60.3     61.8     67.6     65.1     66.6
## Mean                    9.6     11.1     12.1     13.6     14.4       15
## Unique (excld. NA)      279      282      288      260      222       95
## Missing values          326      324      318      346      384      511
## Sorted                FALSE    FALSE    FALSE    FALSE    FALSE    FALSE
##                                                                         
##                    e.cum.168 e.cum.final e.rel.1  e.rel.4  e.rel.6  e.rel.12
## Class                numeric     numeric numeric  numeric  numeric   numeric
## Minimum               0.0627      -0.607 -0.0132 -0.00452 -0.00336 -0.000421
## Maximum                 37.6        69.1   0.437    0.841    0.894     0.913
## Mean                    13.9        14.5  0.0731    0.143     0.17     0.193
## Unique (excld. NA)        16         288     381      570      580       592
## Missing values           590         318     217       35       21        14
## Sorted                 FALSE       FALSE   FALSE    FALSE    FALSE     FALSE
##                                                                             
##                    e.rel.24 e.rel.48 e.rel.72 e.rel.96 e.rel.168 e.rel.final
## Class               numeric  numeric  numeric  numeric   numeric     numeric
## Minimum            0.000137  0.00186  0.00332  -0.0106   0.00267      -0.116
## Maximum                0.92    0.975     1.11     1.23     0.593        1.59
## Mean                   0.22    0.254    0.272    0.246     0.207        0.28
## Unique (excld. NA)      602      546      484      352        16         601
## Missing values            0       60      120      251       590           0
## Sorted                FALSE    FALSE    FALSE    FALSE     FALSE       FALSE
##                                                                             
##                       clay    silt    sand      oc       soil.type soil.type2
## Class              numeric numeric numeric numeric       character  character
## Minimum                2.4     2.4       7     0.9            clay       clay
## Maximum                 54    71.3    92.3    13.7 silty.clay.loam       sand
## Mean                    24    28.6    45.4     3.4            <NA>       <NA>
## Unique (excld. NA)      32      31      30      37              13          3
## Missing values         274     275     275     315              10        288
## Sorted               FALSE   FALSE   FALSE   FALSE           FALSE      FALSE
##                                                                              
##                    soil.water soil.water.v soil.moist soil.ph soil.dens
## Class                 numeric      numeric  character numeric   numeric
## Minimum                 0.005         13.1        dry       5       0.8
## Maximum                     1           67 wet frozen    8.21      1.55
## Mean                    0.316         32.2       <NA>    6.83      1.14
## Unique (excld. NA)         81           70          4      40        34
## Missing values            400          456        375     336       347
## Sorted                  FALSE        FALSE      FALSE   FALSE     FALSE
##                                                                        
##                     crop.res      till air.temp.1 air.temp.4 air.temp.6
## Class              character character    numeric    numeric    numeric
## Minimum                   No        no        2.4       2.22      -1.47
## Maximum                  Yes       Yes       28.7       32.6       32.6
## Mean                    <NA>      <NA>         15         16       14.8
## Unique (excld. NA)         2         4        147        266        468
## Missing values           312       239        392        330         21
## Sorted                 FALSE     FALSE      FALSE      FALSE      FALSE
##                                                                        
##                    air.temp.12 air.temp.24 air.temp.48 air.temp.72 air.temp.96
## Class                  numeric     numeric     numeric     numeric     numeric
## Minimum                  -1.27       -1.02      -0.758      -0.656       0.934
## Maximum                   31.9        28.9        28.2        28.2        28.2
## Mean                      15.1        13.1        12.8        12.8        13.9
## Unique (excld. NA)         488         534         544         553         283
## Missing values              14           0           0           0         318
## Sorted                   FALSE       FALSE       FALSE       FALSE       FALSE
##                                                                               
##                    air.temp.168 air.temp.mn air.temp.z soil.temp.1 soil.temp.4
## Class                   numeric     numeric    numeric     numeric     numeric
## Minimum                    1.08      -0.209        0.1           1           1
## Maximum                    28.2        49.6         10        16.9          17
## Mean                         14        13.4       1.67        6.63        6.64
## Unique (excld. NA)          281         544          9           4           4
## Missing values              318           2          0         600         600
## Sorted                    FALSE       FALSE      FALSE       FALSE       FALSE
##                                                                               
##                    soil.temp.6 soil.temp.12 soil.temp.24 soil.temp.48
## Class                  numeric      numeric      numeric      numeric
## Minimum                      1            1            1            1
## Maximum                   24.1         23.7           22         21.6
## Mean                      12.8         12.9         12.4         12.2
## Unique (excld. NA)         192          203          233          240
## Missing values             312          308          307          307
## Sorted                   FALSE        FALSE        FALSE        FALSE
##                                                                      
##                    soil.temp.72 soil.temp.96 soil.temp.168 soil.temp.mn
## Class                   numeric      numeric       numeric      numeric
## Minimum                       1            1             1        0.281
## Maximum                    21.3         16.6          16.6         22.6
## Mean                       12.2         6.39          6.37         12.4
## Unique (excld. NA)          251            4             4          243
## Missing values              307          600           600          309
## Sorted                    FALSE        FALSE         FALSE        FALSE
##                                                                        
##                    soil.temp.surf.1 soil.temp.surf.4 soil.temp.surf.6
## Class                       numeric          numeric          numeric
## Minimum                           1                1                1
## Maximum                        19.2             16.6             16.2
## Mean                           6.47             6.21             5.94
## Unique (excld. NA)                4                4                4
## Missing values                  600              600              600
## Sorted                        FALSE            FALSE            FALSE
##                                                                      
##                    soil.temp.surf.12 soil.temp.surf.24 soil.temp.surf.48
## Class                        numeric           numeric           numeric
## Minimum                            1                 1            -0.581
## Maximum                         16.5              15.2              15.3
## Mean                            5.72              5.46              5.12
## Unique (excld. NA)                 4                 4                 4
## Missing values                   600               600               600
## Sorted                         FALSE             FALSE             FALSE
##                                                                         
##                    soil.temp.surf.72 soil.temp.surf.96 soil.temp.surf.168
## Class                        numeric           numeric            numeric
## Minimum                      -0.0816             0.131              0.453
## Maximum                         15.8              16.1               15.6
## Mean                            5.28              5.47               5.53
## Unique (excld. NA)                 5                 5                  5
## Missing values                   600               600                600
## Sorted                         FALSE             FALSE              FALSE
##                                                                          
##                    soil.temp.surf.mn soil.temp.z   rad.1   rad.4   rad.6
## Class                        numeric   character numeric numeric numeric
## Minimum                        0.789           0       0       0       0
## Maximum                         21.1       FALSE     868    1380    1380
## Mean                             7.9        <NA>     403     706     579
## Unique (excld. NA)                 5           5     132     178     379
## Missing values                   600         305     438     421     178
## Sorted                         FALSE       FALSE   FALSE   FALSE   FALSE
##                                                                         
##                     rad.12  rad.24  rad.48  rad.72  rad.96 rad.168  rad.mn
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum                  0       0       0       0   0.354   0.339       0
## Maximum               1540    1500     991     971     991     991     991
## Mean                   578     377     297     301     464     481     332
## Unique (excld. NA)     391     404     404     406     193     193     402
## Missing values         172     165     165     165     409     409     167
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                     wind.1  wind.4  wind.6 wind.12 wind.24 wind.48 wind.72
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              0.132   0.279   0.297    0.53    0.52   0.511   0.511
## Maximum               7.57    7.63      16      16     9.5      11      11
## Mean                  3.14    3.38     3.9    3.85    3.23    3.23    3.25
## Unique (excld. NA)     152     267     489     511     544     550     549
## Missing values         392     330      21      14       0       7      11
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                    wind.96 wind.168 wind.mn  wind.z wind.2m.1 wind.2m.4
## Class              numeric  numeric numeric numeric   numeric   numeric
## Minimum              0.985     1.11   0.511       1     0.141     0.299
## Maximum               6.62     6.62    19.9      10      7.57      7.63
## Mean                  2.87     2.87     3.4    2.72      3.15      3.39
## Unique (excld. NA)     281      282     547      20       152       267
## Missing values         318      318      13       0       392       330
## Sorted               FALSE    FALSE   FALSE   FALSE     FALSE     FALSE
##                                                                        
##                    wind.2m.6 wind.2m.12 wind.2m.24 wind.2m.48 wind.2m.72
## Class                numeric    numeric    numeric    numeric    numeric
## Minimum                0.318      0.567      0.586      0.588      0.588
## Maximum                 16.3       16.3       9.69       11.2       11.2
## Mean                    3.78       3.75       3.13       3.14       3.16
## Unique (excld. NA)       497        512        544        550        550
## Missing values            21         14          0          7         11
## Sorted                 FALSE      FALSE      FALSE      FALSE      FALSE
##                                                                         
##                    wind.2m.96 wind.2m.168 wind.2m.mn  wind.loc  rain.1  rain.4
## Class                 numeric     numeric    numeric character numeric numeric
## Minimum                  1.05        1.11      0.588                 0       0
## Maximum                  6.62        6.62       20.3      Plot     2.4     0.5
## Mean                     2.89        2.88       3.31      <NA>   0.113 0.00181
## Unique (excld. NA)        282         283        548         5      10       2
## Missing values            318         318         13       311     220     330
## Sorted                  FALSE       FALSE      FALSE     FALSE   FALSE   FALSE
##                                                                               
##                     rain.6 rain.12 rain.24 rain.48 rain.72 rain.96 rain.168
## Class              numeric numeric numeric numeric numeric numeric  numeric
## Minimum                  0       0       0       0       0       0        0
## Maximum                  4     5.2    36.1    55.9    55.9    15.4     24.6
## Mean                 0.144   0.173   0.647    1.23    1.69    1.31     10.6
## Unique (excld. NA)      22      24      42      57      59      11       13
## Missing values          29      22       8      36      74     511      590
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE    FALSE
##                                                                            
##                    rain.tot rain.rate.1 rain.rate.4 rain.rate.6 rain.rate.12
## Class               numeric     numeric     numeric     numeric      numeric
## Minimum                   0           0           0           0            0
## Maximum                 113         2.4       0.125        1.19        0.706
## Mean                   5.08       0.113    0.000453      0.0331       0.0274
## Unique (excld. NA)       75          10           2          57           69
## Missing values           10         220         330          29           22
## Sorted                FALSE       FALSE       FALSE       FALSE        FALSE
##                                                                             
##                    rain.rate.24 rain.rate.48 rain.rate.72 rain.rate.96
## Class                   numeric      numeric      numeric      numeric
## Minimum                       0            0            0            0
## Maximum                    1.63         1.19         0.79        0.334
## Mean                      0.035       0.0325       0.0287      0.00531
## Unique (excld. NA)          103          149          172           11
## Missing values                8            8            8          318
## Sorted                    FALSE        FALSE        FALSE        FALSE
##                                                                       
##                    rain.rate.168 rain.rate.mn    rh.1    rh.4    rh.6   rh.12
## Class                    numeric      numeric numeric numeric numeric numeric
## Minimum                        0            0       1       1       1       1
## Maximum                    0.146        0.778      84    91.3     100     100
## Mean                     0.00478       0.0337    43.7    51.3    69.9    70.7
## Unique (excld. NA)            16          232       5      10     135     142
## Missing values               318           10     599     594     391     389
## Sorted                     FALSE        FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                      rh.24   rh.48   rh.72   rh.96  rh.168   rh.mn   far.loc
## Class              numeric numeric numeric numeric numeric numeric character
## Minimum                  1       1       1       1       1       1         0
## Maximum               98.7    98.7    97.9    97.9    89.8     354     Field
## Mean                  76.5    77.7    77.6    69.5    68.2    86.6      <NA>
## Unique (excld. NA)     175     191     194      19      19     195        15
## Missing values         375     375     375     582     582     375       428
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE     FALSE
##                                                                             
##                    man.source man.source.orig          man.source.det   man.bed
## Class               character       character               character character
## Minimum                   cat    Breeding Pig                 buffalo      None
## Maximum                   pig    silage maize see """"experiments""""     Straw
## Mean                     <NA>            <NA>                    <NA>      <NA>
## Unique (excld. NA)          4               9                       5         3
## Missing values              0               0                     582       301
## Sorted                  FALSE           FALSE                   FALSE     FALSE
##                                                                                
##                      man.con            man.trt1  man.trt2  man.trt3 man.stor
## Class              character           character character character  integer
## Minimum               liquid anaerobic digestion                <NA>       40
## Maximum                solid                None      None      <NA>      182
## Mean                    <NA>                <NA>      <NA>      <NA>     90.3
## Unique (excld. NA)         3                   6         4         0        8
## Missing values           274                   0       277       606      539
## Sorted                 FALSE               FALSE     FALSE      <NA>    FALSE
##                                                                              
##                     man.dm  man.vs man.tkn man.tan man.vfa man.tic  man.ua
## Class              numeric numeric numeric numeric numeric numeric integer
## Minimum              0.772    5.74    0.98    0.57    0.16    0.31       0
## Maximum               13.8    5.74    5.53     6.4    0.51    0.31       0
## Mean                  6.02    5.74    2.97    2.11   0.323    0.31       0
## Unique (excld. NA)     257       1     149     266       3       1       1
## Missing values           0     605     304       0     603     605     578
## Sorted               FALSE    TRUE   FALSE   FALSE   FALSE    TRUE    TRUE
##                                                                           
##                     man.ph    acid  date.start                  app.start
## Class              numeric logical IDate, Date            POSIXct, POSIXt
## Minimum               6.54   FALSE  1990-06-12        1990-06-12 13:30:00
## Maximum                8.9   FALSE  2022-11-24        2022-11-24 11:42:00
## Mean                  7.43  0 TRUE        <NA> 2010-06-11 12:59:37.218045
## Unique (excld. NA)      81       1         109                        236
## Missing values           0       0         271                        340
## Sorted               FALSE    TRUE       FALSE                      FALSE
##                                                                          
##                      app.start.orig               app.end     app.end.orig
## Class                     character       POSIXct, POSIXt        character
## Minimum            01-06-1999 08:40   2013-06-19 16:05:00 09/11/2021 10:20
## Maximum             5/01/2022 14:23   2022-11-24 11:43:00  5/01/2022 14:23
## Mean                           <NA> 2019-01-23 22:54:33.6             <NA>
## Unique (excld. NA)              236                    24               24
## Missing values                  340                   581              581
## Sorted                        FALSE                 FALSE            FALSE
##                                                                           
##                    app.method              app.method.orig app.rate tan.app
## Class               character                    character  numeric numeric
## Minimum                    bc Band spread or trailing hose      6.6    10.9
## Maximum                    ts                Trailing shoe      133     196
## Mean                     <NA>                         <NA>     30.2    58.6
## Unique (excld. NA)          5                            8      358     484
## Missing values              0                            0        0       0
## Sorted                  FALSE                        FALSE    FALSE   FALSE
##                                                                            
##                       incorp incorp.orig time.incorp man.area dist.inj
## Class              character   character     numeric  numeric  integer
## Minimum                 none        none           0        1       22
## Maximum                 none        None           0      100       30
## Mean                    <NA>        <NA>           0     52.6     29.6
## Unique (excld. NA)         1           2           1       12        2
## Missing values             0           0         578      495      585
## Sorted                  TRUE       FALSE        TRUE    FALSE    FALSE
##                                                                       
##                     furrow.z  furrow.w      crop    crop.orig  crop.z crop.area
## Class              character character character    character numeric   integer
## Minimum                                bare soil    Bare soil       0         0
## Maximum                  6.9         3     wheat Winter Wheat      65       100
## Mean                    <NA>      <NA>      <NA>         <NA>    11.4      74.6
## Unique (excld. NA)        13         5         9           16     119         7
## Missing values           570       578         0            0     116       555
## Sorted                 FALSE     FALSE     FALSE        FALSE   FALSE     FALSE
##                                                                                
##                        lai
## Class              numeric
## Minimum                0.1
## Maximum                1.2
## Mean                  0.65
## Unique (excld. NA)       2
## Missing values         604
## Sorted                TRUE
##                           
##                                                                                        notes.plot
## Class                                                                                   character
## Minimum                                                                                          
## Maximum            NA  Incorporation (incorp/incorp.orig) not entered and was assumed to be none.
## Mean                                                                                         <NA>
## Unique (excld. NA)                                                                             16
## Missing values                                                                                281
## Sorted                                                                                      FALSE
##                                                                                                  
##                    flag.plot app.mthd                digested man.ph.missing
## Class              character   factor                 logical        logical
## Minimum                            bc                   FALSE          FALSE
## Maximum                  m i       cs                    TRUE          FALSE
## Mean                    <NA>     bsth 0.0561056105610561 TRUE         0 TRUE
## Unique (excld. NA)         3        5                       2              1
## Missing values             0        0                       0              0
## Sorted                 FALSE    FALSE                   FALSE           TRUE
##                                                                             
##                           iexper
## Class                  character
## Minimum                    104 1
## Maximum            305 3-BLD_IHF
## Mean                        <NA>
## Unique (excld. NA)           198
## Missing values                 0
## Sorted                     FALSE
## 
```

# Treatments


```r
pdat1[, man.trt.all := paste(man.trt1, man.trt2, man.trt3)]
table(pdat1[, man.trt.all])
```

```
## 
##                        Acidification None NA 
##                                            5 
##                              Acidified NA NA 
##                                            8 
##                      Anaerobic digestion  NA 
##                                            2 
## Anaerobic digestion Mechanical separation NA 
##                                            9 
##                    Anaerobic digestion NA NA 
##                                           10 
##                  anaerobic digestion none NA 
##                                            1 
##                  Anaerobic digestion none NA 
##                                           12 
##                  Anaerobic digestion None NA 
##                                            7 
##                       Barn acidification  NA 
##                                           12 
##                                Diluted NA NA 
##                                           23 
##                      Field acidification  NA 
##                                           14 
##                              Irrigated NA NA 
##                                            4 
##                     Low protein diet none NA 
##                                            9 
##                                     None  NA 
##                                           53 
##                                   None NA NA 
##                                          304 
##                                 None none NA 
##                                          243 
##                                 None None NA 
##                                            6
```


