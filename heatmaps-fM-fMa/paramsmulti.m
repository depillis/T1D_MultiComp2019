% This code contains the parameters with their baseline values from the
% multicompartmental model, with the exception of the two parameters we are
% interested in varying.

%MM on 06.20.19 Parameter values for multicompartmental model
% updated parameter names, values, and units come from Table 4.4 in Gianna Wu Thesis;
%Amber 07.26.19 Parameter order now matches the one on the REU report.

%==========================================================;
%Parameter values and definitions pulled from GW Thesis;
%==========================================================;

sE = 1; %Relative impact of effector T cells on Beta cell death: ml/cells;
sR = 36; %Relative impact of regulatory T cells on Beta cell death: ml/cells;
Dss = 1*10^5; %Steady-state DC population: cells/ml;
aEm = 0.01; %Death rate of memory T cells: 1/day

eta_basal = 0.02; % Effectiveness of effectors - 1/day
alpha_eta = 0.11; % This value seems to control the jump slope - 1/day
beta_eta = 21; % Affects time to become sick - 1/day

fM = getappdata(0,'fM_var'); % read from LHS
fMa = getappdata(0,'fMa_var'); % read from LHS
fMs = 0.0623*fM*10^(-5); % basal phagocytosis rate per macrophage - mL/cell/day
fMas = 0.0623*fMa*10^(-5); % activated phagocytosis rate per activated macrophage - mL/cell/day

Jnew = 3.2333*(10^3); %normal resting macrophage influx: cells / mL / day;
k = 0.4; %Ma deactivation rate: 1/day;
b = 0.09; %Recruitment rate of macrophages by activated macrophages: 1/day;
c = 0.117; %macrophage egress rate; 1/day;
e1 = 1*10^(-8); %Effect of crowding on macrophages: 1/cell day;
e2 = 1*10^(-8); %Effect of crowding on active macrophages: 1/cell day;

alphaB = 0.0334; %Beta-cell growth rate; 1/day;
deltaB = 1/60; %Beta-cell death rate: 1/day;
Ghb = 90; %Glucose level of half-max Beta cell production: mg/dl;
R0 = 864; %Basal rate of glucose production: mg/dl;
G0 = 1.44; %Rate of glucose decay: 1/day;
SI = 0.72; %Rate of glucose elimination via insulin: ml/microU/day;
sigmaI = 43.2; %Maximum rate of insulin production by Beta cells: microU/ml/day/mg;
deltaI = 432; %Rate of insulin decay: 1/day;
GI = sqrt(20000); %Glucose level of half-max insulin production: mg/dl;

Qpanc = 0.194; %Volume of mouse pancreas: ml;
bDE = 0.487*(10^(-5)); %Rate of elimination of DCs by effector T cells: ml/cells/day;]
bIR = 0.487*(10^(-5)); %Rate of elimination of tDCs by regulatory T cells: ml/cells/day;
aE = 0.1199; %rate of initial expansion of naive T-cells to effector T-cells: 1/day;
aR = 0.1199; %Rate of initial expression of naive T cells into regulatory T cells: 1/day;
Tnaive = 370; %Density of naive T cells contributing to initial production of Teff and Treg in the spleen: cells/ml;

bP = 12; %maximum expansion rate of effector T-cells due to DCs: 1/day;
ram = 0.01; %Reversion rate of Teff and Treg cells to memory T cells: 1/day;
thetaD = 2.12*10^5; %DC value for half-maximal effector T cell expansion: 1/day;
d = 0.50; %Beta cell rate of necrosis: 1/day;

bE = 1*(10^(-3)); %Activation rate of effector T cells from memory T cells: (ml*day)/cells
bR = 1*(10^(-3)); %Activation rate for regulatory T cells from memory T cells: (ml*day)/cells
muBP= 0.1; %emigration rate of DCs and T-cells from the blood to the pancreas: 1/day;
muPB = 0.51; %emigration rate of DCs and T-cells from the pancreas to the blood: 1/day;
%muD = 0.51; %Rate of removal from pancreas for DC and tDC: 1/day;

fD = 1.7101*(10^(-7)); %Rate DCs engulf Beta cells: ml/cell day;
ftD = 1.1899*(10^(-6)); %Rate native or tolerogenic DCs engulf Beta cells: ml/cells day;

muE = 2*(10^(-6)); %rate of E removal due to competition: 1/day;
muR = 2*(10^(-6)); %regulatory T-cell removal rate due to competition: 1/day;
muB = 74.56; %Dendritic cell emigration rate from blood to spleen: 1/day;

Qblood = 3.00; %Volume of mouse blood compartment: ml;
mustarSB= 0.012; %CTL migration rate from the spleen to blood at equilibrium: 1/day;
munormalSB=0.1120; %normal CTL migration rate from spleen to blood: 1/day;
muBSE = 0.0220; %T-cell emigration rate from blood to spleen: 1/day;
aI = 0.2310; %Death rate of tolerogenic DCs in the spleen: 1/day;
aD = 0.2310; %Death rate of Immunogenic DCs in the spleen: 1/day;

Bconv = 2.59*10^5; %Beta cells per miligram: cells/mg;
Qspleen = 0.1; %volume of mouse spleen: mL;
thetashut = 13; %Scaled threshold in DC density in the spleen for half-maximal transfer rate from spleen to blood: cells per mL;
