function parameters = parameters()
%parameters.m
%Function returns matrix of parameters organized by equation in the ODE.
%Also includes initial conditions.

%Initial conditions
% wave = 1;
% noWave = 0;


muB = 26.976; %Dendritic cell emigration rate from blood to spleen: 1/day; Ludewig SD of 5.9/hour
Qblood = 3.00; %Volume of mouse blood compartment: ml;
aD = 0.2310; %Death rate of Immunogenic DCs in the spleen: 1/day;
aI = 0.2310; %Death rate of tolerogenic DCs in the spleen: 1/day;
muBSE = 0.0220; %T-cell emigration rate from blood to spleen: 1/day;
muPB = 0.51; %emigration rate of DCs and T-cells from the pancreas to the blood: 1/day;
muBP= 0.1; %emigration rate of DCs and T-cells from the blood to the pancreas: 1/day;
Jnew = 3.2333*10^3; %normal resting macrophage influx: cells / mL / day;
mustarSB= 0.012; %CTL migration rate from the spleen to blood at equilibrium: 1/day;
munormalSB=0.1120; %normal CTL migration rate from spleen to blood: 1/day;
deltamu = munormalSB - mustarSB; % [munormalSB - mustarSB]: 1/day;
cnew = 0.117; %macrophage egress rate; 1/day;
k = 0.4; %Ma deactivation rate: 1/day;

b = 0.09; %Recruitment rate of macrophages by activated macrophages: 1/day;
fMb = 2*0.0623*10^(-5); %Rates macrophages engulf necrotic and apoptotic Beta cells; Balb/c mice: ml/cells/days;
fMn = 1*0.0623*(10^(-5)); %Rates macrophages engulf necrotic and apoptotic Beta cells; NOD mice: ml/cells/day;

e1 = 1*10^(-8); %Effect of crowding on macrophages: 1/cell day;
e2 = 1*10^(-8); %Effect of crowding on active macrophages: 1/cell day;
alphaB = 0.0334; %Beta-cell growth rate; 1/day;
deltaB = 1/60; %Beta-cell death rate: 1/day;

eta_basal = 0.02; %Rate at which T cells eliminate Beta cells: 1/day;
alpha_eta = 0.11;
beta_eta = 21;

Ghb = 90; %Glucose level of half-max Beta cell production: mg/dl;
sE = 1; %Relative impact of effector T cells on Beta cell death: ml/cells;
sR = 36; %Relative impact of regulatory T cells on Beta cell death: ml/cells;
Bconv = 2.59*10^5; %Beta cells per miligram: cells/mg;
Qpanc = 0.194; %Volume of mouse pancreas: ml;
d = 0.50; %Beta cell rate of necrosis: 1/day;
fMab = 5*0.0623*10^(-5); %Activated phagocytosis rate per activated macrophage; Balb/c mice: ml/cells day;
fMan = 1*0.0623*10^(-5); %Activated phagocytosis rate per activated macrophage; NOD mice: ml/cells day;
ftD = 1.1899*10^(-6); %Rate native or tolerogenic DCs engulf Beta cells: ml/cells day;
%^^^ changed value from Shtylla et al., using GW thesis ^^^;
Dss = 1*10^5; %Steady-state DC population: cells/ml;
fD = 1.7101*10^(-7); %Rate DCs engulf Beta cells: ml/cell day;
%^ changed value from Shtylla et al., using GW thesis ^;
R0 = 864; %Basal rate of glucose production: mg/dl;
G0 = 1.44; %Rate of glucose decay: 1/day;
SI = 0.72; %Rate of glucose elimination via insulin: ml/microU/day;
sigmaI = 43.2; %Maximum rate of insulin production by Beta cells: microU/ml/day/mg;
GI = sqrt(20000); %Glucose level of half-max insulin production: mg/dl;
%^^^ kept value from Shtylla et al. ^^^;
deltaI = 432; %Rate of insulin decay: 1/day;
bDE = 0.487*10^(-5); %Rate of elimination of DCs by effector T cells: ml/cells/day;
muD = 0.51; %Rate of removal from pancreas for DC and tDC: 1/day;
bIR = 0.487*10^(-5); %Rate of elimination of tDCs by regulatory T cells: ml/cells/day;
aE = 0.1199; %rate of initial expansion of naive T-cells to effector T-cells: 1/day;
Tnaive = 370; %Density of naive T cells contributing to initial production of Teff and Treg in the spleen: cells/ml;
Qspleen = 0.1; %volume of mouse spleen: mL;
bP = 12; %maximum expansion rate of effector T-cells due to DCs: 1/day;
thetaD = 2.12*10^5; %DC value for half-maximal effector T cell expansion: 1/day;
ram = 0.01; %Reversion rate of Teff and Treg cells to memory T cells: 1/day;
bE = 1*10^(-3); %Activation rate of effector T cells from memory T cells: (ml*day)/cells
muE = 2*10^(-6); %rate of E removal due to competition: 1/day;
%^^^ changed value from Shtylla et al., using GW thesis ^^^;
aR = 0.1199; %Rate of initial expression of naive T cells into regulatory T cells: 1/day;
bR = 1*10^(-3); %Activation rate for regulatory T cells from memory T cells: (ml*day)/cells
muR = 2*10^(-6); %regulatory T-cell removal rate due to competition: 1/day;
aEm = 0.01; %Death rate of memory T cells: 1/day

%================================;
% Parameters pulled from DePillis 2013;
%================================;
DMax = 400; % (cells/hour)
thetashut = 13; %Scaled threshold in DC density in the spleen for half-maximal transfer rate from spleen to blood: cells per mL;
muBS = 2.832; %Transfer rate of DCs from blood to spleen 1/day
%========================================================;
%user defined variables;
%========================================================;


% Return parameters in appropriate matrix
parameters = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.77*10^5, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 10, muB,Qblood,aD,aI,muBSE,muPB,muBP,Jnew,mustarSB,...
    munormalSB,deltamu,cnew,k,b,fMb,fMn,e1,e2,alphaB,...
    deltaB,eta_basal,alpha_eta,beta_eta,Ghb,sE,sR,Bconv,...
    Qpanc,d,fMab,fMan,ftD,Dss,fD,R0,G0,SI,sigmaI,GI,...
    deltaI,bDE,muD,bIR,aE,Tnaive,Qspleen,bP,thetaD,ram,...
    bE,muE,aR,bR,muR,aEm,thetashut,muBS];

IC = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4.77*10^5, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 100, 10];