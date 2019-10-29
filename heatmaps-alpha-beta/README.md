# heatmaps-alpha-beta

## Logisitics
The heatmap code was originally written by An Do, from Claremont Graduate University.

Modified by Amber Nguyen on 2 July 2019 for implementation with the multi-compartmental model.

If you have any questions, please contact me: ambernguyen@umass.edu

## How To Run
Run `main.m`

`main.m` will generate three heatmaps of the alpha_eta and beta_eta parameter combinations.

The heatmaps are at different apoptotic wave strengths at `w = 0` , `w = 0.5` , and `w = 1` .

###### Generating Figures From Code
If you want to regenerate any figures from the alpha_e/beta_e write-up from the Summer 2019 REU Report, uncomment the snippets of the code corresponding to the appropriate figure.

###### Figures Folder
The figures folder just contains plots I've used in the report. It has a .fig and .png file for each plot.

## Interpreting The Heatmap
The yellow regions for the heat map means diabetic.

The blue regions mean healthy.

The magenta line is a barrier between glycemic and healthy states.

The cyan line is a barrier between diabetic and healthy (or glycemic, depending on your heatmap) states.

## Theory 
Uses Gianna's `mu_B` trafficking rate at `74.56`

Heatmaps work by keeping all the other parameter values fixed while only varying the parameter combinations you are interested in. How do you determine interesting parameter combinations ? From other parameter sensitivity analysises, such as global parameter sensitivity or local parameter sensitivity.

After an LHS matrix is generated, containing a uniform distribution of parameter values, simulations are run using the values of the matrix by feeding the values into an ODE and getting final glucose readings and time of onset. The heatmaps are then generated based on the glucose levels against the values of the alpha_beta and beta_eta.

These heatmaps are particularly useful in determining parameter ranges which keep the mouse in a healthy state or diabetic state.

## Changes To Original Gianna Wu Code
Added an eta function.

An eta function was used as that's the only way you could see variation in the alpha_e and beta_e parameters. In the thesis, it was merely a constant.

There are some discrepancies, such as the insulin levels being a little off. 

## How The Code Works
( this section is mainly an artifact from a draft of this readme, all of this stuff is done for you in the `main.m` file ) 

To run the code, under the command window:

`formLHS(50)`

`T1D_sim('LHS.csv')`

`heatmap('LHS.csv', 0)`

You could change `50` to any number, but the higher, the longer it will take to `run T1D_sim()` . It will generate a matrix containing 2 columns of n^2 values.
`formLHS` will output an `LHS.csv` file. You pass that .csv file into `T1D_sim()`. Doing an LHS of sizemap = 50 will take approximately 1.5-2 hours. If you just want to test the code, just do `formLHS(2)` then `T1D_sim('LHS.csv')`. 

Pass in `0` , `0.5` , or `1` as the second argument for the heatmap function if you want no apoptotic wave, apoptotic wave = 0.5, or apoptotic wave = 1, respectively.

###### dynamics.m
To prove that a certain region is diabetic/glycemic/healthy, run the `dynamics.m` script by picking a point in a certain region. Think of it as an (x, y) coordinate, with the x being the alpha_e, and y being beta_e.

`dynamics(0.1, 1, 0)`

Basically, the arguments you passed were alpha_e, beta_e, and the apoptotic wave (in this case, no wave.)