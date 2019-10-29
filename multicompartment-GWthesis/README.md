# Multicompartmental code with constant eta:
Contact nefrathenrici@g.hmc.edu or ambernguyen@umass.edu if you have questions!

## Purpose:
This code stores the multicompartmental with a constant eta, rather than the finalized version with an eta function.

## How to run:
Run solver_multi to generate graphs of B,G,I and E,R,Em, and Ba,Bn,D,tD.

## Code structure:
Parameters are stored in the paramsmulti.m file, and the ODEs are stored in rhs.m
Solver_multi.m generates graphs and uses the ODEs and parameters from the other files.
Heatmaps for fM and fMa are in the heatmaps-fM-fMa folder.
