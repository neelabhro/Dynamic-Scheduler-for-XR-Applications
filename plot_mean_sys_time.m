clear;
clc;
close all;
x = 1:8;


File11 = load('Atlantis results/mean_sys_time1_FCFS_120khz.mat');
File21 = load('Atlantis results/mean_sys_time2_FCFS_120khz.mat');
File31 = load('Atlantis results/mean_sys_time3_FCFS_120khz.mat');
File41 = load('Atlantis results/mean_sys_time4_FCFS_120khz.mat');
File51 = load('Atlantis results/mean_sys_time5_FCFS_120khz.mat');
File61 = load('Atlantis results/mean_sys_time6_FCFS_120khz.mat');
File71 = load('Atlantis results/mean_sys_time7_FCFS_120khz.mat');
File81 = load('Atlantis results/mean_sys_time8_FCFS_120khz.mat');

File1a1 = load('Atlantis results/mean_sys_time1_WT_120khz_a1.mat');
File1a2 = load('Atlantis results/mean_sys_time1_WT_120khz_a2.mat');
File1a3 = load('Atlantis results/mean_sys_time1_WT_120khz_a3.mat');

File2a1 = load('Atlantis results/mean_sys_time2_WT_120khz_a1.mat');
File2a2 = load('Atlantis results/mean_sys_time2_WT_120khz_a2.mat');
File2a3 = load('Atlantis results/mean_sys_time2_WT_120khz_a3.mat');

File3a1 = load('Atlantis results/mean_sys_time3_WT_120khz_a1.mat');
File3a2 = load('Atlantis results/mean_sys_time3_WT_120khz_a2.mat');
File3a3 = load('Atlantis results/mean_sys_time3_WT_120khz_a3.mat');

File4a1 = load('Atlantis results/mean_sys_time4_WT_120khz_a1.mat');
File4a2 = load('Atlantis results/mean_sys_time4_WT_120khz_a2.mat');
File4a3 = load('Atlantis results/mean_sys_time4_WT_120khz_a3.mat');

File5a1 = load('Atlantis results/mean_sys_time5_WT_120khz_a1.mat');
File5a2 = load('Atlantis results/mean_sys_time5_WT_120khz_a2.mat');
File5a3 = load('Atlantis results/mean_sys_time5_WT_120khz_a3.mat');

File6a1 = load('Atlantis results/mean_sys_time6_WT_120khz_a1.mat');
File6a2 = load('Atlantis results/mean_sys_time6_WT_120khz_a2.mat');
File6a3 = load('Atlantis results/mean_sys_time6_WT_120khz_a3.mat');

File7a1 = load('Atlantis results/mean_sys_time7_WT_120khz_a1.mat');
File7a2 = load('Atlantis results/mean_sys_time7_WT_120khz_a2.mat');
File7a3 = load('Atlantis results/mean_sys_time7_WT_120khz_a3.mat');

File8a1 = load('Atlantis results/mean_sys_time8_WT_120khz_a1.mat');
File8a2 = load('Atlantis results/mean_sys_time8_WT_120khz_a2.mat');
File8a3 = load('Atlantis results/mean_sys_time8_WT_120khz_a3.mat');


Mean_sys_time = 1000*[cell2mat(struct2cell(File11)), cell2mat(struct2cell(File21)), cell2mat(struct2cell(File31)), cell2mat(struct2cell(File41)), cell2mat(struct2cell(File51)), cell2mat(struct2cell(File61)), cell2mat(struct2cell(File71)), cell2mat(struct2cell(File81))];
%Mean_sys_time = 1000*Mean_sys_time;

Mean_sys_time_a1 = 1000*[cell2mat(struct2cell(File1a1)), cell2mat(struct2cell(File2a1)), cell2mat(struct2cell(File3a1)), cell2mat(struct2cell(File4a1)), cell2mat(struct2cell(File5a1)), cell2mat(struct2cell(File6a1)), cell2mat(struct2cell(File7a1)), cell2mat(struct2cell(File8a1))];
Mean_sys_time_a2 = 1000*[cell2mat(struct2cell(File1a2)), cell2mat(struct2cell(File2a2)), cell2mat(struct2cell(File3a2)), cell2mat(struct2cell(File4a2)), cell2mat(struct2cell(File5a2)), cell2mat(struct2cell(File6a2)), cell2mat(struct2cell(File7a2)), cell2mat(struct2cell(File8a2))];
Mean_sys_time_a3 = 1000*[cell2mat(struct2cell(File1a3)), cell2mat(struct2cell(File2a3)), cell2mat(struct2cell(File3a3)), cell2mat(struct2cell(File4a3)), cell2mat(struct2cell(File5a3)), cell2mat(struct2cell(File6a3)), cell2mat(struct2cell(File7a3)), cell2mat(struct2cell(File8a3))];

plot(x,(Mean_sys_time), 'LineWidth', 2);
hold on;
plot(x,(Mean_sys_time), 'LineWidth', 2);
hold on;
plot(x,(Mean_sys_time_a1 ), 'LineWidth', 2);
hold on;
plot(x,(Mean_sys_time_a2 ), 'LineWidth', 2);
hold on;
plot(x,(Mean_sys_time_a3 ), 'LineWidth', 2);
grid on;
legend('FCFS', 'EDF', 'WT \alpha = 1', 'WT \alpha = 2', 'WT \alpha = 3');
title('Average System time for SCS=120KHz/Time slots=0.0125ms')
xlabel('Number of users');
ylabel('Average System Time (ms)');