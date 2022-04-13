clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1   .278kB

traceFile = readmatrix('ge_tour_40mbps_60fps'); %Google VR trace file
Burst_Size = traceFile(1 : end, 1);  %Represents the trace burst sizes in Bytes
t_nxt_frame = traceFile(1 : end, 2); %Represents the time to next arriving frame in seconds

t_total = zeros(length(t_nxt_frame),1);
for i=1:length(t_total)
    t_total(i+1) = t_nxt_frame(i) + t_total(i);
end    
t_total = t_total(1:length(t_nxt_frame));
traceFile = [traceFile t_total];

s_no = transpose(linspace(1, length(t_total), length(t_total)));
traceFile(:,1) = s_no;
writematrix(traceFile, 'tracefile2.txt') 