# Multicompartmental code with eta function:
Contact nefrathenrici@g.hmc.edu or ambernguyen@umass.edu if you have questions!

## Purpose:
This code stores the finalized version of the multicompartmental model from summer 2019.

## How to run:
Run solver_multi to generate graphs of B,G,I and E,R,Em, and Ba,Bn,D,tD.

solver_BGI will generate graphs of B,G,I.

solver_EREm will generate graphs of E,R,Em.

solver_BaBnDtD will generate graphs of Ba,Bn,D,tD.


## Code structure:
Parameters are stored in the paramsmulti.m file, and the ODEs are stored in rhs.m file

The actual solver to generate figures is solver_multi. 


### Heatmaps and local parameter sensitivity for this version:

Heatmaps for alpha eta and alpha beta are in the heatmaps-alpha-beta folder.

Heatmaps for fM and fMa are in the heatmaps-fM-fMa folder.

Simple local parameter sensitivity is found in the simple-local-sensitivity folder.

LHS matrix averaged local parameter sensitivity is found in the LHS-local-sensitivity folder.

Swedish flag plots for fM and fMa are found in fM-fMa-swedish-flag-sensitivity.
