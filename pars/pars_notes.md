# ALFAM2 model parameters

# Ideas
A few ideas about what to look into or how to do it.

## Pig slurry temperature
Temperature sensitivity of pig slurry is much lower than cattle because of initial partitioning to the slow pool.
Looking at Fig. 3 in the EF report, this may cause the poor fit for pig.

## Short- vs. long-term temperature
It seems difficult to get the model to do both overall differences among trials and diurnal peaks.
I've noticed this with the AU (JMP and JNK) eGylle (`proj`) data.
I wonder if soil warming is part of the reason for diurnal peaks. 
I could look into this using soil surface temperature in cases where we have data, and perhaps generate soil surface temperature data that is (average?) air temperature + a constant when the sun is shining.

# Focused subsets idea 13 March 2023
So far parameter estimation has been difficult and arbitrary as usual.
I have an idea, to use focused subsets for comparing many parameter sets.
Would look for subsets where variables vary within a pmid or an institution.


* Acidification
* Wind speed
* Air temperature
* Rain
* Application methods
* Manure type
* Dry matter
