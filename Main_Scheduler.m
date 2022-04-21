clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

initializations

btime = t_sorted_nxt_frame;
[tatime, wtime, b, t] = Round_Robin_Scheduler(btime, n, q);
%[tatime, wtime, t1, t2] = Scheduler_FCFS(btime, n)




%plot(1:length(Initial_QoE),Initial_QoE);
%figure;
%title('QoE variations across varying bursts')