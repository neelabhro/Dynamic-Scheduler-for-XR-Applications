clear;
clc;
close all;

initializations;
% File_1 = {File11, File21, File31, File41, File51, File61, File71, File81};
userFiles = dir(fullfile('Thesis_Data', '*.mat'));
for k = 1 : length(userFiles)
    baseFileName = userFiles(k).name;
    fullFileName = fullfile(userFiles(k).folder, baseFileName);
    userFileMain{k} = load(fullFileName);
    userFileFCFS{k} = userFileMain{k}.schedule_sim_FCFS;
    userFileEDF{k} = userFileMain{k}.schedule_sim_EDF;
    userFileRR{k} = userFileMain{k}.schedule_sim_RR;
end

%Each user out of the total 8 has 500 simulations
for i = 1:num_users
    for j = 1:num_sim
        FCFS_Throughput{i}(j) = sum(userFileFCFS{i}{j}(:,4));
        EDF_Throughput{i}(j) = sum(userFileEDF{i}{j}(:,4));
        RR_Throughput{i}(j) = sum(userFileRR{i}{j}(:,4));
    end
end    

for i = 1:num_users
    Averaged_FCFS_Throughput{i} = sum(FCFS_Throughput{i})/num_sim;
    Averaged_EDF_Throughput{i} = sum(EDF_Throughput{i})/num_sim;
    Averaged_RR_Throughput{i} = sum(RR_Throughput{i})/num_sim;
end  

Averaged_FCFS_Throughput = cell2mat(Averaged_FCFS_Throughput);
Averaged_EDF_Throughput = cell2mat(Averaged_EDF_Throughput);
Averaged_RR_Throughput = cell2mat(Averaged_RR_Throughput);

plot(1:num_users,Averaged_RR_Throughput, LineWidth=2);
hold on;
plot(1:num_users,Averaged_EDF_Throughput, LineWidth=2);
hold on;
plot(1:num_users,Averaged_FCFS_Throughput, LineWidth=2);

legend('RR', 'EDF', 'FCFS');