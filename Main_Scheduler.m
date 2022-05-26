clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

initializations
%Common_Queue = zeros(200,2);
time_slots = 0:0.034:3; %Providing 34ms to each time slot, until 3s are elapsed
%time_slots = 0.000125:0.000125:3;
time_slots = 0.00025*ones(100,1);
%time_slots = time_slots(5001:5100);
for i = 1:num_users
    Virtual_Queue{i} = zeros(length(time_slots),2);
    Dropped_Queue{i} = zeros(length(time_slots),2);
end    
%Virtual_Queue{1} = zeros(length(time_slots),1); %Defining virtual queues for all the users
%Virtual_Queue{2} = zeros(length(time_slots),1);

for i = 1:length(time_slots) - 1
    for j = 1:num_users
        %if t_arrival(i,j) < time_slots(i) %Arrival condition
        for k = 1:packets{j}(i,3)
            if packets{j}(i,2) + ((packets{j}(i+1,2) - packets{j}(i,2))/packets{j}(i,3))*(k) < packets{j}(i,2) + k*time_slots(i) %Arrival condition
                %The t_nxt_frame can be used a frame deadline, by which all
                %packets need to be delivered
                %fprintf('Hello')
                Virtual_Queue{j}(i) = packets{j}(i,2); %Virtual_Queue{j}(i,2) = packets{j}(i,4);
                Virtual_Queue{j}(i,2) = packets{j}(i,4);
                Virtual_Queue{j}(i,3) = k;
                time_system{j}(i) = packets{j}(i,2) + ((packets{j}(i+1,2) - packets{j}(i,2))/packets{j}(i,3))*(k);
            else
                Dropped_Queue{j}(i) = packets{j}(i,2); %Virtual_Queue{j}(i,2) = packets{j}(i,4);
                Dropped_Queue{j}(i,2) = packets{j}(i,4);
                Dropped_Queue{j}(i,3) = k;
            end    
        end    
    end
    [scheduled_order] = FCFS(Virtual_Queue, num_users);
    %[scheduled_order] = Round_Robin(Virtual_Queue, num_users, time_slots);
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
%btime = t_arrival_packet;

%[tatime, wtime, b, t] = Round_Robin_Scheduler(btime, n, q);
%[tatime, wtime, t1, t2] = Scheduler_FCFS(btime, n)


%B = s_no_frames(:,1:1000)
%plot(1:length(Initial_QoE),Initial_QoE);
%figure;
%title('QoE variations across varying bursts')