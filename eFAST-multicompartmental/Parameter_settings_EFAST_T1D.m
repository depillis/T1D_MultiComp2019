% This file is to set up max/min and baseline values for model parameters.
% Using U-subsetparameters from Parameter report. 
%% PARAMETER INITIALIZATION
% set up max and mix matrices of model's parameters 

%===================
%MINIMUM VALUES=====
%===================
pmin=[
1 % sE
10 % sR
1000 % Dss
10^(-3) % aEm

0.01 % eta_basal
0.1 % alpha_eta
11 % beta_eta

0.1 % fM
0.1 % fMa

3200 % Jnew
0.1 % k
0.01 % b
0.07 % c
10^(-8) % e1
10^(-8) % e2

0.031 % alphaB
1/62 % deltaB
81 % Ghb
500 % R0
0.1 %G0
0.1 % SI
30 % sigmaI
460 % deltaI
sqrt(10^2) % GI

0.1 % Qpanc
0.13*10^(-6) %bDE
0.13*10^(-6) %bIR
0.1 % aE
0.1 % aR
100 % Tnaive

10 % bP
0.4*10^(-3) % ram
7.5*10^2 % thetaD
0.5 % d

10^(-4) % bE
10^(-4) % bR
0.05 % muBP
0.32 % muPB

10^(-6) % fD
10^(-6) % ftD

1e-6 % muE
1e-6 % muR
26.976 % muB

3 % Qblood
0.012 % mustarSB
0.1 % munormalSB
0.1 % muBSE
0.173 % aI
0.173 % aD

2.59*10^5 % Bconv
0.1 % Qspleen
12.35 % thetashut

0.5*10^6 % Ds
0.5*10^6 % tDs

0 % dummy
];

%===================
%MAXIMUM VALUES=====
%===================
pmax=[
100 % sE
100 % sR
10^7 % Dss
0.1 % aEm

0.03 % eta_basal
0.5 % alpha_eta
30 % beta_eta

2 % fM
2 % fMa

3400 % Jnew
1 % k
0.1 % b
0.25 % c
10^(-6) % e1
10^(-6) % e2

0.035 % alphaB
1/58 % deltaB
100 % Ghb
1000 % R0
2 % G0
1 % SI
50 % sigmaI
576 % deltaI
sqrt(10^4) % GI

0.5 % Qpanc
0.6*10^(-5) % bDE
0.6*10^(-5) % bIR
0.5 % aE
0.5 % aR
500 % Tnaive

85 % bP
1.2 % ram
2.12*10^5 % thetaD
1 % d

10^(-2) % bE
10^(-2) % bR
0.5 % muBP
2 % muPB

10^(-5) % fD
10^(-5) % ftD

1e-5 % muE
1e-5 % muR
74.56 % muB

3 % Qblood
0.08 % mustarSB
100 % munormalSB
100 % muBSE
0.346 % aI
0.346 % aD

2.59*10^5 % Bconv
0.1 % Qspleen
13.65 % thetashut

5*10^6 % Ds
5*10^6 % tDs

10 % dummy
];

%=====================
% PARAMETER LABELS====
%=====================
% these numbers will appear on the plots.
efast_var={'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12',...
    '13', '14', '15', '16', '17', '18', '19', '20', '21', '22', '23', '24',...
    '25', '26', '27', '28', '29', '30', '31', '32', '33', '34', '35', '36'...
    '37', '38', '39', '40', '41', '42', '43', '44', '45', '46', '47', '48',...
    '49', '50', '51', '52', 'Ds', 'tDs', 'dummy'};

% an array of parameter names to be passed into the table
parameter_names = {'sE', 'sR', 'Dss', 'aEm', 'eta_basal', 'alpha_eta', 'beta_eta', 'fM',...
    'fMa', 'Jnew', 'k', 'b', 'c', 'e1', 'e2', 'alphaB', 'deltaB', 'Ghb', 'R0', 'G0', 'SI',...
    'sigmaI', 'deltaI', 'GI', 'Qpanc', 'bDE', 'bIR', 'aE', 'aR', 'Tnaive', 'bP', 'ram',...
    'thetaD', 'd', 'bE', 'bR', 'muBP', 'muPB', 'fD', 'ftD', 'muE', 'muR', 'muB', 'Qblood',...
    'mustarSB', 'munormalSB', 'muBSE', 'aI', 'aD', 'Bconv', 'Qspleen', 'thetashut', 'Ds', 'tDs', 'dummy'}';

% count through number of parameters in this efast algorithm
ID = (1:length(efast_var))';
% make a table that matches ID to the parameter and the parameter ranges
model_table = table(ID, parameter_names, pmin, pmax);
% save the table as a .csv file !
writetable(model_table, 'Model_efast_table.csv', 'Delimiter', ',');

% Set the baseline values for the parameters

%==============================
% PARAMETER BASELINE VALUES====
%==============================
baseline=[
1 %sE
36 % sR
1*10^5 % Dss
0.01 % aEm

0.02 %eta_basal
0.1 % alpha_eta
22 % beta_eta

1 % fMs
1 % fMas

3.2333*10^3 % Jnew
0.4 % k
0.09 % b
0.117 % c
1*10^-8 % e1
1*10^-8 % e2

0.0334 % alphaB
0.0167 % deltaB
90 % Ghb
864 % R0
1.44 % G0
0.72 % SI
43.2 % sigmaI
432 % deltaI
sqrt(20000) % GI

0.194 % Qpanc
0.487*10^-5 % bDE
0.487*10^-5 % bIR
0.1199 % aE
0.1199 % aR
370 % Tnaive

12 % bP
0.01 % ram
2.12*10^5 % thetaD
0.5 %d

1*10^-3 % bE
1*10^-3 % bR
0.1 % muBP
0.51 % muPB

5 % fDs
5 % ftDs

2*10^-6 % muE
2*10^-6 % muR
74.56 % muB

3 % Qblood
0.012 % mustarB
0.112 % munormalSB
0.022 % muBSE
0.2310 % aI
0.2310 % aD

2.59*10^5 % Bconv
0.1 % Qspleen
13.65 % thetashut

0 % Ds
0 % tDs

1 % dummy
];

%=====================
% Initial values =====
%=====================
EndTime = 1000;
Tspan = [0 EndTime]; %time in days
wave = 1;

