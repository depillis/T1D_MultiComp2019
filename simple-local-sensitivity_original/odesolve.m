function sol = odesolve(tmax,parname,percent,wave)

par = parameters();
IC = par(1:23);


muB = par(24);
Qblood = par(25);
aD = par(26);
aI = par(27);
muBSE = par(28);
muPB = par(29);
muBP= par(30);
Jnew = par(31);
mustarSB= par(32);
munormalSB= par(33);
deltamu = par(34);
cnew = par(35);
k = par(36);

b = par(37);
fMb = par(38);
fMn = par(39);

e1 = par(40);
e2 = par(41);
alphaB = par(42);
deltaB = par(43);

eta_basal = par(44);
alpha_eta = par(45);
beta_eta = par(46);

Ghb = par(47);
sE = par(48);
sR = par(49);
Bconv = par(50);
Qpanc = par(51);
d = par(52);
fMab = par(53);
fMan = par(54);
ftD = par(55);
%^^^ changed value from Shtylla et al., using GW thesis ^^^;
Dss = par(56);
fD = par(57);
%^ changed value from Shtylla et al., using GW thesis ^;
R0 = par(58);
G0 = par(59);
SI = par(60);
sigmaI = par(61);
GI = par(62);
%^^^ kept value from Shtylla et al. ^^^;
deltaI = par(63);
bDE = par(64);
muD = par(65);
bIR = par(66);
aE = par(67);
Tnaive = par(68);
Qspleen = par(69);
bP = par(70);
thetaD = par(71);
ram = par(72);
bE = par(73);
muE = par(74);
%^^^ changed value from Shtylla et al., using GW thesis ^^^;
aR = par(75);
bR = par(76);
muR = par(77);
aEm = par(78);

thetashut = par(79);
muBS = par(80);

wave = 1;
noWave = 0;

PP = 0;
eval(['PP = ' parname ';'])

for i = -1:1
    
    eval([parname '= (1+i*(' num2str(percent) '/100))*PP;'])

    % Solve the Model to TMAX days
    options = odeset('Refine',1,'RelTol',1e-9);
    [t,y] = ode15s(@(t,y)rhs(t, y, fMan, fMn, wave),[0;tmax],IC,options); % simulate models
    
    sol(i+2) = y(end,22);
end

return

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

