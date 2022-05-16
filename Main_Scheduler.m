clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

initializations
%Common_Queue = zeros(200,2);
time_slots = 0:0.034:2;
Virtual_Queue{1} = zeros(length(time_slots),1);
Virtual_Queue{2} = zeros(length(time_slots),1);

for i = 1:length(time_slots)
    for j = 1:num_users
        if t_arrival(i,j) < time_slots(i)
            fprintf('Hello')
            Virtual_Queue{j}(i) = t_arrival(i,j);
        end    
    end
end    
%Initial_Queue = containers.Map(s_no_frames, t_deadline_packets);
% While new arrival event happens:
%Initial_Queue(length(s_no_frames) +1) = 5;
%Update the length of the frame_vector
%s_no_frames = length(Initial_Queue);

%Remove the elements of the queue if needed
%remove(Initial_Queue,scheduled_packet)
%valueN = Initial_Queue(5);
%btime = t_sorted_nxt_frame;
%for i=1:100
%    btime(i) = packet.arrival{i,1};
%end
btime = t_arrival_packet;
[scheduled_order] = FCFS(btime, num_users);
%[tatime, wtime, b, t] = Round_Robin_Scheduler(btime, n, q);
%[tatime, wtime, t1, t2] = Scheduler_FCFS(btime, n)


%B = s_no_frames(:,1:1000)
%plot(1:length(Initial_QoE),Initial_QoE);
%figure;
%title('QoE variations across varying bursts')