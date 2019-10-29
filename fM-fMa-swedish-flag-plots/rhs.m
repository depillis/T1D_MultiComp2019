function dy = rhs(t,y,fMat,fMt, WaveOn)

% Call paramsmulti.m script
Parameters;

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


% no eta function within the GW paper; it only exists as a parameter

%========================
%  Helper functions  ====
%========================


% Wave function --> (included as supplementary equation in 4.13)
W = WaveOn*.1*B*exp(-((t-9)/9)^2);

%eta_vary function
eta_vary = eta_basal+2*eta_basal*(1 + tanh(alpha_eta*(t - beta_eta*7)));

%muSB(D)
muSB_D = mustarSB + deltamu/(1+Ds/thetashut);

%muSB(tD)
muSB_tD = mustarSB + deltamu/(1+tDs/thetashut);

%========================
%  ODEs  ================
%========================

% dDs/dt = (4.1) in the GW thesis
dy(1) = muB*(Qblood/Qspleen)*Db - aD*Ds - bDE*Ds.*Es;

% dtDs/dt = (4.2) in the GW thesis
dy(2) = muB*(Qblood/Qspleen)*tDb - aI*tDs - bIR*tDs.*Rs;

% dEs/dt = (4.3) in the GW thesis
dy(3) = muBSE*(Qblood/Qspleen)*Eb - muSB_D.*Es + bE*Ds*Ems...
    + aE*((Tnaive/Qspleen)-Es) - muE*Es.*Rs - ram*Es + bP*((Ds.*Es)./(thetaD+Ds));

% dRs/dt = (4.5) in the GW thesis
dy(4) = muBSE*(Qblood/Qspleen)*Rb - muSB_tD.*Rs + bR*tDs.*Ems + aR*((Tnaive/Qspleen) - Rs)...
    - muE*Es.*Rs - ram*Rs + bP*(tDs.*Rs)./(thetaD + tDs);
    

% dEms/dt = (4.6) in the GW thesis
dy(5) = muBSE*(Qblood/Qspleen)*Emb - muSB_D.*Ems + ram*(Es+Rs) - (aEm+bE*Ds+bR*tDs).*Ems;

% dDb/dt = (4.7) in the GW thesis
dy(6) = -muB*Db + muPB*(Qpanc/Qblood)*Dpanc;

% dtDb/dt = (4.8) in the GW thesis
dy(7) = -muB*tDb + muPB*(Qpanc/Qblood)*tDpanc;

% dEb/dt = (4.9) in the GW thesis
dy(8) = muSB_D.*(Qspleen/Qblood)*Es + muPB*(Qpanc/Qblood)*Epanc - (muBP + muBSE)*Eb;

% dRb/dt = (4.10) in the GW thesis
dy(9) = muSB_tD.*(Qspleen/Qblood).*Rs + muPB*(Qpanc/Qblood)*Rpanc - (muBP + muBSE)*Rb;

% dEmb/dt = (4.11) in the GW thesis
dy(10) = muSB_D.*(Qspleen/Qblood)*Ems + muPB*(Qpanc/Qblood)*Empanc - (muBP+muBSE)*Emb;

% dMb/dt = (4.12) in the GW thesis
dy(11) = -Jnew + cnew*(Qpanc/Qblood)*M;

% dB/dt = (4.13) in the GW thesis
dy(12) = (alphaB*G.^2./(G.^2+Ghb^2)).*B - deltaB*B - W...
    - eta_vary*((sE*Epanc).^2./(1+(sE*Epanc).^2+(sR*Rpanc).^2)).*B;

% dBa/dt = (4.14) in the GW thesis
dy(13) = W*Bconv/Qpanc + eta_vary*((sE*Epanc)^2./(1+(sE*Epanc).^2 + (sR*Rpanc).^2)).*B*Bconv/Qpanc...
    - fMt*M.*Ba-fMat*Ma.*Ba - d*Ba + deltaB*B*Bconv/Qpanc - ftD*(Dss-Dpanc).*Ba - fD*Dpanc.*Ba;

% dBn/dt = (4.15) in the GW thesis
dy(14) = d*Ba-fMt*M.*Bn - fMat*Ma.*Bn - ftD*(Dss-Dpanc).*Bn - fD*Dpanc.*Bn;

% dDpanc/dt = (4.16) in the GW thesis
dy(15) = ftD*Bn.*(Dss - Dpanc) - muPB*Dpanc;

% dtDpanc/dt = (4.17) in the GW thesis
dy(16) = ftD*Ba.*(Dss - Dpanc - tDpanc) - ftD*Bn.*tDpanc - muPB*tDpanc;

% dEpanc/dt = (4.18) in the GW thesis
dy(17) = muBP*Eb*(Qblood/Qpanc) - muPB*Epanc;

%dRpanc/dt = (4.19) in the GW thesis
dy(18) = muBP*Rb*(Qblood/Qpanc) - muPB*Rpanc;

%DEmpanc/dt = (4.20) in the GW thesis
dy(19) = muBP*Emb*(Qblood/Qpanc) - muPB*Empanc;

%dM/dt = (4.21) in the GW thesis
dy(20) = Jnew*(Qblood/Qpanc) + (k+b)*Ma-cnew*M - fMt*M.*Ba - fMt*M.*Bn - e1*M.*(M+Ma);

%dMa/dt = (4.22) in the GW thesis
dy(21) = fMt*M.*Ba + fMt*M.*Bn - k*Ma - e2*Ma.*(M+Ma);

%dG/dt = (4.23) in the GW thesis
dy(22) = R0 - (G0 + (SI*I)).*G;

%dI/dt = (4.24) in the GW thesis
dy(23) = sigmaI*(G.^2/(G.^2 + GI.^2))*B - deltaI*I;

end