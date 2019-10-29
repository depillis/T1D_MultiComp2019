% This code will generate a heatmap of your parameter combinations and the
% glucose readings that have been retrieved from the variance of the
% parameters. The colours in the heatmap depends if the mouse gets sick or
% not, based on the glucose reading.

% ex) heatmap('LHS.csv', 1)
% The LHS file is the LHS.csv file generated from formLHS.m, and the second
% argument is the strength of the apoptotic wave. In this case, w = 1.

% Amber Nguyen, code adapted from An Do

function heatmap( LHSfile, wavestrength)

%output: compare the heatmap and area between 2 contours
% as function of wave 

% open the LHS.csv file
LHS = csvread(LHSfile);
nmat = sqrt(size(LHS,1));

% retrieve alpha_e values generated from LHS
alpha_eta = reshape(LHS(:,1),nmat,nmat); 
% retrieve beta_e values generated from LHS
beta_eta = reshape(LHS(:,2),nmat,nmat); 

% load corresponding csvfiles from the wavestrength that was passed

if wavestrength == 0
        file = csvread(['nowave.csv']);
        wavetitle = 'No apoptotic wave';
elseif wavestrength == 0.5
        file = csvread(['wave_05.csv']);
        wavetitle = ['Wave = ', num2str(wavestrength)] ; 
else 
        file = csvread(['wave_1.csv']);
        wavetitle = ['Wave = ', num2str(wavestrength)] ;
end

    % each <wave>.csv file contains the glucose reading and time of
    % diabetes onset
    
    % retrieve glucose readings
    glucose = reshape(file(:,2), nmat, nmat);
    % retrieve time of diabetes onset
    time_sick = reshape(file(:,1), nmat, nmat);
    
    
    %---------------- heat map glucose 
    
    % limit glucose readings from 100 mg/dl to 300 mg/dl
    clims = [100 300];
    
    % create a heatmap based on glucose readings from 100 mg/dl to 300
    % mg/dl with alpha-e values on x-axis and beta-e values on y-axis
    imagesc(LHS(:,1),LHS(:,2),glucose, clims); 
    
    hold on; 
    
    %---------------- contour glucose
    
    glu_levels = [1, 250]; 
    gluheat = contour(alpha_eta, beta_eta, glucose, glu_levels,...
        'LineWidth',3,'EdgeColor', 'cyan');
    clabel(gluheat,'Color','cyan','FontSize',15)
    
   
    hold on;
    
    %------------- contour timesick
    time_levels = [1, 142.8]; % levels of Time_Sick 
    timeheat = contour(alpha_eta, beta_eta, time_sick,time_levels,...
        'LineWidth',3, 'EdgeColor','magenta');
    clabel(timeheat,'Color','magenta','FontSize',15)
%   c = colorbar;
%   c.Label.String = 'Glucose level';
    xlabel('alpha-eta'); 
    ylabel('beta-eta');
    str = [wavetitle];
    title(str);
    set(gca,'YDir','normal', 'FontSize', 20);


    
end