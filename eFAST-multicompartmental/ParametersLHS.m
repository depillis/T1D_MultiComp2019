% This code contains the parameters from the multicompartmental model, and
% the order of the parameters correspond to the one in the undergraduate
% summer 2019 report.

% Amber Nguyen, code adapted from An Do. Implemented for the
% multicompartmental model.
%==========================================================;
%Parameter values and definitions pulled from GW Thesis;
%==========================================================;

 % Fixed parameters 
scale_factor = 0.0623; % works for scale factor between .0604 and .0635 (to that many sig figs)

% Clearance rates for BalbC and NOD mouse are our control values

%BalbC parameters: 
 fMb_scale = 2; fMab_scale = 5;
 fMb  = scale_factor*fMb_scale*10^(-5); %ml cell^-1d^-1 %wt basal phagocytosis rate per M
 fMab  = scale_factor*fMab_scale*10^(-5);%ml cell^-1d^-1 %wt activated phagocytosis rate per Ma

%NOD parameters
 fMn_scale =1; fMan_scale = 1;
 fMn = scale_factor*fMn_scale*10^(-5); %ml cell^-1d^-1 %nod basal phagocytosis rate per M 
 fMan = scale_factor*fMan_scale*10^(-5); %ml cell^-1d^-1 % nod activated phagocytosis rate per Ma 


% An's modification:
% setappdata was set in the main executing file
% Parameter file use getappdata to call back the values assign in the main
% file. 

% An's modification: eFAST routine 
% Assume f1s and f2s to be fixed at NOD values
% While other parameters from the U-subset

% Amber 19 July modification: The Qblood, Bconv, and Qspleen parameters do
% not actually vary. I had to assign them variation anyways for ID
% purposes.


%% eFAST parameters assignment 
sE = getappdata(0, 'sE_var'); % Relative impact of effector T cells on beta-cell death - mL/cells;
sR = getappdata(0, 'sR_var'); % Relative impact of regulatory T cells on Beta cell death - mL/cells;
Dss = getappdata(0, 'Dss_var'); % Steady state dendritic cell population - cells/mL
aEm = getappdata(0, 'aEm_var'); % Death rate of memory T cells - 1/day;

% eta function
eta_basal = getappdata(0, 'etabasal_var'); % Effectiveness of effectors - 1/day
alpha_eta = getappdata(0, 'alphaeta_var'); % This value seems to control the jump slope - 1/day
beta_eta = getappdata(0, 'betaeta_var'); % Affects time to become sick - 1/day

% clearance rates
fMs = getappdata(0, 'fMs_var');
fMas = getappdata(0, 'fMas_var');
fMt = scale_factor*fMs*10^(-5); % basal phagocytosis rate per macrophage - mL/cell/day
fMat = scale_factor*fMas*10^(-5); % activated phagocytosis rate per activated macrophage - mL/cell/day

Jnew = getappdata(0, 'Jnew_var'); % normal resting macrophage influx rate: cells / mL / day;
k = getappdata(0, 'k_var'); % Ma deactivation rate - 1/day;
b = getappdata(0, 'b_var'); % Recruitment rate of macrophages by activated macrophages - 1/day;
c = getappdata(0, 'c_var'); % macrophage egress rate - 1/day;
e1 = getappdata(0, 'e1_var'); % Effect of crowding on macrophaes - 1/cell/day;
e2 = getappdata(0, 'e2_var'); % Effect of crowding on activated macrophages - 1/cell/day;

alphaB = getappdata(0, 'alphaB_var'); % Beta-cell growth rate - 1/day;
deltaB = getappdata(0, 'deltaB_var'); % Beta-cell death rate - 1/day;
Ghb = getappdata(0, 'Ghb_var'); % Glucose level of half-max beta-cell production - mg/dl;
R0 = getappdata(0, 'R0_var'); % Basal rate of glucose production - mg/dl;
G0 = getappdata(0, 'G0_var'); % Rate of glucose decay - 1/day;
SI = getappdata(0, 'SI_var'); % Rate of glucose elimination via insulin - mL/microU/day;
sigmaI = getappdata(0, 'sigmaI_var'); % Maximum rate of insulin production by beta-cells - microU/mL/day/mg;
deltaI = getappdata(0, 'deltaI_var'); % Rate of insulin decay - 1/day;
GI = getappdata(0, 'GI_var'); % Glucose level of half-max insulin production - mg/dl;

Qpanc = getappdata(0, 'Qpanc_var'); % Volume of mouse pancreas - mL;
bDE = getappdata(0, 'bDE_var'); % Rate of elimination of DC's by effector T cells - mL/cells/day;
bIR = getappdata(0, 'bIR_var'); % Rate of elimination of tDC's by regulatory T cells - ml/cells/day;
aE = getappdata(0, 'aE_var'); % Rate of initial expansion of naive T-cells to effector T-cells - 1/day;
aR = getappdata(0, 'aR_var'); % Rate of initial expression of naive T cells into regulatory T cells - 1/day;
Tnaive = getappdata(0, 'Tnaive_var'); % Density of native T cells contributing to initial production of T_effs and T_regs in the spleen - cells/mL;

bP = getappdata(0, 'bP_var'); % Maximum expansion rate of effector T-cells due to DC's - 1/day;
ram = getappdata(0, 'ram_var'); % Reversion rate of T_eff and T_reg cells to memory T cells - 1/day;
thetaD = getappdata(0, 'thetaD_var'); % DC value for half-maximal effector T cell expansion - 1/day;
d = getappdata(0, 'd_var'); % Beta cell rate of necrosis - 1/day;

bE = getappdata(0, 'bE_var'); % Activation rate of effector T cells from meory T cells - (ml*day)/cells;
bR = getappdata(0, 'bR_var'); % Activation rate for regulatory T cells from memory T cells - (mL*day)/cells;
muBP = getappdata(0, 'muBP_var'); % emigration rate of DC's and T-cells from the blood to the pancreas - 1/day;
muPB = getappdata(0, 'muPB_var'); % emigration rate of DC's and T-cells from the pancreas to blood - 1/day;

DCtoM = 5.49 * 10^(-2);
tDCtoM = 3.82 * 10^(-1);
fDs = getappdata(0, 'fDs_var');
ftDs = getappdata(0, 'ftDs_var');
fD = fDs*DCtoM*scale_factor*10^(-5); % Rate activated DC's engulf beta cells - mL/cells/day;
ftD = ftDs*tDCtoM*scale_factor*10^(-5); % Rate native or tolerogenic DC's engulf beta cells - mL/cells/day;

muE = getappdata(0, 'muE_var'); % Rate of effector T cell removal due to competition - 1/day;
muR = getappdata(0, 'muR_var'); % Regulatory T cell removel due to competition - 1/day;
muB = getappdata(0, 'muB_var'); % Dendritic cell emigration rate from blood to spleen: 1/day;

Qblood = getappdata(0, 'Qblood_var'); % Volume of mouse blood comaprtment - mL;
mustarSB = getappdata(0, 'mustarSB_var'); % CTL migration rate from spleen to blood at equilibrium: 1/day;
munormalSB = getappdata(0, 'munormalSB_var'); % normal CTL migration rate from spleen to blood: 1/day;
muBSE = getappdata(0, 'muBSE_var'); % T-Cell emigration rate from blood to spleen - 1/day;
aI = getappdata(0, 'aI_var'); % Death rate of tolerogenic DC's in the spleen - 1/day;
aD = getappdata(0, 'aD_var'); % Death rate of immunogenic DC's in the spleen - 1/day;

Bconv = getappdata(0, 'Bconv_var'); % Beta cells per miligram - cells/mg;
Qspleen = getappdata(0, 'Qspleen_var'); % Volume of mouse spleen - ml;
thetashut = getappdata(0, 'thetashut_var'); % Scaled threshold in DC density in the spleen for half-maximal transfer rate from spleen to blood - cells/mL;

%% TIME SPAN OF THE SIMULATION

t_end=1000; % length of the simulations
tspan=(0:1:t_end);   % time points where the output is calculated

%=========================================
% INITIAL CONDITION FOR THE ODE MODEL=====
%=========================================
% the starting conditions for Ds and tDs are varied.

Ds0 =  getappdata(0, 'Ds_var');
tDs0 = getappdata(0, 'tDs_var');
Es0 = 0;
Rs0 = 0;
Ems0 = 0;
Db0 = 0;
tDb0 = 0;
Eb0 = 0;
Rb0 = 0;
Emb0 = 0;
Mb0 = 4.77*10^5;
B0 = 300;
Ba0 = 0;
Bn0 = 0;
Dpanc0 = 0;
tDpanc0 = 0;
Epanc0 = 0;
Rpanc0 = 0;
Empanc0 = 0;
M0 = 0;
Ma0 = 0;
G_0 = 100;
I0 = 10;

y0=[Ds0, tDs0, Es0, Rs0, Ems0, Db0, tDb0, Eb0, Rb0, Emb0, Mb0, B0, Ba0, Bn0, Dpanc0, tDpanc0, ...
    Epanc0, Rpanc0, Empanc0, M0, Ma0, G_0, I0];

% Variables Labels
y_var_label={'Ds', 'tDs', 'Es', 'Rs', 'Ems', 'Db', 'tDb', 'Eb', 'Rb', 'Emb', 'Mb', ...
    'B', 'Ba', 'Bn', 'Dpanc', 'tDpanc', 'Epanc', 'Rpanc', 'Empanc', 'M', 'Ma', 'G', 'I'};

