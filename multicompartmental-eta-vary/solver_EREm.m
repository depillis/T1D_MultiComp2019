% Undergrad team to create a file using the multi compartment model solver file;
% Based off of solver created by undergrad team for modeling Maree et al. 2006;
% This model is based off of Gianna Wu 2019 thesis and retains all equations;


%Initial values
EndTime = 1000;
Tspan = [0 EndTime]; %time in days
IC = [0 0 0 0 0 0 0 0 0 0 4.77*10^5 300 0 0 0 0 0 0 0 0 0 100 10]; % using Topp healthy rest state for beta cells, glucose, insulin;
%('Ds', 'tDs', 'Es', 'Rs', 'Ems', 'Db', 'tDb', 'Eb', 'Rb', 'Emb', 'Mb', 'B', 'Ba', 'Bn', 'Dpanc', 'tDpanc', 'Epanc', 'Rpanc', 'M', 'Ma', 'G', 'I')
wave = 1;
noWave = 0;
paramsmulti;

%LdeP Decide before whether to turn the wave on or off
% 06.11 Removed waveon term

[Tn, Yn] = ode15s(@(t,y)rhs(t,y,fMan,fMn, noWave),Tspan,IC);
[Tb Yb] = ode15s(@(t,y)rhs(t,y,fMab,fMb, noWave),Tspan,IC);
[TnWave YnWave] = ode15s(@(t,y)rhs(t,y,fMan,fMn, wave),Tspan,IC);
[TbWave YbWave] = ode15s(@(t,y)rhs(t,y,fMab,fMb, wave),Tspan,IC);

% PLOT E,R,Em
%========================
subplot(2,2,1);
semilogy(Tn,Yn(:,17),'-' ,'LineWidth',1.5, 'color', [ 0.9,.7, 0.1]);
hold on
semilogy(Tn,Yn(:,18),':','LineWidth',1.5, 'color', [.3, 0.6, 0.2]);
semilogy(Tn,Yn(:,19),'-.','LineWidth',1.5, 'color', [ .4,.4, .4]);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Days')
ylabel('Population')
title('NOD, no wave')

subplot(2,2,2);
semilogy(Tb,Yb(:,17),'-' ,'LineWidth',1.5, 'color', [ 0.9,.7, 0.1]);
hold on
semilogy(Tb,Yb(:,18),':','LineWidth',1.5, 'color', [.3, 0.6, 0.2]);
semilogy(Tb,Yb(:,19),'-.','LineWidth',1.5, 'color', [ .4,.4, .4]);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Days')
ylabel('Population')
title('BALB/C, no wave')

subplot(2,2,3);
semilogy(TnWave,YnWave(:,17),'-' ,'LineWidth',1.5, 'color', [ 0.9,.7, 0.1]);
hold on
semilogy(TnWave,YnWave(:,18),'LineWidth',1.5, 'color', [.3, 0.6, 0.2]);
semilogy(TnWave,YnWave(:,19),'-.','LineWidth',1.5, 'color', [ .4,.4, .4]);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Days')
ylabel('Population')
title('NOD, wave')

subplot(2,2,4);
semilogy(TbWave,YbWave(:,17),'-' ,'LineWidth',1.5, 'color', [ 0.9,.7, 0.1]);
hold on
semilogy(TbWave,YbWave(:,18),':','LineWidth',1.5, 'color', [.3, 0.6, 0.2]);
semilogy(TbWave,YbWave(:,19),'-.','LineWidth',1.5, 'color', [ .4,.4, .4]);
legend('E','R','Em');
ylim([10^0 10^10])
xlabel('Time in Days')
ylabel('Population')
title('BALB/C, wave')