function parambarplot(tmax,percent,wave)

paramnames = {'muB','Qblood','aD','aI','muBSE','muPB','muBP','Jnew','mustarSB',...
    'munormalSB','deltamu','cnew','k','b','fMb','fMn','e1','e2','alphaB',...
    'deltaB','eta_basal','alpha_eta','beta_eta','Ghb','sE','sR','Bconv',...
    'Qpanc','d','fMab','fMan','ftD','Dss','fD','R0','G0','SI','sigmaI','GI',...
    'deltaI','bDE','muD','bIR','aE','Tnaive','Qspleen','bP','thetaD','ram',...
    'bE','muE','aR','bR','muR','aEm','thetashut','muBS'};
       
for i = 1:length(paramnames) % Loop through all parameters;
    
    paramnames{i};
    sol = odesolve(tmax,paramnames(i),percent); % Run odesolve
    sol
    plotsol(i,:) = ((sol([1,3])/sol(2))-1)*100; % Compute percentage change in glucose
    plotsol;
    
end
 
 %add labels to plot
label =  [plotsol, [1:57]']; %Add labels to matrix rows
[~,idx] = sort((abs(label(:,1))+abs(label(:,2))),'descend'); % sort just the first column
sortedmat = label(idx,:)   % sort the whole matrix using the sort indices
figure

% create bar plot of output
inc = bar(sortedmat(:,2),'FaceColor', 'w', 'EdgeColor', 'k');
hold on
dec = bar(sortedmat(:,1),'FaceColor', 'k', 'EdgeColor', 'k');
hold off
legend('Increased','Decreased');
ylabel(['Percent Change in Glucose Level After ' num2str(tmax) ' days'],'FontSize',14);
xlabel('Parameter Changed','FontSize',14);
title(['Parameters Changed by ' num2str(percent) ' percent'],'FontSize',14)

%set(h,'fontsize',12,'fontname','courier'); %  to change font namae and size
%set(h,{'string'},char('a','b','c','K_T','\delta_T', ...
%              'e/f','f','p','p_N','g_N','K_N','\delta_N', ...
%              'm','\theta','q','r_1','r_2','u','p_I','g_I','j','k','\kappa','K_L','\delta_L', ...
%              '\alpha/\beta','\beta','K_C','delta_C', ...
%              '\gamma', ...
%              '\mu_I','\omega','\phi','\zeta', ...
%              'd','l','s')); % to change ticklabels

set(gca,'XTick',1:length(paramnames))

set(gca,'XTickLabel',sortedmat(:,3))

h = twxticklabel;
%set(h,'fontsize',12,'fontname','courier'); %  to change font namae and size
set(h,'fontsize',12); %  to change font namae and size

% paramlabels = {'1muB','2Qblood','3aD','4aI','5muBSE','6muPB','7muBP','8Jnew','9mustarSB',...
%      '10munormalSB','11deltamu','12cnew','13k','14b','15fMb','16fMn','17e1','18e2','19alphaB',...
%      '20deltaB','21eta_basal','22alpha_eta','23beta_eta','24Ghb','25sE','26sR','27Bconv',...
%      '28Qpanc','29d','30fMab','31fMan','32ftD','33Dss','34fD','35R0','36G0','37SI','38sigmaI','39GI',...
%      '40deltaI','41bDE','42muD','43bIR','44aE','45Tnaive','46Qspleen','47bP','48thetaD','49ram',...
%      '50bE','51muE','52aR','53bR','54muR','55aEm','56thetashut','57muBS'};