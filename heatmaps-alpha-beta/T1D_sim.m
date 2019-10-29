% run simulation for each value for alpha-eta and beta-eta parameters from
% the multicompartmental model, in NOD mice.
% prior to running this file, create LHS.csv using formLHS routine
% undergrad team 28 june 2019, code adapted from an do.

function T1D_sim(lhsfilename)

% T1Dsim takes in LHS.csv file
% for example T1Dsim('LHS.csv', 0.01)

%Initial values
EndTime = 1000;
Tspan = [0 EndTime]; % time in days
IC = [0 0 0 0 0 0 0 0 0 0 4.77*10^5 300 0 0 0 0 0 0 0 0 0 100 10];% start at the healthy rest state, using Topp healthy rest state for beta cells, glucose, insulin

% read the LHS file
LHS = csvread(lhsfilename);
% get the total number of values
n = size(LHS, 1); 

% no apoptotic wave, apoptotic wave = 0.5, apoptotic wave = 1
wave = [0, 0.5, 1]; 

% loop through each number from the total number of values
for i = 1 : n
    
% make an LHS of the alpha and beta parameter from the eta function

alpha = LHS(i, 1);
beta = LHS(i, 2);

% update the parameter values
setappdata(0, 'alpha_var', alpha);
setappdata(0, 'beta_var', beta);                        
                          
%update parameter file (paramsmulti) then feed into ODE                          
paramsmulti;
                         
                          
%------------------------no wave---------------------%
options=odeset('Events',@sickEvents); % will know when mouse gets sick
[TnWave, YnWave, Te] = ode15s(@(t,y)rhs(t, y, fMan, fMn, wave(1)), Tspan, IC, options); % Solve ODE

% convert time into days
Time_sick=Te./7;

% retrieve end glucose levels
glucose = YnWave(:,22); 

if isempty(Time_sick) == 1
    Time_sick = EndTime./7; %If the event finder did not return anything
    %then the glucose has not reached 250 during this simulation, so just
    %get the last time value.
end

% make a new csv file, with the first column containing the onset for
% diabetes and the second column being the end glucose level.
dlmwrite('nowave.csv', [Time_sick(1) glucose(end)],'-append');


%---------------------with wave = 0.5--------------------------%
options=odeset('Events',@sickEvents);
[TnWave, YnWave, Te] = ode15s(@(t,y)rhs(t, y, fMan, fMn, wave(2)), Tspan, IC, options); % Solve ODE

Time_sick=Te./7;
glucose = YnWave(:,22); 

if isempty(Time_sick) == 1
    Time_sick = EndTime./7; %If the event finder did not return anything
    %then the glucose has not reached 250 during this simulation, so just
    %get the last time value.
end

dlmwrite('wave_05.csv', [Time_sick(1) glucose(end)],'-append');


%---------------------with wave = 1--------------------------%
options=odeset('Events',@sickEvents);
[TnWave, YnWave, Te] = ode15s(@(t,y)rhs(t, y, fMan, fMn, wave(3)), Tspan, IC, options); % Solve ODE

Time_sick=Te./7;
glucose = YnWave(:,22); 

if isempty(Time_sick) == 1
    Time_sick = EndTime./7;
end

dlmwrite('wave_1.csv', [Time_sick(1) glucose(end)], '-append');


end 

end