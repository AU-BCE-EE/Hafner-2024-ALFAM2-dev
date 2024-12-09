# Hafner-2023-ALFAM2-dev
Refinement, evaluation of ALFAM2 model and development of parameter set 3 as described in this paper:

Hafner, S. D., Pedersen, J., Fuß, R., Kamp, J. N., Dalby, F. R., Amon, B., Pacholski, A., Adamsen, A. P. S., & Sommer, S. G. (2025). Improved tools for estimation of ammonia emission from field-applied animal slurry: Refinement of the ALFAM2 model and database. Atmospheric Environment, 340, 120910. <https://doi.org/10.1016/j.atmosenv.2024.120910>

# Maintainer
Sasha D. Hafner.
Contact information here: <https://au.dk/sasha.hafner@bce>.

# Overview
Work on ALFAM2 model, all in R.

# Subdirectory structure and components

## `censoring`
Check of measurements for censoring low, late emission rates.

## `data-emission`
ALFAM2 database data in `data-emission/data`. 
Data are downloaded from <https://github.com/sashahafner/ALFAM2-data>.
Saved data files are excluded from Git in `.gitignore`, so contributors will have to run `scripts/main.R` to download data locally.
See `data-emission/data/data_version.txt` for current data version.

## `data-summary`
Summary of latest data.

## `functions`
R functions used in the other subdirectories.
Some of these are from <https://github.com/sashahafner/jumbled/>, others were written for this (or earlier) ALFAM2 work.

## `pars`
Development and evaluation of parameter set 3.
The largest component, with several further sub-directories for different results.
Some of these are described here.

### `scripts`
`main.R` runs everything, but it would take a day or more to run, mainly because of the bootstrap and cross-validation parts.
Some parts are described here.

The `subset.R` and `prep.R` scripts get measurement data ready.
`par_est.R` does parameter estimation using the `optim()` function.
There are a lot of choices that must be made about how this should take place.
The settings are passed to either the `resCalc()` function (for a single response) or `resCalcComb()` for using 2 responses simultaneously in the objective function.
These two functions are defined in the `functions` directory.

Output from the `optim()` calls are saved in a list called `mods` (as in the parameter sets each represent a unique "model").
This list includes parameter estimates, objective function value, convergence information, and whatever else `optim()` returns.

In `extract_pars.R` the parameters are extracted for export and plotting.

`calc_emis.R` calculates emission using all the parameter sets in `mods`.

### `workspace`
To work with parameter estimation results without re-running everything, use the saved workspace.
See commented out call near top of `pars/scripts/main.R`.
These files are excluded via `.gitignore`, so are only helpful if the analysis had been carried out previously.

### `plots-curves`
Plots of cumulative emission curves for all field plots used for parameter estimation.
Measurements are blue, parameter set 3 calculated values in red.
Plot titles have identification key (`pmid`) and some other information.

### `plots-resids`
Has plots of residuals (all as ALFAM2 value minus measured value) in 168 h cumulative emission versus some predictor variables: DM, pH, and average air temperature.
These show that parameter set 3 (ps3 in names) addresses some problems that were present in sets 1 and 2 (ps1, ps2).
Plots are included for all parameter sets.

### `plots-scatter`
Bivariate plots of measured vs. calculated 168 h cumulative emission for different parameter sets.

## `r5`
Exploration of effect of new sink with `r5` parameter.

## `sens`
Sensitivity of model to predictor variables, including uncertainty from bootstrap analysis.

## `sens-effect`
Sensitivity with predictors on some common scale.

## `sens-tab`
Sensitivity table like Table 4 in the 2019 paper, with emission predictions for all application methods x multiple scenarios defined by weather and slurry characteristics.

## `solution-test`
A test of the closed-form solution by comparison to a numerical approach.

## `speed`
Evaluation of `alfam2()` evaluation on multiple machines.

## `structure-pH`
Evaluation of model structure with respect to pH effects.

## `uncert-est`
Example to show importance of parameter correlation in estimating uncertainty.

# Links to published paper

| Paper section | Content | Script source | Output source |
| ------------- | ------- | ------------- | ------------- |
| 2.5           | Number of plots outside of emis. limits | pars/scripts/prep.R          | pars/logs/prep.txt       |
| 2.5           | Number of plots with missing values     | pars/scripts subset_summ.Rmd | pars/logs/subset_summ.md |
| 3.1           | Fig. 2    | data-summary/scripts/plot   | data-summary/plots/emis_summ.png |
| 3.2           | Results on bootstrap par. correlation | pars/scripts/boot_cor.R | pars/output/boot_correlation.cav |
| 3.3           | Fig. 3    | pars/scripts/plot_scatter_emis_ps3.R   | pars/plots-scatter/e168_comp_ps3.pdf |
| 3.3           | Table 2   | pars/scripts/fit_summ.R | pars/output/fit_168.csv, pars/output/fit_cv.csv|
| Supplement    | Table S-1 | pars/scripts/counts.R | pars/output/d1_counts.csv |
| Supplement    | Table S-2 | pars/scripts/counts.R | pars/output/d1_incorp_counts.csv |
| Supplement    | Table S-3 | pars/scripts/fit_summ.R | pars/output/fit_168.csv |
| Supplement    | Table S-4 | pars/scripts/fit_summ.R | pars/output/fit_table_comb.csv |
| Supplement    | Table S-6 | speed/scripts/speed_comp_ubuntu.R | speed/output/times_ubuntu.csv |
| Supplement    | Fig. S-1 | pars/scripts/plot_long_resids.R | pars/plots-resids/long_resids.png |
| Supplement    | Fig. S-2 | pars/scripts/plot_long_resids.R | pars/plots-resids/long_resids_box.png |
| Supplement    | Fig. S-3 | pars/scripts/plot_pars.R | pars/plots-pars/pars_sel.png |
| Supplement    | Fig. S-4 | pars/scripts/plot_cv.R | pars/plots-cross-val/cross_val_error.png |
| Supplement    | Fig. S-5 | pars/scripts/plot_cv.R | pars/plots-cross-val/cross_val_rel_error.png |
| Supplement    | Fig. S-6 | sens/scripts/plot.R | sens/plots/sens5_pig.png |
| Supplement    | Fig. S-7 | pars/scripts/plot_resids.R | pars/plots-resids/resids_emis_DM_ps3.png |
| Supplement    | Fig. S-8 | pars/scripts/plot_resids.R | pars/plots-resids/resids_emis_temp_ps3.png |
| Supplement    | Fig. S-9 | sens-tab/scripts/plot_curves.R | sens-tab/plots/sens_curves.png |
| Supplement    | Fig. S-10 | sens-tab/scripts/plot_curves.R | sens-tab/plots/sens_comp_1col_ALFAM.png |
| Supplement    | Fig. S-11 | pars/scripts/plot_scatter_emis.R | pars/plots-scatter/e168_comp_loocv-202.png |
| Supplement    | Fig. S-12 | pars/scripts/plot_scatter_emis.R | pars/plots-scatter/e168_comp_loocv-214.png |
| Supplement    | Fig. S-13 through S-26| pars/scripts/plot_scatter_emis_ps3.R | pars/plots-scatter/e168_comp_loocv-\*.png |
| ------------- | ------- | ------------- | ------------- |
