traceFile = readmatrix('ge_cities_40mbps_60fps'); %Google VR trace file
Burst_Size = traceFile(1 : end, 1);  %Represents the trace burst sizes in Bytes
t_nxt_frame = traceFile(1 : end, 2); %Represents the time to next arriving frame in seconds
t_deadline = zeros(length(t_nxt_frame),1);
for i=1:length(t_deadline)
    t_deadline(i+1) = t_nxt_frame(i) + t_deadline(i);
end    
t_deadline = t_deadline(1:length(t_nxt_frame));

N = 2;
n = 100;
q = 0.016;            %quantum time- a round-robin scheduler generally employs time-sharing, giving each job a time slot or quantum

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
