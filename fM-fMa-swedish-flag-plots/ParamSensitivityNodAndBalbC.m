%LdeP 2019-06-10 Making specific to just testing NOD or BalbC clearance parameters (a simplification).
%LdeP 2019-06-10 Updating to incorporate new eta_e(t) function in ODE for effector kill rate of beta cells
%LdeP 2018-07-30 Updating to view parameter sensitivity at different time points
%LdeP 2018-10-10 Updating to view a smaller set of parameters.


%clear all
%close all

% LdeP Choose a run for NOD (set NOD = 1) or BalbC (set NOD = 0)
%Run NOD - uncomment to run NOD case
NOD = 0 ;


% LdeP Create loop to complete parameter sensitivity process for multiple time points
% LdeP Begin loop

tmax = 10000;
percent = 5;

%LdeP 2018-10-10 Focus on early time sensitivity of parameters

%LdeP Measure end times in weeks
wks=7;
EndTimesVector = [10*wks, 20*wks, 30*wks, 35*wks, 40*wks]; %

%EndTimesVector = [55, 75, 100, 150, 300]; %Apoptotic wave peak has passed by day 15.
%EndTimesVector = [53,54,420,421,910,912,tmax];


TotalDose=1e6;
StartTime=40;
timeloop=0;
for t_end = EndTimesVector
timeloop=timeloop+1; %LdeP for use with creating timeplotsol

%LdeP 2018-10-10 Shortening the list of parameters of interest to focus on clearance rates - NOD mouse case.
%Below are descriptions of clearance rate Parameters
%f1  = fM - BalbC-basal phagocytosis for Macrophage%ml cell^-1d^-1 %wt basal phagocytosis rate per M
%f1n = fM_n - NOD-basal phagocytosis for Macrophage %ml cell^-1d^-1 %nod basal phagocytosis rate per M
%f2  = fMa - BalbC-activated phagocytosis for Macrophage %wt activated phagocytosis rate per Ma
%f2n = fMa_n - NOD-activated phagocytosis for Macrophage %ml cell^-1d^-1 % nod activated phagocytosis rate per Ma
%fD = f2*DCtoM; %DC clearance rate
%ftD = f2*tDCtoM; %tDC clearance rate

%%%%%%%%NOD CLEARANCE if NOD = 1, BalbC if NOD = 0 %%%%%%%%%%%%%%
if NOD == 1
	% LdeP  Macrophage Clearance parameters for NOD only
	paramnames = {'fMn', 'fMan' };
else %NOD == 0, so use BalbC parameters
	% LdeP Macrophage Clearance parameters for BalbC only
	 paramnames = {'fMb', 'fMab' };
end;


	for i = 1:length(paramnames)
    
		%LdeP Model without treatment
		%LdeP 2019-06-10 Updating ODEsolve to call new ODE system
    		sol = ODEsolveNoTrtmnt(t_end,paramnames(i),percent,NOD); %Send through NOD boolean

		%LdeP
		% sol(1) = solution with parameter decrease
		% sol(2) = baseline solution - no parameter change
		% sol(3) = solution with parameter increase
		% plotsol(i,1) holds percent change resulting from parameter i decrease
		% plotsol(i,2) holds percent change resulting from parameter i increase
		% Each row of plotsol represents a new parameter
    		plotsol(i,:) = ((sol([1,3])/sol(2))-1)*100;
    
	end

	%LdeP 2018-10-10 attempt to save data to plot multiple times on one parameter
	timeplotsol{timeloop}=plotsol;

	figure

	% create bar plot of output
	inc = bar(plotsol(:,2),'FaceColor', 'w', 'EdgeColor', 'k'); %LdeP Amount change with parameter increase
	hold on
	dec = bar(plotsol(:,1),'FaceColor', 'k', 'EdgeColor', 'k'); %LdeP Amount change with parameter decrease
	hold off
	%LdeP change the legend font size
	%Lgd1=legend('Increased','Decreased','Fontsize',18); %LdeP Update fontsize command
	Lgd = legend('Increased','Decreased');
	Lgd.FontSize = 18;


	ylabel(['Percent Change in Final Glucose Level After ' num2str(t_end) ' weeks'],'FontSize',18, 'FontName', 'CMU Serif');
	xlabel('Parameter Changed','FontSize',18, 'FontName', 'CMU Serif');
	title(['Parameters Changed by ' num2str(percent) ' percent'],'FontSize',18,'FontName', 'CMU Serif')
	
	set(gca,'XTick',1:length(paramnames))

% LdeP List only clearance parameter names

if NOD ==  1
	%NOD Mice
	paramnames = {'fM_{NOD}', 'fMa_{NOD}' };
else
	%Balb/c Mice
	paramnames = {'fM_{BalbC}', 'fMa_{BalbC}' };
end

	set(gca,'XTickLabel',paramnames)

	h = twxticklabel;
	set(h,'fontsize',14, 'fontname', 'Helvetica'); %  to change font namae and size



end; %For EndTimesVector


%LdeP 2018-10-10 timeplotsol(j) holds plotsol at each time point j.
%Gather all results of an increase in parameter values into yinc
yinc = [];
ydec = [];
%for j = length(EndTimesVector):-1:1 %LdeP This order makes the top of the horizontal bar clusters be the earlier days
for j = 1:length(EndTimesVector)   %LdeP This order makes the bottom of the horizontal bar clusters be the earlier days
	yinc = [yinc timeplotsol{j}(:,2)];
	ydec = [ydec timeplotsol{j}(:,1)];
end %EndTimesVector

%LdeP 2018-10-10
% Plot horizontal bar plot with times clustered per parameter
barhinc=barh(yinc,'FaceColor', 'y', 'EdgeColor', 'k'); %LdeP Amount change with parameter increase
hold on;
barhdec=barh(ydec,'FaceColor', 'b', 'EdgeColor', 'k'); %LdeP Amount change with parameter decrease
hold off
%LdeP change the legend font size
Lgd2=legend([barhinc(1),barhdec(1)],{'Increased by 5%','Decreased by 5%'}, 'Fontsize', 18); %LdeP Don't know why this isn't giving the right result.

%LdeP label
%xlabel(['Percent Change in Final Glucose Level After ' num2str(t_end) ' days'],'FontSize',18, 'FontName', 'CMU Serif');
xlabel(['Percent change in glucose levels at t_f weeks'],'FontSize',18, 'FontName', 'Helvetica');

%ylabel('Parameter Changed','FontSize',18, 'FontName', 'CMU Serif');
title(['Parameter sensitivity of clearance rates'],'FontSize',18,'FontName', 'Helvetica')

set(gca,'YTick',1:length(paramnames))
set(gca,'YTickLabel',paramnames)
set(gca,'Fontsize',16)
h = twxticklabel;
set(h,'fontsize',18, 'fontname', 'Helvetica'); %  to change font namae and size

% LdeP End loop
