% this is the main file you want to execute to generate heatmaps for the
% alpha_eta and beta_eta parameter combinations in the multicompartmental
% model of T1D. just hit the run button.

%============================
% formLHS.m =================
%============================
% formLHS will make a uniform distribution of values for each parameter
% combination and output an LHS.csv file

% clear all;
% delete *.csv;
% formLHS(100);

%============================
% T1D_sim.m =================
%============================
% run simulations. will output 3 .csv files: nowave.csv, wave_05.csv, and
% wave_1.csv which will contain glucose readings and time of disease onset

% T1D_sim('LHS.csv');

%============================
% heatmap.m =================
%============================
% generate heatmaps after the simulation.

% heatmap for no wave
figure; heatmap('LHS.csv', 0);

% heatmap at w = 0.5
figure; heatmap('LHS.csv', 0.5);

% heatmap at w = 1
figure; heatmap('LHS.csv', 1);

%====================================
% FIGURES FROM REPORT ===============
%====================================

% uncomment the following code snippets to generate the corresponding figures from the
% summer 2019 report.

%====================
% w = 0 figure ======
%====================

% % no apoptotic wave

% % panel D
% subplot(2, 2, 4);
% heatmap('LHS.csv', 0);
% colorbar;
% hold on;
% 
% % panel A
% subplot(2, 2, 1);
% dynamics(0.025, 19, 0);
% 
% % panel B
% subplot(2, 2, 2);
% dynamics(0.2, 25, 0);
% 
% % panel C
% subplot(2, 2, 3);
% dynamics(0.1, 15, 0);

%=====================
% w = 0.5 figure =====
%=====================

% % apoptotic wave = 0.5

% % panel A
% subplot(2, 2, 1);
% heatmap('LHS.csv', 0.5);
% colorbar('westoutside');
% hold on;
% 
% % panel B
% subplot(2, 2, 2);
% dynamics(0.25, 26, 0.5);
% 
% % panel C
% subplot(2, 2, 3);
% dynamics(0.1, 15, 0.5);
% 
% % panel D
% subplot(2, 2, 4);
% dynamics(0.17, 17, 0.5);

%=====================
% w = 1 figure =======
%=====================

% % apoptotic wave = 1

% % panel A
% subplot(2, 2, 1);
% heatmap('LHS.csv', 1);
% colorbar('westoutside');
% hold on;
% 
% % panel B
% subplot(2, 2, 4);
% dynamics(0.1, 15, 1);