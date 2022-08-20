clear;
clc;
close all;

%Diving into packet level scheduling, each packet is 1.32kB 
%Where the data(UDP) payload is 1.278kB
initializations
simulated_users = 7;
for n = 1:num_sim
    selected_users = randi([1 8],1,simulated_users);
    QoE = repmat(randi([10 50],1,num_users),length(t_arrival),1);
%     for i = 1:simulated_users
%         Virtual_Queue{i} = zeros(length(time_slots),2);
%         %Dropped_Queue{i} = zeros(length(time_slots),2);
%     end

    for i = 1:num_frame
        for j = 1:simulated_users
            for k = 1:packets{selected_users(j)}(i,3)
                packet{j,i}(k,1) = packets{selected_users(j)}(i,2);
                packet{j,i}(k,2) = i;
                packet{j,i}(k,3) = selected_users(j);
                packet{j,i}(k,4) = QoE(i,selected_users(j));
                packet{j,i}(k,5) = packets{selected_users(j)}(i,5);
            end
        end
        Virtual_Queue{1} = (cat(1, packet{1,:}));
        Virtual_Queue{2} = (cat(1, packet{2,:}));
        Virtual_Queue{3} = (cat(1, packet{3,:}));
        Virtual_Queue{4} = (cat(1, packet{4,:}));
        Virtual_Queue{5} = (cat(1, packet{5,:}));
        Virtual_Queue{6} = (cat(1, packet{6,:}));
        Virtual_Queue{7} = (cat(1, packet{7,:}));
        %Virtual_Queue{8} = (cat(1, packet{8,:}));

        [scheduled_order_FCFS, waiting_time, system_time] = FCFS(Virtual_Queue, simulated_users, time_slots);
        [scheduled_order_EDF, waiting_time, system_time] = EDF(Virtual_Queue, simulated_users, time_slots);
        [scheduled_order_RR, user_index, system_time, waiting_time ] = Round_Robin(Virtual_Queue, simulated_users, time_slots, num_frame);
        %[scheduled_order_Wt_Thpt, DON_scheduled_order, waiting_time, system_time, delayed_order, weighted_throughput] = Wt_Thpt(Virtual_Queue, simulated_users, time_slots,deadline, alpha);
     end
     schedule_sim_FCFS{n} = scheduled_order_FCFS;
     schedule_sim_EDF{n} = scheduled_order_EDF;
     schedule_sim_RR{n} = scheduled_order_RR;
     user_selection{n} = selected_users;
     QoE_selection{n} = QoE(1,:);
end

% [average_system_time, average_waiting_time] = Plotting(Virtual_Queue, system_time, waiting_time);
% mean_sys_time = mean(average_system_time);
% [scheduled_order] = dropping_policy(scheduled_order);
% [scheduled_order] = dropping_policy(scheduled_order);