clear;
clc;
close all;

time_slots = 0.000125;
%scheduled_order = cell2mat(struct2cell(load('Atlantis Results/sched_5_FCFS_120khz')));
%   scheduled_order = cell2mat(struct2cell(load('Atlantis Results/sched_3_FCFS_120khz.mat')));
%   %[scheduled_order] = dropping_policy(scheduled_order);
     %scheduled_order = scheduled_order(1:26501,:);
% 
%    
% for i = 1:length(scheduled_order)
%    if scheduled_order(i,5) < scheduled_order(i,6)
%        d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+1:end,4), scheduled_order(i+1:end,5), (((i:length(scheduled_order(i+1:end,1)) + (i-1)))*time_slots)'];
%        scheduled_order = [scheduled_order(1:i-1,:) ; d];
%    end 
% end     
% scheduled_order  = [scheduled_order; zeros(size(scheduled_order)/2)];
% for i = 1:length(scheduled_order)
% 
%    if scheduled_order(i,6) < scheduled_order(i,1)
%        b = [0, 0, 0, 0, 0, i*time_slots];
%        c = [scheduled_order(i,1), scheduled_order(i,2), scheduled_order(i,3),scheduled_order(i,4), scheduled_order(i,5), (i+1)*time_slots];
%        d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+1:end,4), scheduled_order(i+1:end,5), (((i+2:length(scheduled_order(i+1:end,1)) + (i+1)))*time_slots)'];
%        scheduled_order = [scheduled_order(1:i-1,:) ;b; c; d];
%    end
% end

% File_1 = {File11, File21, File31, File41, File51, File61, File71, File81};
Data = load('Thesis_Data/6Users.mat');
FCFS_Data = Data.schedule_sim_FCFS;
num_sim = 100;
FCFS_Dropped_Data = FCFS_Data(1:num_sim);
%Each user out of the total 8 has 500 simulations
for j = 1:num_sim
    for i = 1:length(FCFS_Data{j})
        if FCFS_Dropped_Data{j}(i,5) < FCFS_Dropped_Data{j}(i,6)
            b = [0, 0, 0, 0, 0, 0];
            d = [FCFS_Dropped_Data{j}(i+1:end,1), FCFS_Dropped_Data{j}(i+1:end,2), FCFS_Dropped_Data{j}(i+1:end,3), FCFS_Dropped_Data{j}(i+1:end,4), FCFS_Dropped_Data{j}(i+1:end,5), (((i:length(FCFS_Dropped_Data{j}(i+1:end,1)) + (i-1)))*time_slots)'];
            FCFS_Dropped_Data{j} = [FCFS_Dropped_Data{j}(1:i-1,:) ; b; d];
        end
    end
end
%Averaged_FCFS_Throughput = cell2mat(Averaged_FCFS_Throughput);

  %B =  find(scheduled_order(:,1) > 0);