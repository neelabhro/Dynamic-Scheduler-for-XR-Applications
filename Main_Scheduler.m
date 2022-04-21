clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

initializations
n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
s_no = zeros(length(n_pack_burst),max(round(n_pack_burst)));

for i = 1:length(n_pack_burst)
    s_no(i, 1:max(round(n_pack_burst(i)))) = linspace(1, round(n_pack_burst(i)), round(n_pack_burst(i)));    
end    
A = linspace(1, round(n_pack_burst(2)), round(n_pack_burst(2)));




btime = t_sorted_nxt_frame;
[tatime, wtime, b, t] = Round_Robin_Scheduler(btime, n, q);
%[tatime, wtime, t1, t2] = Scheduler_FCFS(btime, n)




plot(1:length(Initial_QoE),Initial_QoE);
%figure;
title('QoE variations across varying bursts')