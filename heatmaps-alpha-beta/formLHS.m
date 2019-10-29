% This code will perform a uniform LHS distribution on the values of the
% parameters of interest, within the bounds specified for each parameter.
% The output for this code is an LHS.csv file.

% formLHS(50) wil generate a 50^2 x 2 matrix and it's stored in LHS.csv

% Amber Nguyen, code 
function formLHS(sizemat)


%prepare grid of parameters values a_e, b_e
n = sizemat;

% set a lower-bound and upper-bound for alpha-eta parameter
alpha_min = 0.01;
alpha_max = 0.4;

% set a lower-bound and upper-bound for beta-eta parameter
beta_min = 7;
beta_max = 35;

%-----------------------------------

%generate random number for alpha_min and alpha_max for n amount
alpha = sort(LHS_Uniform(alpha_min,alpha_max,n)); 

%generate random number for beta_min and beta_max for n amount
beta = sort(LHS_Uniform(beta_min,beta_max,n));

[f1, f2] = meshgrid(alpha, beta); %stretch matrices out in vector
% 

%-------- putting them into vector
f1 = reshape(f1, [], 1); 
f2 = reshape(f2, [],1);
LHS = [f1 f2]; %store them in a matrix

%----- Save as LHS.csv

csvwrite('LHS.csv',LHS);

end 