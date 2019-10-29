% This is the main file for the eFAST multicompartmental code that you want
% to execute. Just hit the Run button.

%===================================================================

% Model_efast_T1D.m will run the eFAST algorithm and output a
% Model_efast.mat file. Uncomment it if you actually want to rerun the
% algorithm and generate a new . mat file. It will take ~7+ days to run.

% delete the previous .mat file first
%delete Model_efast.mat;

%Model_efast_T1D.m;

%===================================================================

% rankingSI_STi will generate first order sensitivity index and total order
% sensitivity index plots at Week 10 and Week 39. You will get 4 plots in
% total. Only the Si's/STi's for the most significant parameters with p < 0.05 will be
% displayed.

rankingSI_STi('Model_efast.mat', 1, 1);