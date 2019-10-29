# Local Sensitivity
Please contact nefrathenrici@hmc.edu if you have any questions!

## Purpose:
This code changes the parameters one at a time by the desired percent while fixing the rest of the parameters. The resulting glucose change is graphed for each parameter.


## How to run the code:
Use this code by calling the function parambarplot(tmax,percentchange). 

Example: if you want it to run 100 days andchange each parameter by 5%, you call at the Matlab prompt: parambarplot(100,5).  It is very slow to run.

## Code structure:
Parambarplot runs odesolve for each parameter.

odesolve uses parameters.m to load in the parameters, and then simulates the model after changing one parameter. The glucose level is returned to parambarplot, and is compared to the glucose level resulting from the unchanged parameter. 

This is repeated for every parameter, and the change in glucose is graphed for each parameter.
