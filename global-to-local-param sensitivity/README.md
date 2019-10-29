# Global-to-Local Sensitivity
Contact nefrathenrici@hmc.edu with any questions!

## Purpose:
This code takes in an LHS matrix with parameter values, and simulates the multicompartmental model, running local parameter sensitivity on each of the parameters. It will output a csv with the percent change in end-level glucose. If you uncomment the bottom of the parambarplot.m, the code will also make a sorted plot of the average change in glucose for each parameter.

## How to run the code:
Use this code by calling the function parambarplot(tmax,percentchange).  That is, if you want it to run 100 days, change each parameter by 5%, you call at the Matlab prompt: parambarplot(100,5).  It is very slow to run - it will take multiple days.
##### To parallelize:
Parallelization is important, since this code takes days to run. Change the for loop on line 21 of <parambarplot.m> to different indices. I opened 8 instances of MATLAB and ran the loop from
1 - 1250, 1251 - 2500, 2500 - 3751, etc all the way up to 10000. Be sure to change the naming conventions of the output CSV, since the different instances will overwrite each other if the CSVs have the same name. 

## Code structure:
Parambarplot imports the LHS.csv, then runs odesolve for each row in the LHS matrix.
odesolve uses parameters.m to load in the current row of the LHS matrix, and then simulates the model with changed parameters. The glucose level is returned to parambarplot, and is compared to the glucose level resulting from the unchanged parameter. The larger percent change is then stored in the output csv in parambarplot.
