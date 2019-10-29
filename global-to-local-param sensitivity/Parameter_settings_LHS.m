% This file is to set up max/min and baseline values for model parameters.
% Using U-subsetparameters from Parameter report. 
% PARAMETER INITIALIZATION
% set up max and mix matrices of model' parameters 

% minimum values
pmin=[
1      % sE 
10   % sR
1000   %Dss
0.001   %aEmday
0.01   %eta_basal
0.01   %alpha_e
21      %beta_e
0.1 % fms 
0.1 % fmas
48000 % J 
0.4 % k 
0.01 % b 
0.07 %c 
1e-8 % e1
1e-8 % e2
0.02 % alpha_B
1/62 % deltaB
81 % Ghb 
500 % R0 
0.1 % EG0 
0.1 % SI 
30 % sigmaI
460 % deltaI 
sqrt(2e2) % GI 
0.1 % Qpanc 
1e-6 % bDEday
1e-6 % bIRday 
0.1 % aEaday
0.1 % aRaday 
100 % Tnaive 
10 % bpday 
1e-3 % ramday 
1e2 % thetaD
0.5 % d
1e-4 % baEday 
1e-4 % baRday
0.1 % mu_PB
0.01 % mu_BP
1e-6 % fDs
1e-6 %ftDs
1e-6 %mues_r
1e-6 % mues_e
%%
26.976 % muB
3 % Qblood
0.012 % mustarSB
0.1 % munormalSB
0.1 % muBSE
0.173 % aI
0.173 % aD
2.59e5 % Bconv
0.1 % Qspleen
12.35 % thetashut
0 % dummy
];

% maximum values
pmax=[
100      % sE 
100   % sR
1e7   %Dss
0.1   %aEmday
0.03   %eta_basal
0.5   %alpha_e
30      %beta_e
2 % fms 
2 % fmas
50000 % J 
1 % k 
0.1 % b 
0.25 %c 
1e-6 % e1
1e-6 %e2
0.05 % alpha_B
1/58 % deltaB
100 % Ghb 
1000 % R0 
2 % EG0 
1 % SI 
50 % sigmaI
576 % deltaI 
sqrt(2e4) % GI 
0.5 % Qpanc 
1e-5 % bDEday
1e-5 % bIRday 
0.5 % aEaday 
0.5 % aRaday 
500 % Tnaive 
90 % bpday 
1.5 % ramday 
1e5 % thetaD
1 % d 
1e-1 % baEday 
1e-1 % baRday
1 % mu_PB
1% mu_BP
1e-5 % fDs
1e-5 %ftDs
1e-5 % mues_e
1e-5 % mues_r
%%
74.56 % muB
3 % Qblood
0.08 % mustarSB
100 % munormalSB
100 % muBSE
0.346 % aI
0.346 % aD
2.59e5 % Bconv
0.1 % Qspleen
13.65 % thetashut
10 % dummy
];

% Parameter Labels 
% Parameter_var={'sE', 'sR','D_{ss}','a_{Em}','\eta_{basal}','\alpha_e','\beta_e',...
%     'f_m', 'f_{ma}','J','k','b','c','e_1','e_2','\alpha_B','\delta_B','G_{hb}',...
%     'R_0','EG0','S_I','\sigma_I','\delta_I','GI','Q_{panc}',...
%     'b_{DE}','b_{IR}','a_{Ea}','a_{Ra}','T_{n}','b_{p}','r_{am}',...
%     '\theta_D', 'd', 'b_{aE}','b_{aR}','\mu_PB','\mu_BP',...
%     'fDs','ftDs','mues_e','mues_r','dummy'};%,

% PARAMETER BASELINE VALUES

baseline =[
 1 %sE
36 %sR
10^5 %D_ss
0.01 %aEmday 
0.02 %eta_basal
0.11 %alpha_eta
22 %beta_e
1 %fm
1 %fmas
5*10^4 %J =  cells ml^-1d^-1 : normal resting macrophage influx
0.4 %k = d^-1: Ma deactivation rate
0.09  %b = d^-1: recruitment rate of M by Ma
0.1 %c =  d^-1: macrophage egress rate
1*10^(-8) %e1= cell^-1d^-1: anti-crowding terms for macrophages
1*10^(-8) %e2
0.0334  %alpha_B = 
1/60  %delta_B = 
90  %Ghb = 
864  %R0      = mg per dl
1.44  %EG0     = per day
.72  %SI      =  ml per muU per day
43.2  %sigmaI  = muU per ml per day per mg
432  %deltaI  = per day
sqrt(20000) %GI      = mg per dl
.194 %Qpanc =  ml
0.487e-5  %bDEday =  ml/cell/day, per capita elimination rate of DC by CTL
 0.487e-5    %bIRday =ml/cell/day, per capita elimination rate of iDC by Tregs
.1199     % aEaday = per day; BUT I DON'T THINK THIS CAN BE RIGHT!  [ESTIMATED, =ln(2)/(5.78 days)]
0.1199 % aR
370   % T_naive = cells, number of naive cells contributing to primary clonal expansion
12       % bpday = per day, maximal expansion factor of activated CTL
0.01      %ramday =  per day, reversion rate of active CTL to memory CTL
2.12e5 %thetaD =  cells/ml;  Threshold in DC density in the spleen for half maximal proliferation rate of CTL [7.5e2,1.2e4]
0.5  % d    = d^(-1)  rate of apoptotic cell decay into a necrotic cell
10^(-3) %baEday =  BSH distinguish activation rate for effector memory cells by DC
10^(-3) %baRday = BSH distinguish activation rate for Treg memore cell by iDC
0.51 % mu_PB
0.1 % mu_BP
1e-5 % fDs
1e-5 %ftDs
2e-6 % mues_e
2e-6 % mues_r
%%
74.56 % muB
3 % Qblood
0.012 % mustarSB
0.112 % munormalSB
0.22 % muBSE
0.2310 % aI
0.2310 % aD
2.59e5 % Bconv
0.1 % Qspleen
13.65 % thetashut
1 % dummy
];   


%% TIME SPAN OF THE SIMULATION
EndTime=1000; % length of the simulations
tspan=(0:1:EndTime);   % time points where the output is calculated

% INITIAL CONDITION FOR THE ODE MODEL
M = 4.77*10^5;
Ma = 0;
Ba =0 ;
Bn =0 ;
B =300;
G= 100;
I =10;
D =0;
tD=0;
E =0;
R =0;
Em=0;

y0=[M, Ma, Ba, Bn, B, G, I, D , tD, E, R, Em];

% Variables Labels
y_var_label={'M','Ma','Ba','Bn','B','G','I','D','tD','E','R','Em'};