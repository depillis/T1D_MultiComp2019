% This code will generate a heatmap of your parameter combinations and the
% glucose readings that have been retrieved from the variance of the
% parameters. The colours in the heatmap depends if the mouse gets sick or
% not, based on the glucose reading.

% ex) heatmap('LHS.csv', 1)
% The LHS file is the LHS.csv file generated from formLHS.m, and the second
% argument is the strength of the apoptotic wave. In this case, w = 1.

% Amber Nguyen, code adapted from An Do

function heatmap( LHSfile, wavestrength)

% Ex: heatmap(0.01875, 'LHS.csv',0)
%input
%etavalues = fixed 1 value 
% LHSmat = 'LHS.csv'
% wave strength= fixed value 

%output: compare the heatmap and area between 2 contours
% as function of wave 

LHS = csvread(LHSfile);
nmat = sqrt(size(LHS,1));
fMa = reshape(LHS(:,1),nmat,nmat); 
fM = reshape(LHS(:,2),nmat,nmat); 

% load corresponding csvfiles for each purpose 

% graph heatmap + glucose contour + time contour 


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

    
    glucose = reshape(file(:,2), nmat, nmat);
    time_sick = reshape(file(:,1), nmat, nmat);
    
    
    %---------------- heat map glucose 
     
    clims = [100 300 ];
    imagesc(LHS(:,1),LHS(:,2),glucose, clims); 
    
    hold on; 
    
    %---------------- contour glucose
    
    glu_levels = [1, 250]; 
    gluheat = contour(fMa, fM,glucose, glu_levels,...
        'LineWidth',3,'EdgeColor', 'cyan');
    clabel(gluheat,'Color','cyan','FontSize',15)
    
   
    hold on;
    
    %------------- contour timesick
    time_levels = [1, 142.8]; % levels of Time_Sick 
    timeheat = contour(fMa, fM,time_sick,time_levels,...
        'LineWidth',3, 'EdgeColor','magenta');
    clabel(timeheat,'Color','magenta','FontSize',15)
%   c = colorbar;
%   c.Label.String = 'Glucose level';
    xlabel('fMa'); 
    ylabel('fM');
    str = [wavetitle];
    title(str);
    set(gca,'YDir','normal', 'FontSize', 20);

end





