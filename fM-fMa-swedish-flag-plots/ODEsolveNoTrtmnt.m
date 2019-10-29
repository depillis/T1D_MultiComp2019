%LdeP 2019-06-10 Updating to account for updated ODE system and inclusion of eta_e (eta_vary)
%LdeP 2019-06-10 Updating to pass through NOD boolean: NOD==1 is NOD case, NOD==0 is BalbC case.
function sol = ODEsolve(tmax,parname,percent,NOD)

%Get parameter values
Parameters;


%%Set simulation times
Tspan = [0 tmax]; % Time in days, tmax passed through

%%Initial values - remaining populations
IC = [0 0 0 0 0 0 0 0 0 0 4.77*10^5 300 0 0 0 0 0 0 0 0 0 100 10]; % using Topp healthy rest state for beta cells, glucose, insulin;

%Turn on wave
wave = 1;

%%%%%%%%%%%%%%%%%%% Before calling solve, set parameter

%LdeP
PP = eval(parname{1}); % Put original parameter value into PP

for i = -1:1

    %LdeP fill the parameter stored in parname{1} with the adjusted parameter value
    eval([parname{1} '= (1+i*(' num2str(percent) '/100))*PP;']);

%    % Solve the Model to TMAX days
%     options = odeset('Refine',1,'RelTol',1e-9);
%% solve the system without treatment
%    [t,y] = ode15s(@(t,y)model_nod(t,y),[0;tmax],[M0;Ma0;Ba0;Bn0;B0;G0;I0;D0;tD0;E0;Reg0;Em0],options);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Solve ODE
options = odeset('Refine',1,'RelTol',1e-9);
if NOD == 1 	%Solve ODE for NOD case
	[Twave, Ywave] = ode15s(@(t,y)rhs(t,y,fMn,fMan,wave),Tspan,IC,options); % Solve ODE
else 		%Solve ODE for Balb/c
	[Twave, Ywave] = ode15s(@(t,y)rhs(t,y,fMb,fMab,wave),Tspan,IC,options); % Solve ODE
end

%Extract B-cells (mg), Glucose (mg/dl), Insulin (mu-U)
BalbCWave_Bcells  = Ywave(:,5);
BalbCWave_Glucose = Ywave(:,22);
BalbCWave_Insulin = Ywave(:,7);

 	plott{i+2} = Twave;
    	plotsol{i+2} = BalbCWave_Glucose;

%LdeP "sol" is the resulting solution sent back to the calling routine
	
    	sol(i+2) = BalbCWave_Glucose(end);

end %End For

return %End of function

%%%%%%%%%%%%%%%%%%%%END%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
