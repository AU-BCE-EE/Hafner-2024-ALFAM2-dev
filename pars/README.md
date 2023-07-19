# `ALFAM2_pars`
Development and evaluation of ALFAM2 parameter sets.
Main point is development of new parameter set 3.

# `pars`
The `pars` directory has scripts for parameter estimation.
Measurement data subsets are clarified here:

* `pdat3` and `idat3` have the main subset used. Incorporation is included in both `*dat2` and `*dat3`, and *all* incorporation observations are included by estimation of missing predictor variable values using `interpm()`.
* `*dat2` is similar to `*dat3` but does not require pH, so it is slightly larger than `*dat3` (more plots/`pmid`).
* `*dat1` was used to estimate parameters for some "null" models and so pH was not required, but plots with acidification or incorporation were excluded (they don't make sense for models without pH or incorporation predictors). 
