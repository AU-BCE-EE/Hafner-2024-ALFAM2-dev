---
title: 'Subset summary'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "03 May, 2024 May:05"
---

# Summary of main data subset


```r
nrow(pdat1)
```

```
## [1] 734
```



```r
table(pdat1[, inst])
```

```
## 
## 101 102 103 104 105 106 107 108 201 202 203 204 205 206 207 208 209 210 211 212 
##   0   0   0  28   0   0   0   0   0 109   7  17  74   9  45  32   6   8   0  49 
## 213 214 301 302 303 304 
##   0 344   0   0   4   2
```

```r
table(pdat1[, country])
```

```
## 
##  CA  CH  DE  DK  FR  IE  IT  NL  UK 
##   7  45   9 118  32  49  12 353 109
```


```r
table(pdat1[, digested])
```

```
## 
## FALSE  TRUE 
##   693    41
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
##   WUR        344    0
```

```r
table(pdat1[, .(uptake, digested)])
```

```
## Error in eval(jsub, SDenv, parent.frame()): object 'uptake' not found
```

```r
table(pdat1[, .(uptake, acid)])
```

```
## Error in eval(jsub, SDenv, parent.frame()): object 'uptake' not found
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
##   WUR        336    8
```

```r
table(pdat1[, .(uptake, incorp)])
```

```
## Error in eval(jsub, SDenv, parent.frame()): object 'uptake' not found
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
## Error: j (the 2nd argument inside [...]) is a single symbol but column name 'rain.missing' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..rain.missing]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
100 * mean(idat1[, rain.missing])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': j (the 2nd argument inside [...]) is a single symbol but column name 'rain.missing' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..rain.missing]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
table(idat1[, interp.wind])
```

```
## Error: j (the 2nd argument inside [...]) is a single symbol but column name 'interp.wind' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..interp.wind]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
100 * mean(idat1[, interp.wind])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': j (the 2nd argument inside [...]) is a single symbol but column name 'interp.wind' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..interp.wind]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
table(idat1[, interp.air.temp])
```

```
## Error: j (the 2nd argument inside [...]) is a single symbol but column name 'interp.air.temp' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..interp.air.temp]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
100 * mean(idat1[, interp.air.temp])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': j (the 2nd argument inside [...]) is a single symbol but column name 'interp.air.temp' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..interp.air.temp]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
table(idat1[, man.ph.missing])
```

```
## Error: j (the 2nd argument inside [...]) is a single symbol but column name 'man.ph.missing' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..man.ph.missing]. The .. prefix conveys one-level-up similar to a file system path.
```

```r
100 * mean(idat1[, man.ph.missing])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': j (the 2nd argument inside [...]) is a single symbol but column name 'man.ph.missing' is not found. If you intended to select columns using a variable in calling scope, please try DT[, ..man.ph.missing]. The .. prefix conveys one-level-up similar to a file system path.
```


```r
xx <- idat1[, any(rain.missing), by = pmid]
```

```
## Error: object 'rain.missing' not found
```

```r
table(xx[, 2])
```

```
## Error in eval(expr, envir, enclos): object 'xx' not found
```

```r
100 * mean(xx[, 2])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': object 'xx' not found
```

```r
xx <- idat1[, any(interp.wind), by = pmid]
```

```
## Error: object 'interp.wind' not found
```

```r
table(xx[, 2])
```

```
## Error in eval(expr, envir, enclos): object 'xx' not found
```

```r
100 * mean(xx[, 2])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': object 'xx' not found
```

```r
xx <- idat1[, any(interp.air.temp), by = pmid]
```

```
## Error: object 'interp.air.temp' not found
```

```r
table(xx[, 2])
```

```
## Error in eval(expr, envir, enclos): object 'xx' not found
```

```r
100 * mean(xx[, 2])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': object 'xx' not found
```

```r
xx <- idat1[, any(man.ph.missing), by = pmid]
```

```
## Error: object 'man.ph.missing' not found
```

```r
table(xx[, 2])
```

```
## Error in eval(expr, envir, enclos): object 'xx' not found
```

```r
100 * mean(xx[, 2])
```

```
## Error in h(simpleError(msg, call)): error in evaluating the argument 'x' in selecting a method for function 'mean': object 'xx' not found
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

# Correlation among predictor variables


```r
m1 <- aov(man.dm ~ app.mthd, data = pdat1)
summary(m1)
```

```
##              Df Sum Sq Mean Sq F value Pr(>F)    
## app.mthd      4   1548   387.0   88.99 <2e-16 ***
## Residuals   729   3170     4.3                   
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
##                diff        lwr        upr     p adj
## bsth-bc -2.98986725 -3.5422332 -2.4375013 0.0000000
## ts-bc    0.09817867 -0.4859472  0.6823046 0.9908104
## os-bc    0.24692758 -0.3813356  0.8751908 0.8195064
## cs-bc   -4.81365766 -6.7526435 -2.8746718 0.0000000
## ts-bsth  3.08804592  2.4936132  3.6824786 0.0000000
## os-bsth  3.23679484  2.5989377  3.8746520 0.0000000
## cs-bsth -1.82379041 -3.7659061  0.1183252 0.0774425
## os-ts    0.14874891 -0.5168010  0.8142988 0.9733314
## cs-ts   -4.91183633 -6.8632225 -2.9604501 0.0000000
## cs-os   -5.06058524 -7.0256348 -3.0955357 0.0000000
```

```r
model.tables(m1, 'means')
```

```
## Tables of means
## Grand mean
##          
## 6.192664 
## 
##  app.mthd 
##         bc   bsth      ts      os    cs
##       7.02   4.03   7.119   7.267 2.207
## rep 222.00 205.00 167.000 131.000 9.000
```

# dfsumm


```r
dfsumm(pdat1)
```

```
## 
##  734 rows and 225 columns
##  734 unique rows
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
## Maximum               304     573    2860    2860          3           3
## Mean                  209     359    1920    1930       2.15           3
## Unique (excld. NA)     14     230     732     734          3           1
## Missing values          0       0       0       0          0         501
## Sorted              FALSE    TRUE    TRUE    TRUE      FALSE        TRUE
##                                                                         
##                         proj     exper  exper2 institute   country
## Class              character character integer character character
## Minimum               1997sl         1       9   ADAS-RR        CA
## Maximum                Unter        Z2      23       WUR        UK
## Mean                    <NA>      <NA>    15.8      <NA>      <NA>
## Unique (excld. NA)       148       217      15        15         9
## Missing values            46         0     706         0         0
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
## Mean                                 663                  692              112
## Unique (excld. NA)                   590                  602              258
## Missing values                         0                    0              360
## Sorted                             FALSE                FALSE            FALSE
##                                                                               
##                       pub.id
## Class              character
## Minimum                    1
## Maximum                  N/A
## Mean                    <NA>
## Unique (excld. NA)        10
## Missing values           415
## Sorted                 FALSE
##                             
##                                                                                                                                                                                                                                                                      pub.info
## Class                                                                                                                                                                                                                                                               character
## Minimum                                                     Bittman, S., van Vliet, L. J. P., Kowalenko, C. G., McGinn, S., Hunt, D. E., Bounaix, F., (2005) """"Surface-Banding Liquid Manure over Aeration Slots.""""  Agron. J.  7:1304–1313.  doi:10.2134/agronj2004.0277
## Maximum            Scotto di Perta, E., Fiorentino, N., Gioia, L., Cervelli, E., Faugno, S., & Pindozzi, S. (2019). Prolonged sampling time increases correlation between wind tunnel and integrated horizontal flux method. Agricultural and forest meteorology, 265, 48-55.
## Mean                                                                                                                                                                                                                                                                     <NA>
## Unique (excld. NA)                                                                                                                                                                                                                                                         21
## Missing values                                                                                                                                                                                                                                                            550
## Sorted                                                                                                                                                                                                                                                                  FALSE
##                                                                                                                                                                                                                                                                              
##                        lat    long                          topo     field
## Class              numeric numeric                     character character
## Minimum                 41    -122 Field flat, surrounding hilly         1
## Maximum               56.8    14.4                slightly hilly   Zegveld
## Mean                  51.8    1.56                          <NA>      <NA>
## Unique (excld. NA)      35      37                             5       286
## Missing values         372     372                           392        95
## Sorted               FALSE   FALSE                         FALSE     FALSE
##                                                                           
##                         plot plot.area     treat                     rep
## Class              character   numeric character               character
## Minimum                             47         0                       0
## Maximum                T3-B2     43200 untreated large neighbouring plot
## Mean                    <NA>      2610      <NA>                    <NA>
## Unique (excld. NA)       134       269       231                       8
## Missing values             9       174         0                     366
## Sorted                 FALSE     FALSE     FALSE                   FALSE
##                                                                         
##                       rep2  n.ints                  t.start.p
## Class              integer integer            POSIXct, POSIXt
## Minimum                  1       4        1990-06-12 13:30:00
## Maximum                  1    1310        2022-11-24 10:30:00
## Mean                     1    26.3 2008-10-29 23:38:59.842932
## Unique (excld. NA)       1      41                        325
## Missing values         706       0                        352
## Sorted                TRUE   FALSE                      FALSE
##                                                              
##                                       t.end.p     dt1  dt.min  dt.max  ct.min
## Class                         POSIXct, POSIXt numeric numeric numeric numeric
## Minimum                   1990-06-16 11:17:00    0.15    0.15    0.25    0.15
## Maximum                   2022-12-01 10:30:00      24      24     192      24
## Mean               2008-11-06 00:21:33.769634    1.61    1.57    40.3    1.61
## Unique (excld. NA)                        314     122     122     291     122
## Missing values                            352       0       0       0       0
## Sorted                                  FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                     ct.max meas.tech meas.tech2 meas.tech.orig meas.tech.det
## Class              numeric character  character      character     character
## Minimum                 24       agm  micro met            AGM 150 cm height
## Maximum                650     zinst  micro met      ZINST/bls     see notes
## Mean                   126      <NA>       <NA>           <NA>          <NA>
## Unique (excld. NA)     474        12          1             12             4
## Missing values           0         0          0              0           369
## Sorted               FALSE     FALSE       TRUE          FALSE         FALSE
##                                                                             
##                     j.NH31  j.rel1     e.1     e.4     e.6    e.12    e.24
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              -1.45 -0.0132   -1.45  -0.378  -0.402   -1.19  -0.087
## Maximum               41.2   0.572    30.3    86.6    99.5     107     110
## Mean                  2.87  0.0593    3.19    6.99    8.49    9.88    11.7
## Unique (excld. NA)     713     686     473     692     705     715     734
## Missing values           0       0     258      40      25      14       0
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                       e.48    e.72    e.96   e.168 e.final  e.cum.1 e.cum.4
## Class              numeric numeric numeric numeric numeric  numeric numeric
## Minimum             -0.169  0.0521   -1.11  0.0627   -12.2 -0.00918 -0.0474
## Maximum                117     121    99.9    37.6     125     30.3    86.6
## Mean                  13.8    15.2      15    13.9    15.7        4    8.81
## Unique (excld. NA)     663     594     411      16     732      275     360
## Missing values          70     140     321     718       0      458     374
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE    FALSE   FALSE
##                                                                            
##                    e.cum.6 e.cum.12 e.cum.24 e.cum.48 e.cum.72 e.cum.96
## Class              numeric  numeric  numeric  numeric  numeric  numeric
## Minimum            -0.0589   -0.141  0.00935    0.125    0.145    0.148
## Maximum               99.5      107      110      117      121     99.9
## Mean                  10.7     12.5       14     15.9     17.2     17.1
## Unique (excld. NA)     363      368      374      336      289      114
## Missing values         370      366      360      398      445      620
## Sorted               FALSE    FALSE    FALSE    FALSE    FALSE    FALSE
##                                                                        
##                    e.cum.168 e.cum.final e.rel.1  e.rel.4  e.rel.6 e.rel.12
## Class                numeric     numeric numeric  numeric  numeric  numeric
## Minimum               0.0627      -0.607 -0.0132 -0.00599 -0.00531  -0.0125
## Maximum                 37.6         125   0.437    0.841    0.894    0.913
## Mean                    13.9        17.1  0.0669    0.133    0.158    0.182
## Unique (excld. NA)        16         374     465      692      703      719
## Missing values           718         360     258       40       25       14
## Sorted                 FALSE       FALSE   FALSE    FALSE    FALSE    FALSE
##                                                                            
##                    e.rel.24 e.rel.48 e.rel.72 e.rel.96 e.rel.168 e.rel.final
## Class               numeric  numeric  numeric  numeric   numeric     numeric
## Minimum            -0.00222 -0.00184  0.00069  -0.0106   0.00267      -0.116
## Maximum                0.92    0.975    0.998    0.949     0.593           1
## Mean                  0.209    0.242    0.258    0.237     0.207       0.267
## Unique (excld. NA)      730      662      591      410        16         725
## Missing values            0       70      140      321       718           0
## Sorted                FALSE    FALSE    FALSE    FALSE     FALSE       FALSE
##                                                                             
##                       clay    silt    sand      oc       soil.type soil.type2
## Class              numeric numeric numeric numeric       character  character
## Minimum                2.4     2.4       7     0.9            clay       clay
## Maximum                 54    71.3    92.3    13.7 silty.clay.loam       sand
## Mean                  22.5    28.4    46.7    3.54            <NA>       <NA>
## Unique (excld. NA)      35      36      35      41              14          3
## Missing values         360     361     361     396              13        374
## Sorted               FALSE   FALSE   FALSE   FALSE           FALSE      FALSE
##                                                                              
##                    soil.water soil.water.v soil.moist soil.ph soil.dens
## Class                 numeric      numeric  character numeric   numeric
## Minimum                 0.005            9        dry       5       0.8
## Maximum                     1           67 wet frozen    8.21      1.55
## Mean                    0.306         28.6       <NA>    6.78      1.15
## Unique (excld. NA)         88           91          4      44        38
## Missing values            518          530        467     419       459
## Sorted                  FALSE        FALSE      FALSE   FALSE     FALSE
##                                                                        
##                     crop.res      till air.temp.1 air.temp.4 air.temp.6
## Class              character character    numeric    numeric    numeric
## Minimum                   No        no        2.4       2.22      -1.47
## Maximum                  Yes       Yes       28.7       32.6       32.6
## Mean                    <NA>      <NA>       14.8       15.8       14.9
## Unique (excld. NA)         2         4        181        343        562
## Missing values           398       251        458        374         25
## Sorted                 FALSE     FALSE      FALSE      FALSE      FALSE
##                                                                        
##                    air.temp.12 air.temp.24 air.temp.48 air.temp.72 air.temp.96
## Class                  numeric     numeric     numeric     numeric     numeric
## Minimum                  -1.27       -1.02      -0.758      -0.656       0.934
## Maximum                   31.9        28.9        28.2        28.2        28.2
## Mean                      15.1        13.1        12.8        12.8        13.8
## Unique (excld. NA)         592         638         648         657         364
## Missing values              14           0           0           0         360
## Sorted                   FALSE       FALSE       FALSE       FALSE       FALSE
##                                                                               
##                    air.temp.168 air.temp.mn air.temp.z soil.temp.1 soil.temp.4
## Class                   numeric     numeric    numeric     numeric     numeric
## Minimum                    1.08      -0.209        0.1           1           1
## Maximum                    28.2        49.6         10        16.9          17
## Mean                       13.9        13.3       1.67        6.63        6.64
## Unique (excld. NA)          363         647         10           4           4
## Missing values              360           2          0         728         728
## Sorted                    FALSE       FALSE      FALSE       FALSE       FALSE
##                                                                               
##                    soil.temp.6 soil.temp.12 soil.temp.24 soil.temp.48
## Class                  numeric      numeric      numeric      numeric
## Minimum                      1            1            1            1
## Maximum                     35         30.9         24.2         25.9
## Mean                      12.6         12.6         12.2           12
## Unique (excld. NA)         207          221          251          257
## Missing values             407          403          402          403
## Sorted                   FALSE        FALSE        FALSE        FALSE
##                                                                      
##                    soil.temp.72 soil.temp.96 soil.temp.168 soil.temp.mn
## Class                   numeric      numeric       numeric      numeric
## Minimum                       1            1             1        0.281
## Maximum                    24.3         16.6          16.6         24.5
## Mean                         12         6.39          6.37         12.3
## Unique (excld. NA)          268            4             4          260
## Missing values              403          728           728          405
## Sorted                    FALSE        FALSE         FALSE        FALSE
##                                                                        
##                    soil.temp.surf.1 soil.temp.surf.4 soil.temp.surf.6
## Class                       numeric          numeric          numeric
## Minimum                           1                1                1
## Maximum                        19.2             16.6             16.2
## Mean                           6.47             6.21             5.94
## Unique (excld. NA)                4                4                4
## Missing values                  728              728              728
## Sorted                        FALSE            FALSE            FALSE
##                                                                      
##                    soil.temp.surf.12 soil.temp.surf.24 soil.temp.surf.48
## Class                        numeric           numeric           numeric
## Minimum                            1                 1            -0.581
## Maximum                         16.5              15.2              15.3
## Mean                            5.72              5.46              5.12
## Unique (excld. NA)                 4                 4                 4
## Missing values                   728               728               728
## Sorted                         FALSE             FALSE             FALSE
##                                                                         
##                    soil.temp.surf.72 soil.temp.surf.96 soil.temp.surf.168
## Class                        numeric           numeric            numeric
## Minimum                      -0.0816             0.131              0.453
## Maximum                         15.8              16.1               15.6
## Mean                            5.28              5.47               5.53
## Unique (excld. NA)                 5                 5                  5
## Missing values                   728               728                728
## Sorted                         FALSE             FALSE              FALSE
##                                                                          
##                    soil.temp.surf.mn soil.temp.z   rad.1   rad.4   rad.6
## Class                        numeric   character numeric numeric numeric
## Minimum                        0.789           0       0       0       0
## Maximum                         21.1       FALSE     868    1380    1380
## Mean                             7.9        <NA>     363     657     563
## Unique (excld. NA)                 5           5     170     224     444
## Missing values                   728         400     517     500     217
## Sorted                         FALSE       FALSE   FALSE   FALSE   FALSE
##                                                                         
##                     rad.12  rad.24  rad.48  rad.72  rad.96 rad.168  rad.mn
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum                  0       0       0       0   0.354   0.339       0
## Maximum               1540    1500     991     971     991     991     991
## Mean                   562     371     293     298     439     453     323
## Unique (excld. NA)     460     475     476     477     241     241     474
## Missing values         207     200     200     200     486     486     202
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                     wind.1  wind.4  wind.6 wind.12 wind.24 wind.48 wind.72
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum             0.0612   0.198   0.223   0.363    0.52   0.511   0.511
## Maximum                  8    8.58      16      16     9.5      11      11
## Mean                  3.27    3.46    3.88    3.86    3.24    3.21    3.22
## Unique (excld. NA)     178     344     588     615     652     655     657
## Missing values         458     374      25      14       0       7      11
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                    wind.96 wind.168 wind.mn  wind.z wind.2m.1 wind.2m.4
## Class              numeric  numeric numeric numeric   numeric   numeric
## Minimum              0.826    0.923   0.511       1     0.065      0.21
## Maximum               6.62     6.62    19.9      10         8      8.58
## Mean                   2.9     2.89    3.34     2.9      3.27      3.47
## Unique (excld. NA)     365      366     654      21       178       344
## Missing values         360      360      13       0       458       374
## Sorted               FALSE    FALSE   FALSE   FALSE     FALSE     FALSE
##                                                                        
##                    wind.2m.6 wind.2m.12 wind.2m.24 wind.2m.48 wind.2m.72
## Class                numeric    numeric    numeric    numeric    numeric
## Minimum                0.237      0.385      0.586      0.588      0.588
## Maximum                 16.3       16.3       9.69       11.2       11.2
## Mean                    3.74       3.72       3.12        3.1       3.12
## Unique (excld. NA)       597        617        650        654        656
## Missing values            25         14          0          7         11
## Sorted                 FALSE      FALSE      FALSE      FALSE      FALSE
##                                                                         
##                    wind.2m.96 wind.2m.168 wind.2m.mn  wind.loc  rain.1  rain.4
## Class                 numeric     numeric    numeric character numeric numeric
## Minimum                 0.878       0.981      0.588                 0       0
## Maximum                  6.62        6.62       20.3      Plot     2.4     0.5
## Mean                     2.91         2.9       3.24      <NA>   0.093 0.00139
## Unique (excld. NA)        366         367        655         5      10       2
## Missing values            360         360         13       397     261     374
## Sorted                  FALSE       FALSE      FALSE     FALSE   FALSE   FALSE
##                                                                               
##                     rain.6 rain.12 rain.24 rain.48 rain.72 rain.96 rain.168
## Class              numeric numeric numeric numeric numeric numeric  numeric
## Minimum                  0       0       0       0       0       0        0
## Maximum                  4     5.2    36.1    55.9    55.9    19.9     24.6
## Mean                 0.125   0.148   0.592    1.13    1.68    1.28     10.6
## Unique (excld. NA)      22      24      42      58      62      13       13
## Missing values          33      22       8      46      93     620      718
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE    FALSE
##                                                                            
##                    rain.tot rain.rate.1 rain.rate.4 rain.rate.6 rain.rate.12
## Class               numeric     numeric     numeric     numeric      numeric
## Minimum                   0           0           0           0            0
## Maximum                 113         2.4       0.125        1.19        0.706
## Mean                    4.6      0.0931    0.000347      0.0284       0.0236
## Unique (excld. NA)       81          10           2          59           72
## Missing values           10         261         374          33           22
## Sorted                FALSE       FALSE       FALSE       FALSE        FALSE
##                                                                             
##                    rain.rate.24 rain.rate.48 rain.rate.72 rain.rate.96
## Class                   numeric      numeric      numeric      numeric
## Minimum                       0            0            0            0
## Maximum                    1.75         1.23        0.807        0.334
## Mean                     0.0325       0.0293        0.027      0.00466
## Unique (excld. NA)          110          159          185           12
## Missing values                8            8            8          360
## Sorted                    FALSE        FALSE        FALSE        FALSE
##                                                                       
##                    rain.rate.168 rain.rate.mn    rh.1    rh.4    rh.6   rh.12
## Class                    numeric      numeric numeric numeric numeric numeric
## Minimum                        0            0       1       1       1       1
## Maximum                    0.203        0.778      84    91.3     100     100
## Mean                      0.0045       0.0308    54.1    57.4    68.8    69.7
## Unique (excld. NA)            18          254       5      10     152     163
## Missing values               360           10     724     719     479     475
## Sorted                     FALSE        FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                      rh.24   rh.48   rh.72   rh.96  rh.168   rh.mn   far.loc
## Class              numeric numeric numeric numeric numeric numeric character
## Minimum                  1       1       1       1       1       1         0
## Maximum               98.7    98.7    97.9    97.9    89.8     354     Field
## Mean                  75.6      77    76.9    69.4    68.4      85      <NA>
## Unique (excld. NA)     196     212     214      21      21     216        15
## Missing values         461     461     461     705     705     461       535
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE     FALSE
##                                                                             
##                    man.source man.source.orig          man.source.det   man.bed
## Class               character       character               character character
## Minimum                   cat    Breeding Pig                 buffalo      None
## Maximum                   pig    silage maize see """"experiments""""     Straw
## Mean                     <NA>            <NA>                    <NA>      <NA>
## Unique (excld. NA)          6              10                       5         3
## Missing values              0               0                     705       393
## Sorted                  FALSE           FALSE                   FALSE     FALSE
##                                                                                
##                      man.con      man.trt1  man.trt2  man.trt3 man.stor  man.dm
## Class              character     character character character  integer numeric
## Minimum               liquid Acidification                <NA>       40   0.772
## Maximum                solid          None      None      <NA>      182    13.8
## Mean                    <NA>          <NA>      <NA>      <NA>     89.6    6.19
## Unique (excld. NA)         5            10         4         0        8     281
## Missing values           360             0       361       734      634       0
## Sorted                 FALSE         FALSE     FALSE      <NA>    FALSE   FALSE
##                                                                                
##                     man.vs man.tkn man.tan man.vfa man.tic  man.ua  man.ph
## Class              numeric numeric numeric numeric numeric integer numeric
## Minimum               5.74    0.98    0.57    0.16    0.31       0     4.3
## Maximum               5.74    5.53     8.1    0.51    0.31       0     8.9
## Mean                  5.74    2.97     2.4   0.323    0.31       0    7.38
## Unique (excld. NA)       1     155     284       3       1       1      93
## Missing values         733     416       0     731     733     706      45
## Sorted                TRUE   FALSE   FALSE   FALSE    TRUE    TRUE   FALSE
##                                                                           
##                                      acid  date.start
## Class                             logical IDate, Date
## Minimum                             FALSE  1990-06-12
## Maximum                              TRUE  2022-11-24
## Mean               0.053133514986376 TRUE        <NA>
## Unique (excld. NA)                      2         117
## Missing values                          0         352
## Sorted                              FALSE       FALSE
##                                                      
##                                     app.start   app.start.orig
## Class                         POSIXct, POSIXt        character
## Minimum                   1990-06-12 13:30:00 01-06-1999 08:40
## Maximum                   2022-11-24 11:42:00  5/01/2022 14:23
## Mean               2010-02-12 00:14:37.188498             <NA>
## Unique (excld. NA)                        256              256
## Missing values                            421              421
## Sorted                                  FALSE            FALSE
##                                                               
##                                app.end     app.end.orig app.method app.method2
## Class                  POSIXct, POSIXt        character  character   character
## Minimum            2013-06-19 13:30:00 02-08-2017 10:50         bc        band
## Maximum            2022-11-24 11:43:00  5/01/2022 14:23         ts          ts
## Mean               2018-06-11 07:37:30             <NA>       <NA>        <NA>
## Unique (excld. NA)                  27               27          5           6
## Missing values                     704              704          0           0
## Sorted                           FALSE            FALSE      FALSE       FALSE
##                                                                               
##                                 app.method.orig app.rate tan.app    incorp
## Class                                 character  numeric numeric character
## Minimum            Band spread or trailing hose      6.6    10.9      deep
## Maximum                           Trailing shoe      133     235   shallow
## Mean                                       <NA>     30.1    64.7      <NA>
## Unique (excld. NA)                            9      419     583         3
## Missing values                                0        0       0         0
## Sorted                                    FALSE    FALSE   FALSE     FALSE
##                                                                           
##                    incorp.orig time.incorp man.area dist.inj  furrow.z
## Class                character     numeric  numeric  integer character
## Minimum                   Deep           0        1       22          
## Maximum                Shallow          48      100       30         8
## Mean                      <NA>        2.59     52.3     29.6      <NA>
## Unique (excld. NA)           6          12       12        2        15
## Missing values               0         645      585      714       693
## Sorted                   FALSE       FALSE    FALSE    FALSE     FALSE
##                                                                       
##                     furrow.w      crop    crop.orig  crop.z crop.area     lai
## Class              character character    character numeric   integer numeric
## Minimum                      bare soil    Bare soil       0         0       0
## Maximum                    3     wheat Winter Wheat      65       100     1.2
## Mean                    <NA>      <NA>         <NA>      11      69.7   0.433
## Unique (excld. NA)         5         9           16     121         8       3
## Missing values           707         0            0     143       645     731
## Sorted                 FALSE     FALSE        FALSE   FALSE     FALSE   FALSE
##                                                                              
##                                                                                        notes.plot
## Class                                                                                   character
## Minimum                                                                                          
## Maximum            NA  Incorporation (incorp/incorp.orig) not entered and was assumed to be none.
## Mean                                                                                         <NA>
## Unique (excld. NA)                                                                             21
## Missing values                                                                                362
## Sorted                                                                                      FALSE
##                                                                                                  
##                    flag.plot app.mthd               digested man.ph.missing
## Class              character   factor                logical        logical
## Minimum                            bc                  FALSE          FALSE
## Maximum                  m i       cs                   TRUE          FALSE
## Mean                    <NA>     bsth 0.055858310626703 TRUE         0 TRUE
## Unique (excld. NA)         4        5                      2              1
## Missing values             0        0                      0              0
## Sorted                 FALSE    FALSE                  FALSE           TRUE
##                                                                            
##                           iexper
## Class                  character
## Minimum                    104 1
## Maximum            304 3-BLD_IHF
## Mean                        <NA>
## Unique (excld. NA)           223
## Missing values                 0
## Sorted                     FALSE
## 
```

```r
dfsumm(pdat2)
```

```
## 
##  618 rows and 225 columns
##  618 unique rows
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
## Maximum               304     573    2860    2860          3           3
## Mean                  209     356    1890    1890       2.14           3
## Unique (excld. NA)     14     206     617     618          3           1
## Missing values          0       0       0       0          0         435
## Sorted              FALSE    TRUE    TRUE    TRUE      FALSE        TRUE
##                                                                         
##                         proj     exper  exper2 institute   country
## Class              character character integer character character
## Minimum               1997sl         1       9   ADAS-RR        CA
## Maximum                Unter        Z2      23       WUR        UK
## Mean                    <NA>      <NA>    15.8      <NA>      <NA>
## Unique (excld. NA)       130       194      15        15         9
## Missing values            46         0     590         0         0
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
## Mean                                 702                  724              123
## Unique (excld. NA)                   516                  529              249
## Missing values                         0                    0              318
## Sorted                             FALSE                FALSE            FALSE
##                                                                               
##                       pub.id
## Class              character
## Minimum                    1
## Maximum                  N/A
## Mean                    <NA>
## Unique (excld. NA)        10
## Missing values           343
## Sorted                 FALSE
##                             
##                                                                                                                                                                                                                                                                      pub.info
## Class                                                                                                                                                                                                                                                               character
## Minimum                                                     Bittman, S., van Vliet, L. J. P., Kowalenko, C. G., McGinn, S., Hunt, D. E., Bounaix, F., (2005) """"Surface-Banding Liquid Manure over Aeration Slots.""""  Agron. J.  7:1304–1313.  doi:10.2134/agronj2004.0277
## Maximum            Scotto di Perta, E., Fiorentino, N., Gioia, L., Cervelli, E., Faugno, S., & Pindozzi, S. (2019). Prolonged sampling time increases correlation between wind tunnel and integrated horizontal flux method. Agricultural and forest meteorology, 265, 48-55.
## Mean                                                                                                                                                                                                                                                                     <NA>
## Unique (excld. NA)                                                                                                                                                                                                                                                         16
## Missing values                                                                                                                                                                                                                                                            476
## Sorted                                                                                                                                                                                                                                                                  FALSE
##                                                                                                                                                                                                                                                                              
##                        lat    long                          topo     field
## Class              numeric numeric                     character character
## Minimum                 41    -122 Field flat, surrounding hilly         1
## Maximum               56.8    14.4                slightly hilly   Zegveld
## Mean                  51.8   0.707                          <NA>      <NA>
## Unique (excld. NA)      31      32                             5       238
## Missing values         303     303                           312        95
## Sorted               FALSE   FALSE                         FALSE     FALSE
##                                                                           
##                         plot plot.area     treat                     rep
## Class              character   numeric character               character
## Minimum                             47         0                       0
## Maximum                T2-B2     43200 untreated large neighbouring plot
## Mean                    <NA>      2070      <NA>                    <NA>
## Unique (excld. NA)       129       240       212                       8
## Missing values             4       130         0                     293
## Sorted                 FALSE     FALSE     FALSE                   FALSE
##                                                                         
##                       rep2  n.ints                  t.start.p
## Class              integer integer            POSIXct, POSIXt
## Minimum                  1       5        1990-06-12 13:30:00
## Maximum                  1    1310        2022-11-24 10:30:00
## Mean                     1    20.5 2008-11-27 23:03:06.447761
## Unique (excld. NA)       1      31                        303
## Missing values         590       0                        283
## Sorted                TRUE   FALSE                      FALSE
##                                                              
##                                       t.end.p     dt1  dt.min  dt.max  ct.min
## Class                         POSIXct, POSIXt numeric numeric numeric numeric
## Minimum                   1990-06-16 11:17:00    0.15    0.15    0.25    0.15
## Maximum                   2022-12-01 10:30:00      24      24     192      24
## Mean               2008-12-04 22:11:05.910448    1.72    1.68    41.5    1.72
## Unique (excld. NA)                        291     114     115     271     114
## Missing values                            283       0       0       0       0
## Sorted                                  FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                     ct.max meas.tech meas.tech2 meas.tech.orig meas.tech.det
## Class              numeric character  character      character     character
## Minimum                 24       agm  micro met            AGM 150 cm height
## Maximum                650     zinst  micro met      ZINST/bls     see notes
## Mean                   126      <NA>       <NA>           <NA>          <NA>
## Unique (excld. NA)     421         8          1              9             3
## Missing values           0         0          0              0           327
## Sorted               FALSE     FALSE       TRUE          FALSE         FALSE
##                                                                             
##                     j.NH31  j.rel1     e.1     e.4     e.6    e.12    e.24
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              -1.45 -0.0132   -1.45  -0.378  -0.281 -0.0127 0.00935
## Maximum               41.2   0.572    30.3    54.2    58.8    61.6    81.1
## Mean                  2.72  0.0635    2.95    6.55    7.98    9.25    10.9
## Unique (excld. NA)     603     585     389     583     594     600     618
## Missing values           0       0     227      35      21      14       0
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                       e.48    e.72    e.96   e.168 e.final  e.cum.1  e.cum.4
## Class              numeric numeric numeric numeric numeric  numeric  numeric
## Minimum              0.125   0.177   -1.11  0.0627   -12.2 -0.00214 -0.00248
## Maximum               90.1     117     128    37.6     166     30.3     54.2
## Mean                    13    14.3    15.3    13.9    14.7     3.53      7.7
## Unique (excld. NA)     554     494     353      16     617      216      288
## Missing values          64     124     263     602       0      402      330
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE    FALSE    FALSE
##                                                                             
##                     e.cum.6 e.cum.12 e.cum.24 e.cum.48 e.cum.72 e.cum.96
## Class               numeric  numeric  numeric  numeric  numeric  numeric
## Minimum            -0.00484  -0.0127  0.00935    0.125    0.177    0.148
## Maximum                58.8     60.3     61.8     67.6     65.1     66.6
## Mean                   9.35     10.8     11.8     13.4     14.2       15
## Unique (excld. NA)      291      294      300      268      230       95
## Missing values          326      324      318      350      388      523
## Sorted                FALSE    FALSE    FALSE    FALSE    FALSE    FALSE
##                                                                         
##                    e.cum.168 e.cum.final e.rel.1  e.rel.4  e.rel.6  e.rel.12
## Class                numeric     numeric numeric  numeric  numeric   numeric
## Minimum               0.0627      -0.607 -0.0132 -0.00452 -0.00336 -0.000421
## Maximum                 37.6        69.1   0.437    0.841    0.894     0.913
## Mean                    13.9        14.2  0.0728    0.141    0.167      0.19
## Unique (excld. NA)        16         300     383      582      592       604
## Missing values           602         318     227       35       21        14
## Sorted                 FALSE       FALSE   FALSE    FALSE    FALSE     FALSE
##                                                                             
##                    e.rel.24 e.rel.48 e.rel.72 e.rel.96 e.rel.168 e.rel.final
## Class               numeric  numeric  numeric  numeric   numeric     numeric
## Minimum            0.000137  0.00186  0.00332  -0.0106   0.00267      -0.116
## Maximum                0.92    0.975     1.11     1.23     0.593        1.59
## Mean                  0.216    0.251    0.269    0.246     0.207       0.276
## Unique (excld. NA)      614      554      492      352        16         613
## Missing values            0       64      124      263       602           0
## Sorted                FALSE    FALSE    FALSE    FALSE     FALSE       FALSE
##                                                                             
##                       clay    silt    sand      oc       soil.type soil.type2
## Class              numeric numeric numeric numeric       character  character
## Minimum                2.4     2.4       7     0.9            clay       clay
## Maximum                 54    71.3    92.3    13.7 silty.clay.loam       sand
## Mean                    24    28.6    45.4     3.4            <NA>       <NA>
## Unique (excld. NA)      32      31      30      37              13          3
## Missing values         286     287     287     327              10        300
## Sorted               FALSE   FALSE   FALSE   FALSE           FALSE      FALSE
##                                                                              
##                    soil.water soil.water.v soil.moist soil.ph soil.dens
## Class                 numeric      numeric  character numeric   numeric
## Minimum                 0.005         13.1        dry       5       0.8
## Maximum                     1           67 wet frozen    8.21      1.55
## Mean                    0.316         31.8       <NA>    6.83      1.14
## Unique (excld. NA)         81           78          4      40        34
## Missing values            412          460        387     348       359
## Sorted                  FALSE        FALSE      FALSE   FALSE     FALSE
##                                                                        
##                     crop.res      till air.temp.1 air.temp.4 air.temp.6
## Class              character character    numeric    numeric    numeric
## Minimum                   No        no        2.4       2.22      -1.47
## Maximum                  Yes       Yes       28.7       32.6       32.6
## Mean                    <NA>      <NA>         15       15.8       14.8
## Unique (excld. NA)         2         4        149        278        480
## Missing values           324       243        402        330         21
## Sorted                 FALSE     FALSE      FALSE      FALSE      FALSE
##                                                                        
##                    air.temp.12 air.temp.24 air.temp.48 air.temp.72 air.temp.96
## Class                  numeric     numeric     numeric     numeric     numeric
## Minimum                  -1.27       -1.02      -0.758      -0.656       0.934
## Maximum                   31.9        28.9        28.2        28.2        28.2
## Mean                        15          13        12.8        12.7        13.8
## Unique (excld. NA)         500         545         556         565         295
## Missing values              14           0           0           0         318
## Sorted                   FALSE       FALSE       FALSE       FALSE       FALSE
##                                                                               
##                    air.temp.168 air.temp.mn air.temp.z soil.temp.1 soil.temp.4
## Class                   numeric     numeric    numeric     numeric     numeric
## Minimum                    1.08      -0.209        0.1           1           1
## Maximum                    28.2        49.6         10        16.9          17
## Mean                       13.9        13.4       1.67        6.63        6.64
## Unique (excld. NA)          293         555          9           4           4
## Missing values              318           2          0         612         612
## Sorted                    FALSE       FALSE      FALSE       FALSE       FALSE
##                                                                               
##                    soil.temp.6 soil.temp.12 soil.temp.24 soil.temp.48
## Class                  numeric      numeric      numeric      numeric
## Minimum                      1            1            1            1
## Maximum                   24.1         23.7           22         21.6
## Mean                      12.8         12.9         12.4         12.2
## Unique (excld. NA)         192          203          233          240
## Missing values             324          320          319          319
## Sorted                   FALSE        FALSE        FALSE        FALSE
##                                                                      
##                    soil.temp.72 soil.temp.96 soil.temp.168 soil.temp.mn
## Class                   numeric      numeric       numeric      numeric
## Minimum                       1            1             1        0.281
## Maximum                    21.3         16.6          16.6         22.6
## Mean                       12.2         6.39          6.37         12.4
## Unique (excld. NA)          251            4             4          243
## Missing values              319          612           612          321
## Sorted                    FALSE        FALSE         FALSE        FALSE
##                                                                        
##                    soil.temp.surf.1 soil.temp.surf.4 soil.temp.surf.6
## Class                       numeric          numeric          numeric
## Minimum                           1                1                1
## Maximum                        19.2             16.6             16.2
## Mean                           6.47             6.21             5.94
## Unique (excld. NA)                4                4                4
## Missing values                  612              612              612
## Sorted                        FALSE            FALSE            FALSE
##                                                                      
##                    soil.temp.surf.12 soil.temp.surf.24 soil.temp.surf.48
## Class                        numeric           numeric           numeric
## Minimum                            1                 1            -0.581
## Maximum                         16.5              15.2              15.3
## Mean                            5.72              5.46              5.12
## Unique (excld. NA)                 4                 4                 4
## Missing values                   612               612               612
## Sorted                         FALSE             FALSE             FALSE
##                                                                         
##                    soil.temp.surf.72 soil.temp.surf.96 soil.temp.surf.168
## Class                        numeric           numeric            numeric
## Minimum                      -0.0816             0.131              0.453
## Maximum                         15.8              16.1               15.6
## Mean                            5.28              5.47               5.53
## Unique (excld. NA)                 5                 5                  5
## Missing values                   612               612                612
## Sorted                         FALSE             FALSE              FALSE
##                                                                          
##                    soil.temp.surf.mn soil.temp.z   rad.1   rad.4   rad.6
## Class                        numeric   character numeric numeric numeric
## Minimum                        0.789           0       0       0       0
## Maximum                         21.1       FALSE     868    1380    1380
## Mean                             7.9        <NA>     403     706     579
## Unique (excld. NA)                 5           5     132     178     379
## Missing values                   612         317     450     433     190
## Sorted                         FALSE       FALSE   FALSE   FALSE   FALSE
##                                                                         
##                     rad.12  rad.24  rad.48  rad.72  rad.96 rad.168  rad.mn
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum                  0       0       0       0   0.354   0.339       0
## Maximum               1540    1500     991     971     991     991     991
## Mean                   578     377     297     301     464     481     332
## Unique (excld. NA)     391     404     404     406     193     193     402
## Missing values         184     177     177     177     421     421     179
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                     wind.1  wind.4  wind.6 wind.12 wind.24 wind.48 wind.72
## Class              numeric numeric numeric numeric numeric numeric numeric
## Minimum              0.132   0.279   0.297    0.53    0.52   0.511   0.511
## Maximum               7.57    7.63      16      16     9.5      11      11
## Mean                  3.14    3.35    3.87    3.84    3.21    3.21    3.24
## Unique (excld. NA)     154     279     501     523     556     561     560
## Missing values         402     330      21      14       0       7      11
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                           
##                    wind.96 wind.168 wind.mn  wind.z wind.2m.1 wind.2m.4
## Class              numeric  numeric numeric numeric   numeric   numeric
## Minimum              0.985     1.11   0.511       1     0.141     0.299
## Maximum               6.62     6.62    19.9      10      7.57      7.63
## Mean                  2.86     2.85    3.38    2.71      3.15      3.36
## Unique (excld. NA)     293      294     559      20       154       279
## Missing values         318      318      13       0       402       330
## Sorted               FALSE    FALSE   FALSE   FALSE     FALSE     FALSE
##                                                                        
##                    wind.2m.6 wind.2m.12 wind.2m.24 wind.2m.48 wind.2m.72
## Class                numeric    numeric    numeric    numeric    numeric
## Minimum                0.318      0.567      0.586      0.588      0.588
## Maximum                 16.3       16.3       9.69       11.2       11.2
## Mean                    3.76       3.73       3.11       3.12       3.15
## Unique (excld. NA)       509        524        556        561        561
## Missing values            21         14          0          7         11
## Sorted                 FALSE      FALSE      FALSE      FALSE      FALSE
##                                                                         
##                    wind.2m.96 wind.2m.168 wind.2m.mn  wind.loc  rain.1  rain.4
## Class                 numeric     numeric    numeric character numeric numeric
## Minimum                  1.05        1.11      0.588                 0       0
## Maximum                  6.62        6.62       20.3      Plot     2.4     0.5
## Mean                     2.87        2.87        3.3      <NA>   0.112 0.00174
## Unique (excld. NA)        294         295        560         5      10       2
## Missing values            318         318         13       323     230     330
## Sorted                  FALSE       FALSE      FALSE     FALSE   FALSE   FALSE
##                                                                               
##                     rain.6 rain.12 rain.24 rain.48 rain.72 rain.96 rain.168
## Class              numeric numeric numeric numeric numeric numeric  numeric
## Minimum                  0       0       0       0       0       0        0
## Maximum                  4     5.2    36.1    55.9    55.9    15.4     24.6
## Mean                 0.141   0.169   0.635    1.21    1.67    1.31     10.6
## Unique (excld. NA)      22      24      42      57      59      11       13
## Missing values          29      22       8      40      78     523      602
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE    FALSE
##                                                                            
##                    rain.tot rain.rate.1 rain.rate.4 rain.rate.6 rain.rate.12
## Class               numeric     numeric     numeric     numeric      numeric
## Minimum                   0           0           0           0            0
## Maximum                 113         2.4       0.125        1.19        0.706
## Mean                   4.98       0.112    0.000434      0.0324       0.0269
## Unique (excld. NA)       75          10           2          57           69
## Missing values           10         230         330          29           22
## Sorted                FALSE       FALSE       FALSE       FALSE        FALSE
##                                                                             
##                    rain.rate.24 rain.rate.48 rain.rate.72 rain.rate.96
## Class                   numeric      numeric      numeric      numeric
## Minimum                       0            0            0            0
## Maximum                    1.63         1.19         0.79        0.334
## Mean                     0.0343       0.0318       0.0281       0.0051
## Unique (excld. NA)          103          149          172           11
## Missing values                8            8            8          318
## Sorted                    FALSE        FALSE        FALSE        FALSE
##                                                                       
##                    rain.rate.168 rain.rate.mn    rh.1    rh.4    rh.6   rh.12
## Class                    numeric      numeric numeric numeric numeric numeric
## Minimum                        0            0       1       1       1       1
## Maximum                    0.146        0.778      84    91.3     100     100
## Mean                     0.00459        0.033    43.7    51.3    69.9    70.7
## Unique (excld. NA)            16          232       5      10     135     142
## Missing values               318           10     611     606     403     401
## Sorted                     FALSE        FALSE   FALSE   FALSE   FALSE   FALSE
##                                                                              
##                      rh.24   rh.48   rh.72   rh.96  rh.168   rh.mn   far.loc
## Class              numeric numeric numeric numeric numeric numeric character
## Minimum                  1       1       1       1       1       1         0
## Maximum               98.7    98.7    97.9    97.9    89.8     354     Field
## Mean                  76.5    77.7    77.6    69.5    68.2    86.6      <NA>
## Unique (excld. NA)     175     191     194      19      19     195        15
## Missing values         387     387     387     594     594     387       440
## Sorted               FALSE   FALSE   FALSE   FALSE   FALSE   FALSE     FALSE
##                                                                             
##                    man.source man.source.orig          man.source.det   man.bed
## Class               character       character               character character
## Minimum                   cat    Breeding Pig                 buffalo      None
## Maximum                   pig    silage maize see """"experiments""""     Straw
## Mean                     <NA>            <NA>                    <NA>      <NA>
## Unique (excld. NA)          6              10                       5         3
## Missing values              0               0                     594       313
## Sorted                  FALSE           FALSE                   FALSE     FALSE
##                                                                                
##                      man.con            man.trt1  man.trt2  man.trt3 man.stor
## Class              character           character character character  integer
## Minimum               liquid anaerobic digestion                <NA>       40
## Maximum                solid                None      None      <NA>      182
## Mean                    <NA>                <NA>      <NA>      <NA>     90.3
## Unique (excld. NA)         5                   6         4         0        8
## Missing values           286                   0       289       618      551
## Sorted                 FALSE               FALSE     FALSE      <NA>    FALSE
##                                                                              
##                     man.dm  man.vs man.tkn man.tan man.vfa man.tic  man.ua
## Class              numeric numeric numeric numeric numeric numeric integer
## Minimum              0.772    5.74    0.98    0.57    0.16    0.31       0
## Maximum               13.8    5.74    5.53     8.1    0.51    0.31       0
## Mean                  5.99    5.74    2.97    2.22   0.323    0.31       0
## Unique (excld. NA)     262       1     149     270       3       1       1
## Missing values           0     617     316       0     615     617     590
## Sorted               FALSE    TRUE   FALSE   FALSE   FALSE    TRUE    TRUE
##                                                                           
##                     man.ph    acid  date.start                  app.start
## Class              numeric logical IDate, Date            POSIXct, POSIXt
## Minimum               6.54   FALSE  1990-06-12        1990-06-12 13:30:00
## Maximum                8.9   FALSE  2022-11-24        2022-11-24 11:42:00
## Mean                  7.44  0 TRUE        <NA> 2010-06-11 12:59:37.218045
## Unique (excld. NA)      81       1         109                        236
## Missing values           0       0         283                        352
## Sorted               FALSE    TRUE       FALSE                      FALSE
##                                                                          
##                      app.start.orig               app.end     app.end.orig
## Class                     character       POSIXct, POSIXt        character
## Minimum            01-06-1999 08:40   2013-06-19 16:05:00 09/11/2021 10:20
## Maximum             5/01/2022 14:23   2022-11-24 11:43:00  5/01/2022 14:23
## Mean                           <NA> 2019-01-23 22:54:33.6             <NA>
## Unique (excld. NA)              236                    24               24
## Missing values                  352                   593              593
## Sorted                        FALSE                 FALSE            FALSE
##                                                                           
##                    app.method app.method2              app.method.orig app.rate
## Class               character   character                    character  numeric
## Minimum                    bc        band Band spread or trailing hose      6.6
## Maximum                    ts          ts                Trailing shoe      133
## Mean                     <NA>        <NA>                         <NA>     29.8
## Unique (excld. NA)          5           6                            8      370
## Missing values              0           0                            0        0
## Sorted                  FALSE       FALSE                        FALSE    FALSE
##                                                                                
##                    tan.app    incorp incorp.orig time.incorp man.area dist.inj
## Class              numeric character   character     numeric  numeric  integer
## Minimum               10.9      none        none           0        1       22
## Maximum                196      none        None           0      100       30
## Mean                  59.3      <NA>        <NA>           0     52.6     29.6
## Unique (excld. NA)     496         1           2           1       12        2
## Missing values           0         0           0         590      507      597
## Sorted               FALSE      TRUE       FALSE        TRUE    FALSE    FALSE
##                                                                               
##                     furrow.z  furrow.w      crop    crop.orig  crop.z crop.area
## Class              character character character    character numeric   integer
## Minimum                                bare soil    Bare soil       0         0
## Maximum                  6.9         3     wheat Winter Wheat      65       100
## Mean                    <NA>      <NA>      <NA>         <NA>    11.4      74.6
## Unique (excld. NA)        13         5         9           16     119         7
## Missing values           582       590         0            0     128       567
## Sorted                 FALSE     FALSE     FALSE        FALSE   FALSE     FALSE
##                                                                                
##                        lai
## Class              numeric
## Minimum                0.1
## Maximum                1.2
## Mean                  0.65
## Unique (excld. NA)       2
## Missing values         616
## Sorted                TRUE
##                           
##                                                                                        notes.plot
## Class                                                                                   character
## Minimum                                                                                          
## Maximum            NA  Incorporation (incorp/incorp.orig) not entered and was assumed to be none.
## Mean                                                                                         <NA>
## Unique (excld. NA)                                                                             16
## Missing values                                                                                293
## Sorted                                                                                      FALSE
##                                                                                                  
##                    flag.plot app.mthd                digested man.ph.missing
## Class              character   factor                 logical        logical
## Minimum                            bc                   FALSE          FALSE
## Maximum                  m i       cs                    TRUE          FALSE
## Mean                    <NA>     bsth 0.0550161812297735 TRUE         0 TRUE
## Unique (excld. NA)         3        5                       2              1
## Missing values             0        0                       0              0
## Sorted                 FALSE    FALSE                   FALSE           TRUE
##                                                                             
##                           iexper
## Class                  character
## Minimum                    104 1
## Maximum            304 3-BLD_IHF
## Mean                        <NA>
## Unique (excld. NA)           200
## Missing values                 0
## Sorted                     FALSE
## 
```


