% This code will perform a uniform LHS distribution on the values of the
% parameters of interest, within the bounds specified for each parameter.
% The output for this code is an LHS.csv file.

% formLHS(50) wil generate a 50^2 x 2 matrix and it's stored in LHS.csv
function formLHS(sizemat)


%prepare grid of parameters values fM, fMa
n = sizemat;

% set a lower-bound and upper-bound for both the fM and fMa parameters
f_min = 0.1;
f_max = 2;

%-----------------------------------

%generate random number for f_min and f_max for a certain amount
fMa = sort(LHS_Uniform(f_min, f_max, n)); 
fM = sort(LHS_Uniform(f_min, f_max, n));
[f1, f2] = meshgrid(fMa, fM); %stretch matrices out in vector
% 

%-------- putting them into vector
f1 = reshape(f1, [], 1); 
f2 = reshape(f2, [],1);
LHS = [f1 f2]; %store them in a matrix

%----- Save as LHS.csv

csvwrite('LHS.csv',LHS);

end 