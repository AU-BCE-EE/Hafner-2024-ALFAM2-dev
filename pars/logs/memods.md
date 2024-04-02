---
title: 'Mixed-effects models'
output: pdf_document
classoption: landscape
author: Sasha D. Hafner
date: "29 March, 2024 Mar:03"
---

# 


```r
pdat1[, inst := factor(inst)]

mod1 <- lmer(log10(e.rel.final) ~ app.mthd + incorp + man.dm + air.temp.24 + wind.2m.24 + (1|inst), data = pdat1)
summary(mod1)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: log10(e.rel.final) ~ app.mthd + incorp + man.dm + air.temp.24 +  
##     wind.2m.24 + (1 | inst)
##    Data: pdat1
## 
## REML criterion at convergence: 338.4
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -7.5175 -0.5358  0.1043  0.6142  2.5893 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  inst     (Intercept) 0.02482  0.1576  
##  Residual             0.08423  0.2902  
## Number of obs: 729, groups:  inst, 14
## 
## Fixed effects:
##                Estimate Std. Error t value
## (Intercept)   -2.295543   0.185603 -12.368
## app.mthdbsth  -0.345878   0.041743  -8.286
## app.mthdts    -0.340766   0.034456  -9.890
## app.mthdos    -0.743933   0.036004 -20.662
## app.mthdcs    -0.588839   0.116959  -5.035
## incorpnone     1.485042   0.169716   8.750
## incorpshallow  1.067148   0.172861   6.173
## man.dm         0.032805   0.005798   5.658
## air.temp.24    0.013113   0.002381   5.508
## wind.2m.24     0.026519   0.007827   3.388
## 
## Correlation of Fixed Effects:
##             (Intr) app.mthdb app.mthdt app.mthds app.mthdc incrpn incrps man.dm
## app.mthdbst -0.111                                                             
## app.mthdts  -0.005  0.461                                                      
## app.mthdos   0.020  0.354     0.466                                            
## app.mthdcs  -0.072  0.346     0.162     0.166                                  
## incorpnone  -0.911 -0.046    -0.093    -0.099    -0.013                        
## incorpshllw -0.886  0.013    -0.013    -0.011     0.009     0.963              
## man.dm      -0.240  0.330    -0.003     0.043     0.233     0.042  0.040       
## air.temp.24 -0.189 -0.012     0.005    -0.055    -0.008    -0.010 -0.036 -0.008
## wind.2m.24  -0.164 -0.112     0.113     0.070     0.004     0.016 -0.006  0.011
##             ar..24
## app.mthdbst       
## app.mthdts        
## app.mthdos        
## app.mthdcs        
## incorpnone        
## incorpshllw       
## man.dm            
## air.temp.24       
## wind.2m.24   0.251
```

```r
mod2 <- lmer(log10(e.rel.final) ~ app.mthd + incorp + man.dm + air.temp.24 + wind.2m.24 + (app.mthd|inst), data = pdat1)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
## Model failed to converge with max|grad| = 0.00211223 (tol = 0.002, component 1)
```

```
## Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, : Model is nearly unidentifiable: large eigenvalue ratio
##  - Rescale variables?
```

```r
summary(mod2)
```

```
## Linear mixed model fit by REML ['lmerMod']
## Formula: log10(e.rel.final) ~ app.mthd + incorp + man.dm + air.temp.24 +  
##     wind.2m.24 + (app.mthd | inst)
##    Data: pdat1
## 
## REML criterion at convergence: 308.2
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -7.5997 -0.4611  0.0984  0.5817  2.8300 
## 
## Random effects:
##  Groups   Name         Variance Std.Dev. Corr                   
##  inst     (Intercept)  0.03453  0.1858                          
##           app.mthdbsth 0.02000  0.1414   -0.77                  
##           app.mthdts   0.03059  0.1749    0.13 -0.53            
##           app.mthdos   0.06581  0.2565   -0.81  0.47  0.45      
##           app.mthdcs   0.09679  0.3111   -0.02  0.33 -0.20 -0.01
##  Residual              0.07960  0.2821                          
## Number of obs: 729, groups:  inst, 14
## 
## Fixed effects:
##                Estimate Std. Error t value
## (Intercept)   -2.346633   0.186402 -12.589
## app.mthdbsth  -0.270047   0.069028  -3.912
## app.mthdts    -0.287253   0.088093  -3.261
## app.mthdos    -0.551856   0.108581  -5.082
## app.mthdcs    -0.495941   0.313239  -1.583
## incorpnone     1.522254   0.165222   9.213
## incorpshallow  1.078208   0.168124   6.413
## man.dm         0.025870   0.005936   4.358
## air.temp.24    0.012626   0.002330   5.420
## wind.2m.24     0.024928   0.007734   3.223
## 
## Correlation of Fixed Effects:
##             (Intr) app.mthdb app.mthdt app.mthds app.mthdc incrpn incrps man.dm
## app.mthdbst -0.294                                                             
## app.mthdts  -0.013 -0.055                                                      
## app.mthdos  -0.237  0.443     0.508                                            
## app.mthdcs  -0.066  0.278     0.015     0.108                                  
## incorpnone  -0.887 -0.009    -0.027    -0.001     0.002                        
## incorpshllw -0.861  0.019     0.000     0.018     0.007     0.962              
## man.dm      -0.234  0.194     0.094    -0.025     0.093     0.037  0.038       
## air.temp.24 -0.204  0.081     0.035     0.028    -0.001    -0.007 -0.032  0.003
## wind.2m.24  -0.156 -0.063     0.006    -0.033    -0.008     0.017 -0.007 -0.025
##             ar..24
## app.mthdbst       
## app.mthdts        
## app.mthdos        
## app.mthdcs        
## incorpnone        
## incorpshllw       
## man.dm            
## air.temp.24       
## wind.2m.24   0.246
## optimizer (nloptwrap) convergence code: 0 (OK)
## Model failed to converge with max|grad| = 0.00211223 (tol = 0.002, component 1)
## Model is nearly unidentifiable: large eigenvalue ratio
##  - Rescale variables?
```

