% First order and total effect indices for a given
% model computed with Extended Fourier Amplitude
% Sensitivity Test (EFAST).
% Andrea Saltelli, Stefano Tarantola and Karen Chan.
% 1999. % "A quantitative model-independent method for global
% sensitivity analysis of model output". % Technometrics 41:39-56

% Amber modification: implemented this code for the multicompartmental
% model from An's single compartmental model code. (29 July 2019)
clear;
close all;

%% efast Parameters setting
Parameter_settings_EFAST_T1D;
K = size(pmax,1); % # of input factors (parameters varied) + dummy parameter


%% INPUT
NR = 30; %: no. of search curves - RESAMPLING
NS = 65; % # of samples per search curve
wantedN=NS*K*NR; % wanted no. of sample points


% OUTPUT
% SI[] : first order sensitivity indices
% STI[] : total effect sensitivity indices
% Other used variables/constants:
% OM[] : vector of k frequencies
% OMi : frequency for the group of interest
% OMCI[] : set of freq. used for the compl. group
% X[] : parameter combination rank matrix
% AC[],BC[]: fourier coefficients
% FI[] : random phase shift
% V : total output variance (for each curve)
% VI : partial var. of par. i (for each curve)
% VCI : part. var. of the compl. set of par...
% AV : total variance in the time domain
% AVI : partial variance of par. i
% AVCI : part. var. of the compl. set of par.
% Y[] : model output

MI = 4; %: maximum number of fourier coefficients
        % that may be retained in calculating the partial
        % variances without interferences between the
        % assigned frequencies



% Computation of the frequency for the group
% of interest OMi and the # of sample points NS (here N=NS)

OMi = floor(((wantedN/NR)-1)/(2*MI)/K);
NS = 2*MI*OMi+1;

if(NS*NR < 65)
    fprintf(['Error: sample size must be >= ' ...
    '65 per factor.\n']);
    return;
end

%% Wave 
wave = 1; 

%% Pre-allocation of the output matrix Y
%% Y will save only the points of interest specified in
%% the vector time_points

time_points=[70 273]; % time points of interest in days

%Y(NS,length(time_points),length(y0),length(pmin),NR)=0;  % pre-allocation


 % pre-allocation glucose signal
Y(NS,length(time_points),1,length(pmin),NR)=0; 



% Loop over k parameters (input factors)
for i=1:K % i=# of replications (or blocks)
    % Algorithm for selecting the set of frequencies.
    % OMci(i), i=1:k-1, contains the set of frequencies
    % to be used by the complementary group.
    
    OMci = SETFREQ(K,OMi/2/MI,i);   
    % Loop over the NR search curves.
    
    for L=1:NR
        % Setting the vector of frequencies OM
        % for the k parameters
        cj = 1;
        for j=1:K
            if(j==i)
                % For the parameter (factor) of interest
                OM(i) = OMi;
            else
                % For the complementary group.
                OM(j) = OMci(cj);
                cj = cj+1;
            end
        end
        % Setting the relation between the scalar
        % variable S and the coordinates
        % {X(1),X(2),...X(k)} of each sample point.
        FI = rand(1,K)*2*pi; % random phase shift
        S_VEC = pi*(2*(1:NS)-NS-1)/NS;
        OM_VEC = OM(1:K); 
        FI_MAT = FI(ones(NS,1),1:K)';
        ANGLE = OM_VEC'*S_VEC+FI_MAT;
        
        X(:,:,i,L) = 0.5+asin(sin(ANGLE'))/pi; % between 0 and 1
        
        % Transform distributions from standard
        % uniform to general.
        
        %%this is what assigns 'our' values rather than 0:1 dist
        X(:,:,i,L) = parameterdist(X(:,:,i,L),pmax,pmin,0,1,NS,'unif'); 
        
        %% Loading Model Parameters
        ParametersLHS;       
        
        % Do the NS model evaluations.
        for run_num=1:NS
            [i run_num L] % keeps track of [parameter run NR]
      
            % Assign parameter values 
             assignParameters(X(:,:,i,L),run_num);
             dummy=X(run_num,end); %dummy variable 
             ParametersLHS; % Load parasmeter values into Paramters file
                            %change name to loadParameters
               
            
            % ODE solver call
            [t,y]=ode15s(@(t,y)ODE_efast(t, y, fMat, fMt, wave),tspan,y0,[]); 
            
%           retrieve glucose level  
            glucose = y(:,22);
%           plot the glucose dynamics  
%           plot(t,glucose);hold on;
             
            % It saves only  at the time points of interest
           Y(run_num,:,:,i,L)=glucose(time_points+1,:);
        
        end %run_num=1:NS
    end % L=1:NR
end % i=1:k

% output file
save Model_efast.mat; % save the structure Y


% Calculate Coeff. of Var. for Si and STi for Viral load (variable 4). See
% online Supplement A.5 for details.
%[CVsi CVsti]=CVmethod(Si, rangeSi,Sti,rangeSti,4)
