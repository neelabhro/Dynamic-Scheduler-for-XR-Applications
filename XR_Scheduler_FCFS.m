clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1   .278kB

traceFile = readmatrix('ge_cities_40mbps_60fps'); %Google VR trace file
Burst_Size = traceFile(1 : end, 1);  %Represents the trace burst sizes in Bytes
t_nxt_frame = traceFile(1 : end, 2); %Represents the time to next arriving frame in seconds


n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
Initial_QoE = floor(n_pack_burst./(1000.*t_nxt_frame)); %Preliminarily defining this to be a
%fraction of the total number of packets encompassing a frame and taking
%the time to next frame into account as well

%Sort the Scheduled frames according to the QoEs
[sorted_QoE, sortQoEIdx] = sort(Initial_QoE,'descend');
%Captures the original indices of the QoE values to find the corresponding
%frames and times
%A = find(Initial_QoE==15); Testing the correctness
sorted_burst = Burst_Size(sortQoEIdx);
t_sorted_nxt_frame = t_nxt_frame(sortQoEIdx);

plot(1:length(Initial_QoE),Initial_QoE);
title('QoE variations across varying bursts')

%n = length(t_nxt_frame);
n = 10;
btime = t_sorted_nxt_frame;
t1 = 0;
t2 = 0;
wtime = zeros(1,n);       %waiting time
tatime = zeros(1,n);      %turn around time
for i = 2:1:n
   wtime(i) = btime(i-1) + wtime(i-1);  %waiting time will be sum of burst time of previous process and waiting time of previous process
   t1 = t1 + wtime(i);                  %calculating total time
end
for i = 1:1:n
    tatime(i) = btime(i) + wtime(i);    %turn around time=burst time +wait time
    t2 = t2 + tatime(i);                %total turn around time
end
disp('Process   Burst time  Waiting time    Turn Around time'); %displaying final values
for i = 1:1:n
    fprintf('P%d\t\t\t%d\t\t\t%d\t\t\t\t%d\n',(i+1),btime(i),wtime(i),tatime(i));
end
fprintf('Average waiting time: %f\n',(t1/n));
fprintf('Average turn around time: %f\n',(t2/n));