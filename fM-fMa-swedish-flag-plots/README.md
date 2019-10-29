# Multicompartmental code with eta function:
Contact nefrathenrici@g.hmc.edu if you have questions!

## Purpose:
This code runs Swedish Flag Plots, which are LdeP's name for local parameter sensitivity graphed at different time points. 

This code changes fM by 5% while fixing the rest of the parameters. It then graphs the percent change in glucose at 10, 20, 35, and 40 weeks. This is then repeated with fMa.

## How to run:
Run ParamSensitivityNodAndBalbC.m to generate some nice figures. 

## Code structure:
Parameters are stored in the Parameters.m file, and the ODEs are stored in rhs.m file. The solver is ODEsolveNoTrtmnt.m

ParamSensitivityNodAndBalbC.m calls ODEsolveNoTrtmnt, which in turn uses the ODEs and parameters from the other files to run.
