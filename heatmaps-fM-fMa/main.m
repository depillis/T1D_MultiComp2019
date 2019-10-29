% main file for generation of heatmaps/plots for the fM/fMa parameter
% combintions in the multicompartmental model of T1D.

% Parameter list and values are from paramulti.m

%======================
% formLHS.m ===========
%======================
% formLHS will make a uniform distribution of values for each parameter
% combination and output an LHS.csv file

% clear all;
% delete *.csv;
% formLHS(100);

%======================
% T1D_sim.m ===========
%======================
% run simulations. will output 3 .csv files: nowave.csv, wave_05.csv, and
% wave_1.csv which will contain glucose readings and time of disease onset

% T1D_sim('LHS.csv');



%====================================
% FIGURES FROM REPORT ===============
%====================================

% uncomment the code snippets to generate the corresponding figures from the
% summer 2019 report.

%======================
% w = 0 figure ========
%======================

% % panel D
figure;
subplot(2, 2, 4);
heatmap('LHS.csv', 0);
colorbar;
hold on;

% panel A
subplot(2, 2, 1);
dynamics(0.45, 1.75, 0);

% panel B
subplot(2, 2, 2);
dynamics(1, 1.6, 0);

% panel C
subplot(2, 2, 3);
dynamics(1, 0.5, 0);

%======================
% w = 0 figure ========
%======================

% % Oscilatory regime
figure;
subplot(4, 4, [7,8, 11, 12]);
heatmap('LHS.csv', 0);
colorbar;
hold on;

% panel A
subplot(4, 4, [1, 2, 5, 6]);
dynamics(0.45, 1.75, 0);

% panel B
subplot(4, 4, [9, 10, 13, 14]);
dynamics(0.4, 1.49, 0);

%======================
% w = 0.5 figure ======
%======================

% % panel D
figure; 
subplot(2, 2, 4);
heatmap('LHS.csv', 0.5);
colorbar;
hold on;

% panel A
subplot(2, 2, 1);
dynamics(0.44, 1.8, 0.5);

% panel B
subplot(2, 2, 2);
dynamics(1, 1.6, 0.5);

% panel C
subplot(2, 2, 3);
dynamics(1, 0.5, 0.5);

%=======================
% w = 0.5 figure =======
%=======================

% %More dynamics for wave =0.5
% explore the left corner triangle region

figure;
subplot(2, 2, 1);
heatmap('LHS.csv', 0.5);
%colorbar('westoutside');
hold on;

% panel B
subplot(2, 2, 2);
dynamics(0.44, 1.8, 0.5);

% panel C
subplot(2, 2, 3);
dynamics(0.4, 1.45, 0.5);

% panel D
subplot(2, 2, 4);
dynamics(0.59, 1.68, 0.5);

%========================
% w = 1 figure ==========
%========================

% % panel D
figure;
subplot(2, 2, 4);
heatmap('LHS.csv', 1);
colorbar;
hold on;

% panel A
subplot(2, 2, 1);
dynamics(0.5, 1.56, 1);

% panel B
subplot(2, 2, 2);
dynamics(1, 1.6, 1);

% panel C
subplot(2, 2, 3);
dynamics(1, 0.5, 1);

%==========================
% w = 1 figure ============
%==========================

% %More dynamics for wave =0.5
% explore the left corner triangle region
% panel D

figure;
subplot(2, 2, 4);
heatmap('LHS.csv', 1);
colorbar;
hold on;

% panel A
subplot(2, 2, 1);
dynamics(0.5, 1.56, 1);

% panel B
subplot(2, 2, 2);
dynamics(0.6, 1.64, 1);

% panel C
subplot(2, 2, 3);
dynamics(0.7, 1.2, 1);
