clear;
clc;
close all;
x = 1:8;

File1 = load('Atlantis results/mean_sys_time1_FCFS.mat');
File2 = load('Atlantis results/mean_sys_time2_FCFS.mat');
File3 = load('Atlantis results/mean_sys_time3_FCFS.mat');
File4 = load('Atlantis results/mean_sys_time4_FCFS.mat');
File5 = load('Atlantis results/mean_sys_time5_FCFS.mat');
File6 = load('Atlantis results/mean_sys_time6_FCFS.mat');
File7 = load('Atlantis results/mean_sys_time7_FCFS.mat');
File8 = load('Atlantis results/mean_sys_time8_FCFS.mat');

File11 = load('Atlantis results/sys_time1_FCFS.mat');
File11 = File11.system_time;
File12 = load('Atlantis results/sys_time2_FCFS.mat');
File12 = File12.system_time;
File13 = load('Atlantis results/sys_time3_FCFS.mat');
File13 = File13.system_time;
File14 = load('Atlantis results/sys_time4_FCFS.mat');
File14 = File14.system_time;
File15 = load('Atlantis results/sys_time5_FCFS.mat');
File15 = File15.system_time;
File16 = load('Atlantis results/sys_time6_FCFS.mat');
File16 = File16.system_time;
File17 = load('Atlantis results/sys_time7_FCFS.mat');
File17 = File17.system_time;
File18 = load('Atlantis results/sys_time8_FCFS.mat');
File18 = File18.system_time;

%A = sum(cell2mat(File11))./ sum((cell2mat(File11))~=0)
%for i = 1:length(x)
N{1} = size(nonzeros(cell2mat(File11)),1);
Mean{1} = mean(nonzeros(cell2mat(File11)));
SEM{1} = std(nonzeros(cell2mat(File11)))/sqrt(N{1});
CI95{1} = tinv([0.025 0.975], N{1}-1);
yCI95{1} = bsxfun(@times, SEM{1}, CI95{1}(:));
%end    

N{2} = size(nonzeros(cell2mat(File12)),1);
Mean{2} = mean(nonzeros(cell2mat(File12)));
SEM{2} = std(nonzeros(cell2mat(File12)))/sqrt(N{2});
CI95{2} = tinv([0.025 0.975], N{2}-1);
yCI95{2} = bsxfun(@times, SEM{2}, CI95{2}(:));


N{3} = size(nonzeros(cell2mat(File13)),1);
Mean{3} = mean(nonzeros(cell2mat(File13)));
SEM{3} = std(nonzeros(cell2mat(File13)))/sqrt(N{3});
CI95{3} = tinv([0.025 0.975], N{3}-1);
yCI95{3} = bsxfun(@times, SEM{3}, CI95{3}(:));

N{4} = size(nonzeros(cell2mat(File14)),1);
Mean{4} = mean(nonzeros(cell2mat(File14)));
SEM{4} = std(nonzeros(cell2mat(File14)))/sqrt(N{4});
CI95{4} = tinv([0.025 0.975], N{4}-1);
yCI95{4} = bsxfun(@times, SEM{4}, CI95{4}(:));

N{5} = size(nonzeros(cell2mat(File15)),1);
Mean{5} = mean(nonzeros(cell2mat(File15)));
SEM{5} = std(nonzeros(cell2mat(File15)))/sqrt(N{5});
CI95{5} = tinv([0.025 0.975], N{5}-1);
yCI95{5} = bsxfun(@times, SEM{5}, CI95{5}(:));

N{6} = size(nonzeros(cell2mat(File16)),1);
Mean{6} = mean(nonzeros(cell2mat(File16)));
SEM{6} = std(nonzeros(cell2mat(File16)))/sqrt(N{6});
CI95{6} = tinv([0.025 0.975], N{6}-1);
yCI95{6} = bsxfun(@times, SEM{6}, CI95{6}(:));

N{7} = size(nonzeros(cell2mat(File17)),1);
Mean{7} = mean(nonzeros(cell2mat(File17)));
SEM{7} = std(nonzeros(cell2mat(File17)))/sqrt(N{7});
CI95{7} = tinv([0.025 0.975], N{7}-1);
yCI95{7} = bsxfun(@times, SEM{7}, CI95{7}(:));

N{8} = size(nonzeros(cell2mat(File18)),1);
Mean{8} = mean(nonzeros(cell2mat(File18)));
SEM{8} = std(nonzeros(cell2mat(File18)))/sqrt(N{8});
CI95{8} = tinv([0.025 0.975], N{8}-1);
yCI95{8} = bsxfun(@times, SEM{8}, CI95{8}(:));

yCI95 = 1000*cell2mat(yCI95);

Mean_sys_time = [cell2mat(struct2cell(File1)), cell2mat(struct2cell(File2)), cell2mat(struct2cell(File3)), cell2mat(struct2cell(File4)), cell2mat(struct2cell(File5)), cell2mat(struct2cell(File6)), cell2mat(struct2cell(File7)), cell2mat(struct2cell(File8))];

Mean_sys_time = 1000*Mean_sys_time;
%plot(x,(Mean_sys_time));
plot(x,(Mean_sys_time), 'LineWidth', 1);
hold on;
% plot(x,(Mean_sys_time+yCI95(1,:)));
% hold on;
% plot(x,(Mean_sys_time+yCI95(2,:)));
patch([x, fliplr(x)], [Mean_sys_time + yCI95(1,:) fliplr(Mean_sys_time + yCI95(2,:))], 'r', 'EdgeColor','none', 'FaceAlpha',0.25, 'LineWidth', 4)
%patch([x, fliplr(x)], [yCI95(1,:) fliplr(yCI95(2,:))])
hold off;
grid
title('Average System time for different #user scenarios');
%legend('FCFS', 'Round Robin', 'EDF')
xlabel('#Users');
ylabel('Time (ms)');