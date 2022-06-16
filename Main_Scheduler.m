clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB

initializations
%Common_Queue = zeros(200,2);
%time_slots = 0:0.034:3; %Providing 34ms to each time slot, until 3s are elapsed
%time_slots = 0.000125:0.000125:3;
 %Using 62.5 micro seconds/time slot as per 
%https://www.sharetechnote.com/html/5G/5G_FrameStructure.html
%time_slots = time_slots(5001:5100);
for i = 1:num_users
    Virtual_Queue{i} = zeros(length(time_slots),2);
    %Dropped_Queue{i} = zeros(length(time_slots),2);
end    
%Virtual_Queue{1} = zeros(length(time_slots),1); %Defining virtual queues for all the users
%Virtual_Queue{2} = zeros(length(time_slots),1);

%for i = 1:length(time_slots) - 1
    %for j = 1:num_users
        %if t_arrival(i,j) < time_slots(i) %Arrival condition
        %for k = 1:packets{j}(i,3)
            %if packets{j}(i,2) + ((packets{j}(i+1,2) - packets{j}(i,2))/packets{j}(i,3))*(k) > packets{j}(i,2) + k*time_slots(i) %Arrival condition
                %The t_nxt_frame can be used a frame deadline, by which all
                %packets need to be delivered
                %fprintf('Hello')
                %Virtual_Queue{j}(i,k) = packets{j}(i,2); %Virtual_Queue{j}(i,2) = packets{j}(i,4);
%num_frame for equals half the number of time slots, represents arrival frames               
time_slot = 0.0000625*ones(num_frame*10000,1);
for i = 1:num_frame
%for i = 1:length(time_slot)    
    for j = 1:num_users
        for k = 1:packets{j}(i,3)
            packet{j,i}(k,1) = packets{j}(i,2);
            packet{j,i}(k,2) = i;
            packet{j,i}(k,3) = packets{j}(i,4);
        end
    end   
    Virtual_Queue{1} = (cat(1, packet{1,:}));
    Virtual_Queue{2} = (cat(1, packet{2,:}));
    Virtual_Queue{3} = (cat(1, packet{3,:}));
    Virtual_Queue{4} = (cat(1, packet{4,:}));
    Virtual_Queue{5} = (cat(1, packet{5,:}));
    Virtual_Queue{6} = (cat(1, packet{6,:}));
    Virtual_Queue{7} = (cat(1, packet{7,:}));
    Virtual_Queue{8} = (cat(1, packet{8,:}));
%     Virtual_Queue{j} = (cat(1, packet{j,:}));
    %[scheduled_order, waiting_time, system_time] = FCFS(Virtual_Queue, num_users, time_slots);
    [scheduled_order, waiting_time, system_time] = EDF(Virtual_Queue, num_users, time_slots,deadline);
    %[scheduled_order, user_index, system_time, waiting_time ] = Round_Robin(Virtual_Queue, num_users, time_slots, num_frame);
end 


%for i = 1:length(time_slot)
%    V_Queue{1} = (cat(1, packet{1,:}));
%end    


%[scheduled_order, scheduling_time, system_time, time_slots_col] = FCFS(Virtual_Queue, num_users, time_slots);






%mean_sys_time = mean(system_time);
                %Virtual_Queue{j}(i,2) = packets{j}(i,4);
                %Virtual_Queue{j}(i,3) = k;
                %Virtual_Queue{j,i}(k) = k;
               
                %system_time{j}(i,k) = packets{j}(i,2) + ((packets{j}(i+1,2) - packets{j}(i,2))/packets{j}(i,3))*(k); % Scheduling time + queueing/service time
                %system_time{j}(i,k) = packets{j}(i,2) + k*time_slots(i); % Scheduling time + queueing/service time
                %waiting_time{j}(i,k) = k*time_slots(i);
            %else
                %Dropped_Queue{j}(i) = packets{j}(i,2); %Virtual_Queue{j}(i,2) = packets{j}(i,4);
                %Dropped_Queue{j}(i,2) = packets{j}(i,4);
                %Dropped_Queue{j}(i,3) = k;
            %end    
        %end    
    %end
    %Virtual_Queue{j} = packet{j};
    %[scheduled_order] = FCFS(Virtual_Queue, num_users);
    %[scheduled_order] = Round_Robin(Virtual_Queue, num_users, time_slots);
%end    

%Virtual_Queue{1} = packet{1};
%Virtual_Queue{2} = packet{2};
%[scheduled_order] = Round_Robin(Virtual_Queue, num_users, time_slots);

%system_time{2}(system_time{2}==0) = NaN;
%nonZeroIndexes = system_time{2} ~= 0;
%average_system_time = mean((system_time{2}(nonZeroIndexes))');
%average_system_time = sum(system_time{2},2)./ sum(system_time{2}~=0,2);
%average_waiting_time = sum(waiting_time{2},2)./ sum(waiting_time{2}~=0,2);
[average_system_time, average_waiting_time] = Plotting(Virtual_Queue, system_time, waiting_time);
mean_sys_time = mean(average_system_time);
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