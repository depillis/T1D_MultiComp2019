% This code assigns a value and an index to each parameter to be used for 
% the loop in Model_efast_T1D.m.

% Amber Nguyen, code adapted from An Do
% Modified for multicompartmental model parameters.
function  assignParameters(X, run_num)

% set parameter values to UI 
% ParametersLHS will get these values 

setappdata(0,'sE_var',X(run_num,1)) %  sE 
setappdata(0,'sR_var',X(run_num,2)) %  sR
setappdata(0,'Dss_var',X(run_num,3)) % Dss 
setappdata(0,'aEm_var',X(run_num,4)) % aEm

setappdata(0,'etabasal_var',X(run_num,5)) %  eta_basal 
setappdata(0,'alphaeta_var',X(run_num,6)) %  alpha_eta
setappdata(0,'betaeta_var',X(run_num,7)) %  beta_eta 

setappdata(0,'fMs_var',X(run_num,8)) %  fMs
setappdata(0,'fMas_var',X(run_num,9)) %  fMas

setappdata(0,'Jnew_var',X(run_num,10)) %  Jnew
setappdata(0,'k_var',X(run_num,11)) %  k
setappdata(0,'b_var',X(run_num,12)) %  b
setappdata(0,'c_var',X(run_num,13)) %  c
setappdata(0,'e1_var',X(run_num,14)) %  e1
setappdata(0,'e2_var',X(run_num,15)) %  e2


setappdata(0,'alphaB_var',X(run_num,16)) % alphaB
setappdata(0,'deltaB_var',X(run_num,17)) %  deltaB
setappdata(0,'Ghb_var',X(run_num,18)) % Ghb
setappdata(0,'R0_var',X(run_num,19)) %  R0
setappdata(0,'G0_var',X(run_num,20)) %  G0
setappdata(0,'SI_var',X(run_num,21)) %  SI
setappdata(0,'sigmaI_var',X(run_num,22)) %  sigmaI
setappdata(0,'deltaI_var',X(run_num,23)) %  deltaI
setappdata(0,'GI_var',X(run_num,24)) %  GI

setappdata(0,'Qpanc_var',X(run_num,25)) %  Qpanc
setappdata(0,'bDE_var',X(run_num,26)) %  bDE
setappdata(0,'bIR_var',X(run_num,27)) %  bIR
setappdata(0,'aE_var',X(run_num,28)) %  aE
setappdata(0,'aR_var',X(run_num,29)) %  aR
setappdata(0,'Tnaive_var',X(run_num,30)) %  Tnaive

setappdata(0,'bP_var',X(run_num,31)) %  bP
setappdata(0,'ram_var',X(run_num,32)) %  ram
setappdata(0,'thetaD_var',X(run_num,33)) %  thetaD
setappdata(0,'d_var',X(run_num,34)) %  d

setappdata(0,'bE_var',X(run_num,35)) %  bE
setappdata(0,'bR_var',X(run_num,36)) %  bR
setappdata(0,'muBP_var',X(run_num,37)) %  muBP
setappdata(0,'muPB_var',X(run_num,38)) %  muPB

setappdata(0,'fDs_var',X(run_num,39)) %  fDs
setappdata(0,'ftDs_var',X(run_num,40)) %  ftDs

setappdata(0,'muE_var',X(run_num,41)) %  muE
setappdata(0,'muR_var',X(run_num,42)) %  muR
setappdata(0,'muB_var',X(run_num,43)) %  muB

setappdata(0,'Qblood_var',X(run_num,44)) % Qblood
setappdata(0,'mustarSB_var',X(run_num,45)) %  mustarSB
setappdata(0,'munormalSB_var',X(run_num,46)) %  munormalSB
setappdata(0,'muBSE_var',X(run_num,47)) %  muBSE
setappdata(0,'aI_var',X(run_num,48)) %  aI
setappdata(0,'aD_var',X(run_num,49)) %  aD

setappdata(0,'Bconv_var',X(run_num,50)) %  Bconv
setappdata(0, 'Qspleen_var', X(run_num, 51)) % Qspleen
setappdata(0, 'thetashut_var', X(run_num, 52)) % thetashut

setappdata(0, 'Ds_var', X(run_num, 53)) % Ds
setappdata(0, 'tDs_var', X(run_num, 54)) % tDs


end

