function sol = odesolve(tmax,parname,percent, LHS, rownum)

% INPUT:
% tmax: time for ode solver
% parname: name of parameter currently being changed
% percent: percent of change 
% LHS: LHS matrix 
% rownum: row index of LHS matrix that needs for simuluation 

% ---------------  Initial conditions --------------- %
Ds0 = 0; tDs0 = 0; Es0= 0; Rs0=0; Ems0 =0; Db0= 0; tDb0 = 0; 
Eb0=0; Rb0=0; Emb0= 0; Mb0= 4.77*10^5; B0 = 300; 
Ba0= 0; Bn0=0; Dpanc0=0; tDpanc0=0; Epanc0=0;Rpanc0=0 ; Empanc0=0; 
M0 = 0; Ma0=0; G_0=100; I0 = 10; 

IC = [Ds0, tDs0, Es0, Rs0, Ems0, Db0, tDb0, Eb0, Rb0, Emb0, Mb0, B0,...
    Ba0, Bn0, Dpanc0, tDpanc0, Epanc0, Rpanc0, Empanc0, M0, Ma0, G_0, I0]; 

% --------------------------------------------------- %

par = parameters(LHS,rownum); % load a vector of parameter values from the current row in the LHS matrix

% load each parameter from vector;
% turn this into a script
sE = par(1);
sR = par(2);
Dss = par(3);
aEm = par(4);
eta_basal = par(5);
alpha_eta = par(6);
beta_eta = par(7);
fM = par(8);
fMa = par(9);
Jnew = par(10);
k = par(11);
b = par(12);
cnew = par(13);
e1 = par(14);
e2 = par(15);
alphaB = par(16);
deltaB = par(17);
Ghb = par(18);
R0 = par(19);
G0 = par(20);
SI = par(21);
sigmaI = par(22);
deltaI = par(23);
GI = par(24);
Qpanc = par(25);
bDE = par(26);
bIR = par(27);
aE = par(28);
aR = par(29);
Tnaive = par(30);
bP = par(31);
ram = par(32);
thetaD = par(33);
d = par(34);
bE = par(35);
bR = par(36);
muBP= par(37);
muPB = par(38);
fD = par(39);
ftD = par(40);
muE = par(41);
muR = par(42);
muB = par(43); 
Qblood = par(44);
mustarSB= par(45);
munormalSB= par(46);
muBSE = par(47);
aI = par(48);
aD = par(49);
Bconv = par(50);
Qspleen = par(51);
thetashut = par(52);
deltamu = munormalSB-mustarSB;


wave = 1;
noWave = 0;

PP = 0;
eval(['PP = ' parname{1} ';'])

for i = -1:1
    
    eval([parname{1} '= (1+i*(' num2str(percent) '/100))*PP;']) %Increase or decrease the parameter value

    % Solve the Model to TMAX days
    options = odeset('Refine',1,'RelTol',1e-9);
    [t,y] = ode15s(@(t,y)rhs(t, y, fMa, fM, wave),[0;tmax],IC,options); %simulate the model with the changed parameter

    sol(i+2) = y(end,22); % add glucose level to the output vector
end

return
    % MODEL - same as the model in the multicompartmental eta function
    function dy = rhs(t, y ,fMat, fMt, WaveOn)

    dy = zeros(23,1);
    
    Ds = y(1);
    tDs = y(2);
    Es = y(3);
    Rs = y(4);
    Ems = y(5);

    Db = y(6);
    tDb = y(7);
    Eb = y(8);
    Rb = y(9);
    Emb = y(10);
    Mb = y(11);

    B = y(12);
    Ba = y(13);
    Bn = y(14);

    Dpanc = y(15);
    tDpanc = y(16);
    Epanc = y(17);
    Rpanc = y(18);
    Empanc = y(19);

    M = y(20);
    Ma = y(21);

    G = y(22);
    I = y(23);

    % Wave function --> (included as supplementary equation in 4.13)
    W = WaveOn*.1*B*exp(-((t-9)/9)^2);

    %eta_vary function
    eta_vary = eta_basal+2*eta_basal*(1 + tanh(alpha_eta*(t - beta_eta*7)));

    %muSB(D)
    muSB_D = mustarSB + deltamu/(1+Ds/thetashut);

    %muSB(tD)
    muSB_tD = mustarSB + deltamu/(1+tDs/thetashut);
    
    % dDs/dt = (4.1) in the GW thesis
    dy = [(muB*(Qblood/Qspleen)*Db - aD*Ds - bDE*Ds.*Es);...
        (muB*(Qblood/Qspleen)*tDb - aI*tDs - bIR*tDs.*Rs);...
        (muBSE*(Qblood/Qspleen)*Eb - muSB_D.*Es + bE*Ds*Ems...
        + aE*((Tnaive/Qspleen)-Es) - muE*Es.*Rs - ram*Es + bP*((Ds.*Es)./(thetaD+Ds)));...
        (muBSE*(Qblood/Qspleen)*Rb - muSB_tD.*Rs + bR*tDs.*Ems + aR*((Tnaive/Qspleen) - Rs)...
        - muE*Es.*Rs - ram*Rs + bP*(tDs.*Rs)./(thetaD + tDs));...
        (muBSE*(Qblood/Qspleen)*Emb - muSB_D.*Ems + ram*(Es+Rs) - (aEm+bE*Ds+bR*tDs).*Ems);...
        (-muB*Db + muPB*(Qpanc/Qblood)*Dpanc);...
        (-muB*tDb + muPB*(Qpanc/Qblood)*tDpanc);...
        (muSB_D.*(Qspleen/Qblood)*Es + muPB*(Qpanc/Qblood)*Epanc - (muBP + muBSE)*Eb);...
        (muSB_tD.*(Qspleen/Qblood).*Rs + muPB*(Qpanc/Qblood)*Rpanc - (muBP + muBSE)*Rb);...
        (muSB_D.*(Qspleen/Qblood)*Ems + muPB*(Qpanc/Qblood)*Empanc - (muBP+muBSE)*Emb);...
        (-Jnew + cnew*(Qpanc/Qblood)*M);...
        ((alphaB*G.^2./(G.^2+Ghb^2)).*B - deltaB*B - W...
        - eta_vary*((sE*Epanc).^2./(1+(sE*Epanc).^2+(sR*Rpanc).^2)).*B);...
        (W*Bconv/Qpanc + eta_vary*((sE*Epanc)^2./(1+(sE*Epanc).^2 + (sR*Rpanc).^2)).*B*Bconv/Qpanc...
        - fMt*M.*Ba-fMat*Ma.*Ba - d*Ba + deltaB*B*Bconv/Qpanc - ftD*(Dss-Dpanc).*Ba - fD*Dpanc.*Ba);...
        (d*Ba-fMt*M.*Bn - fMat*Ma.*Bn - ftD*(Dss-Dpanc).*Bn - fD*Dpanc.*Bn);...
        (ftD*Bn.*(Dss - Dpanc) - muPB*Dpanc);...
        (ftD*Ba.*(Dss - Dpanc - tDpanc) - ftD*Bn.*tDpanc - muPB*tDpanc);...
        (muBP*Eb*(Qblood/Qpanc) - muPB*Epanc);...
        (muBP*Rb*(Qblood/Qpanc) - muPB*Rpanc);...
        (muBP*Emb*(Qblood/Qpanc) - muPB*Empanc);...
        (Jnew*(Qblood/Qpanc) + (k+b)*Ma-cnew*M - fMt*M.*Ba - fMt*M.*Bn - e1*M.*(M+Ma));...
        (fMt*M.*Ba + fMt*M.*Bn - k*Ma - e2*Ma.*(M+Ma));...
        (R0 - (G0 + (SI*I)).*G);...
        (sigmaI*(G.^2/(G.^2 + GI.^2))*B - deltaI*I)];
    end

end

