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


% PLOT B,G,I
%========================
subplot(2,2,1);
semilogy(Tn,Yn(:,12),'-','LineWidth',1.5 ,'color', [ 0,.5,.1]);
hold on
semilogy(Tn,Yn(:,22),':' ,'LineWidth',1.5,'color', [ 1,.1,.1]);
semilogy(Tn,Yn(:,23),'-.','LineWidth',1.5, 'color', [ 0,.8,1]);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Days')
ylabel('Population')
title('NOD, no wave')

subplot(2,2,2);
semilogy(Tb,Yb(:,12),'-','LineWidth',1.5,'color', [ 0,.5,.1]);
hold on
semilogy(Tb,Yb(:,22),':' ,'LineWidth',1.5, 'color', [ 1,.1,.1]);
semilogy(Tb,Yb(:,23),'-.','LineWidth',1.5, 'color', [ 0,.8,1]);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Days')
ylabel('Population')
title('BALB/C, no wave')

subplot(2,2,3);
semilogy(TnWave,YnWave(:,12),'-','LineWidth',1.5 ,'color', [ 0,.5,.1]);
hold on
semilogy(TnWave,YnWave(:,22),':' ,'LineWidth',1.5, 'color', [ 1,.1,.1]);
semilogy(TnWave,YnWave(:,23),'-.','LineWidth',1.5,'color', [ 0,.8,1]);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Days')
ylabel('Population')
title('NOD, wave')


subplot(2,2,4);
semilogy(TbWave,YbWave(:,12),'-','LineWidth',1.5 ,'color', [ 0,.5,.1]);
hold on
semilogy(TbWave,YbWave(:,22),':','LineWidth',1.5 , 'color', [ 1,.1,.1]);
semilogy(TbWave,YbWave(:,23),'-.','LineWidth',1.5 , 'color', [ 0,.8,1]);
legend('B','G','I');
ylim([10^0 10^3])
xlabel('Time in Days')
ylabel('Population')
title('BALB/C, wave')