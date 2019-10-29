# eFAST-multicompartmental

## Logistics
This code was written by the Data Science REU undergraduate team on 8 July 2019. It is adapted from An Do’s implementation for the single compartmental model. The original code comes from a Marino 2008 paper, doi: 10.1016/j.jtbi.2008.04.011 .

If you have any questions/concerns about the code, do contact me ! ambernguyen@umass.edu

## How To Use:
Run `main.m` 

`main.m` should output 4 plots showing the first order sensitivity indexes and total order sensitivity indexes at Weeks 10 and Weeks 39 with p-value < 0.05, so only the parameters with the most significant indexes. 

The **first order sensitivity index** will examine the individual parameter’s variance on the output model variance

The **total order sensitivity index** will look at the individual parameter's variance on 1) the output model variance and 2) higher order variance, which is how the individual parameter's variance will affect the variance of the other parameters.

The `dummy parameter` acts as a 0 in this algorithm. We do a two sample t-test to determine parameters with significant sensitivity indexes. The parameters with Si’s and Sti’s that have a p-value < 0.05 are significant, and there is variation in the mean compared to the dummy parameter. 

Any parameters with Si's and STi's with a p > 0.05 are filtered out as their sensitivity indexes are not significant in comparision to the dummy parameter. 

Consult the parameters table in the Summer 2019 REU Report to match the ID number with the parameter name.

## Routines

`Model_efast_T1D.m` first opens up `Parameter_settings_EFAST_T1D` , which sets the min/max ranges for the parameters.

`NR = 30` means there are 30 points, with `NS = 65` samping 65 times from each point, with a sinosuidal shift each sample.

Apoptotic wave is on at `w = 1` .

`assignParameters.m` will assign a value and an index to each parameter for the loop in `Model_efast_T1D.m` .

`ParametersLHS` will get the parameter values, and the parameters are then fed into the ODE's from `ODE_efast.m`

After being fed into the ODE's, only record the glucose levels at the time of interest.

`Model_efast.mat` is the output from `Model_efast_T1D.m` .

`rankingSI_STI.m` will take in `Model_efast.mat` and calculate the SI/STi's and do a two sample t-test and give you the graphs.

----------

19 July 2019 Modification:

Added variation in the initial conditions for Ds / tDs. There was no variation for Ds / tDs prior to this, as they both started at 0.

All the parameters from the parameter table are varied. However, some will have the same pmin/pmax values if they are fixed and are not supposed to have variance.

Relocated the initial conditions from `Parameter_settings_EFAST_T1D` to `ParametersLHS` to make it work for Ds/tDs variance.