% rankingSI_STi.m will filter out parameters that are less significant than
% the dummy parameter (p-value > 0.05), then arrange the SI's/STi's of the
% significant parameters in descending order on a histogram.

% Amber Nguyen, code adapted from An Do who originally wrote this for the
% single compartment model
function rankingSI_STi(filename, num_var,outcomeindex)

% filename= model_efast.mat from model_efast_T1D routine 
% num_var =1 number of outcome model, ususally 1 bc we only
        % interested in glucose signal 
% oucomeindex = 1 % model outcome index. 
        % in the case we run a full model than we need to specify 
        % the model outcome that we want to see Si and Sti for 
        
% Ex: rankingSI_STi('Model_efast.mat', 1, 1)
load(filename);
Parameter_settings_EFAST_T1D;

y_var= num_var; % number of model outcomes that we are interested 
           % in doing sensitivity analysi 

% CALCULATE Si AND STi for each resample (1,2,...,NR) [ranges]
[Si,Sti,rangeSi,rangeSti] = efast_sd(Y,OMi,MI,time_points,1:y_var);


% T-test on Si and STi for Viral load (variable 4)
s_T1D = efast_ttest(Si,rangeSi,Sti,rangeSti,1:length(time_points),...
    efast_var,y_var,y_var_label,0.05);

% Table for Si 
u= outcomeindex; % model outcome index

%============================
% SI WEEK 10 ================
%============================

% retrieve first order sensivity indexes for each parameter
SI_wk10 = s_T1D.Si(:,1,u);
% retrieve the p-values for each parameter
pvalues_wk10 = [s_T1D.p_Si(:,:,1,u);NaN];
% create a table where the sensitivity index is in the first column and the
% p-value is in the second column for every parameter
tblwk10 = table(SI_wk10,pvalues_wk10,'RowNames',efast_var);
% we are only interested in the parameters with a p-value < 0.05, retrieve
% only those
tab_10 = tblwk10(tblwk10.pvalues_wk10<0.05,:);
% after retrieving only the parameters with a p-value < 0.05, sort the
% parameters based on their sensitivity indexes in descending order
tab_10 = sortrows(tab_10, -1)

%----------- Plot sorted Si week 10 by p-values

subplot(2, 2, 1);
%figure; % open a new figure window
    % plot the SI values in a histogram 
    bar(tab_10.SI_wk10);
    % there are 21 bars, assign a label to each of them.
    xticks(1:1:7);
    set(gca,'xticklabel', tab_10.Properties.RowNames, 'fontsize', 18);
    % make the parameter labels for each bar diagonal !
    xtickangle(45);
    % label the y axis, x axis, give plot a title
    ylabel('Sensitivity Index', 'fontsize', 20);
    xlabel('Parameter', 'fontsize', 20);
    legend('Week 10');
    title('First Order Sensitivity Index, Week 10', 'fontsize', 20);

%==========================
% SI WEEK 39 ==============
%==========================

% make the table for the first order sensitivity indexes of each parameter at week 39,
% retrieve the ones with p-values < 0.05, sort them based on SI value

SI_wk39 = s_T1D.Si(:,2,u);
pvalues_wk39 = [s_T1D.p_Si(:,:,2,u);NaN];
tblwk39 = table(SI_wk39,pvalues_wk39,'RowNames',efast_var);
tab_39 = tblwk39(tblwk39.pvalues_wk39<0.05,:);
tab_39 = sortrows(tab_39, -1)

%----------- Plot sorted Si week 39 by p-values

subplot(2, 2, 3);
%figure;
    bar(tab_39.SI_wk39, 'red');
    xticks(1:1:5);
    set(gca,'xticklabel',tab_39.Properties.RowNames, 'fontsize', 18);
    xtickangle(45);
    ylabel('Sensivity Index', 'fontsize', 20);
    xlabel('Parameter', 'fontsize', 20);
    legend('Week 39');
    title('First Order Sensitivity Index, Week 39', 'fontsize', 20);

%===========================
% STI WEEK 10 ==============
%===========================

% make a table for total order sensitivity indexes of each parameter at week 10,
% retrieve the ones with p-values < 0.05, sort them based on the STI value

STI_wk10 = s_T1D.Sti(:,1,u);
pvalues_wk10_STI = [s_T1D.p_Sti(:,:,1,u);NaN];
tblwk10_STI = table(STI_wk10, pvalues_wk10_STI,'RowNames',efast_var);
tab_10_STI = tblwk10_STI(tblwk10_STI.pvalues_wk10_STI < 0.05,:);
tab_10_STI = sortrows(tab_10_STI, -1)

%----------- Plot sorted Sti week 10 by p-values

subplot(2, 2, 2);
%figure;
    bar(tab_10_STI.STI_wk10);
    xticks(1:1:3);
    set(gca,'xticklabel',tab_10_STI.Properties.RowNames, 'fontsize', 18);
    xtickangle(45);
    ylabel('Sensivity Index', 'fontsize', 20);
    xlabel('Parameter', 'fontsize', 20);
    legend('Week 10');
    title('Total Order Sensitivity Index, Week 10', 'fontsize', 20);

%===========================
% STI WEEK 39 ==============
%===========================

% make a table for total order sensitivity indexes of each parameter at week 39,
% retrieve the ones with p-values < 0.05, sort them based on the STI value

STI_wk39 = s_T1D.Sti(:,2,u);
pvalues_wk39_STI = [s_T1D.p_Si(:,:,2,u);NaN];
tblwk39_STI = table(STI_wk39, pvalues_wk39_STI, 'RowNames',efast_var);
tab_39_STI = tblwk39_STI(tblwk39_STI.pvalues_wk39_STI < 0.05,:);
tab_39_STI = sortrows(tab_39_STI, -1)

%----------- Plot sorted Si week 39 by p-values

subplot(2, 2, 4);
%figure;
    bar(tab_39_STI.STI_wk39, 'red');
    xticks(1:1:5);
    set(gca,'xticklabel', tab_39_STI.Properties.RowNames, 'fontsize', 18);
    xtickangle(45);
    ylabel('Sensivity Index', 'fontsize', 20);
    xlabel('Parameter', 'fontsize', 20);
    legend('Week 39');
    title('Total Order Sensitivity Index, Week 39', 'fontsize', 20);
