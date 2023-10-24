# Hafner-2023-ALFAM2-dev
Refinement, evaluation of ALFAM2 model and development of parameter set 3.

# Maintainer
Sasha D. Hafner.
Contact information here: <https://au.dk/sasha.hafner@bce>.

# Overview
Work on ALFAM2 model, all in R.

# Subdirectory structure and components

## `data-emission`
ALFAM2 database data in `data-emission/data`. 
Data are downloaded from <https://github.com/sashahafner/ALFAM2-data>.
Saved data files are excluded from Git in `.gitignore`, so contributors will have to run `scripts/main.R` to download data locally.

## `functions`
R functions used in the other subdirectories.
Some of these are from <https://github.com/sashahafner/jumbled/>, others were written for this (or earlier) ALFAM2 work.

## `pars`
Development and evaluation of parameter set 3.
The largest component, with several further sub-directories for different results.
Some of these are described here.

### `scripts`
`main.R` runs everything, but it would take a day or more to run because of the bootstrap part.
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
See call near top of `main.R`.

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
Not well-developed.

## `sens-tab`
Sensitivity table like Table 4 in the 2019 paper, with emission predictions for all application methods x multiple scenarios defined by weather and slurry characteristics.

## `structure`

