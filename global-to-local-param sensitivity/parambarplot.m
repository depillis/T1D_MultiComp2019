function parambarplot(tmax,percent)
% user input: 
% tmax= endtime of ode solver 
% percent: percentage to change each parameter, right now we use 5% 

%list of all parameters to change 
paramnames = {'sE','sR','Dss','aEm','eta_basal','alpha_eta','beta_eta',... 
    'fM','fMa','Jnew','k','b','cnew','e1','e2','alphaB','deltaB','Ghb','R0',...
    'G0','SI',...
    'sigmaI','deltaI','GI','Qpanc','bDE','bIR','aE','aR','Tnaive','bP','ram',...
    'thetaD',...
     'd','bE','bR','muBP','muPB','fD','ftD','muE','muR','muB','Qblood',...
     'mustarSB',...
     'munormalSB','muBSE','aI','aD','Bconv','Qspleen','thetashut'};

LHS =  csvread('LHS.csv'); % call LHS and extract a row from the matrix 
n = size(LHS,1); 

% Apply local sensitivity routine 

for j = 1:n % Loop through each row of the LHS matrix
    
    for i = 1:length(paramnames) % beginning of local sensitivity 
    sol = odesolve(tmax,paramnames(i),percent, LHS, j); %run odesolve: this returns the end glucose levels 
    plotsol(i,:) = ((sol([1,3])/sol(2))-1)*100; %Calculate percent change in glucose 
    end % end of local sensitivity
    
    
   percentchange = abs(plotsol); %matrix with first column
   output(j,:) = max(percentchange,[],2); %maximum absolute change per parameter

    
end % end looping rows of LHS matrix 

writematrix(output,'output.csv'); % write matrix to a CSV

% ----- UNCOMMENT FOLLOWING TO GENERATE A SORTED GRAPH OF RESULTS --------
% % Sort the average change in descending order
% avg = mean(output);
% label =  [avg, [1:52]']; %Add labels to matrix rows
% [~,idx] = sort(label(:,1),'descend'); % sort just the first column
% sortedmat = label(idx,:)   % sort the whole matrix using the sort indices

% % Create bar plot of output
% figure;
% bar(sortedmat(:,1);
% hold off
% ylabel(['Percent Change in Glucose Level After ' num2str(tmax) ' days'],'FontSize',14); %Ylabel
% xlabel('Parameter Changed','FontSize',14); % Xlabel
% title(['Parameters Changed by ' num2str(percent) ' percent'],'FontSize',14) %Graph title
% set(gca,'XTick',1:length(paramnames))
% set(gca,'XTickLabel',sortedmat(:,2)) % add indices as ticks on x axis

% Use this or the parameter list in odesolve.m to check indices on graph
% paramlabels = {'1sE','2sR','3Dss','4aEm','5eta_basal','6alpha_eta','7beta_eta',...
%     '8fM','9fMa','10Jnew','11k','12b','13cnew','14e1','15e2','16alphaB','17deltaB','18Ghb','19R0',...
%     '20G0','21SI',...
%     '22sigmaI','23deltaI','24GI','25Qpanc','26bDE','27bIR','28aE','29aR','30Tnaive','31bP','32ram',...
%     '33thetaD',...
%      '34d','35bE','36bR','37muBP','38muPB','39fD','40ftD','41muE','42muR','43muB','44Qblood',...
%      '45mustarSB',...
%      '46munormalSB','47muBSE','48aI','49aD','50Bconv','51Qspleen','52thetashut'};
end 