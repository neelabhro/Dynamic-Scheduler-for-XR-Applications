function [scheduled_order, scheduling_time, system_time] = FCFS(Virtual_Queue, num_users, time_slots)
%t1 = 0;
%t2 = 0;
%wtime = zeros(1,num_users);       %waiting time
%tatime = zeros(1,num_users);      %turn around time
%initializations
%btime = t_arrival_packet;
%scheduled_order = zeros(num_users*length(btime));
%scheduled_order = zeros(length(time_slots)*2,2);

scheduled_order = [];
for i = 1:num_users
    scheduled_order = [scheduled_order; Virtual_Queue{i} ];
end    
%scheduled_order = [btime(:,1); btime(:,2)];
[temp_order, temp_order_indices] = sort(scheduled_order(:,1));

if size(scheduled_order,2) > 1
    user_order = scheduled_order(:,3);
    frame_order = scheduled_order(:,2);
    scheduled_order = [scheduled_order(temp_order_indices), frame_order(temp_order_indices), user_order(temp_order_indices)];
end  

for i = 1:length(scheduled_order)
    if scheduled_order(i,3) == 1
        scheduling_time{1}(i) = i*time_slots;
        system_time{1}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 2
        scheduling_time{2}(i) = i*time_slots;
        system_time{2}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 3
        scheduling_time{3}(i) = i*time_slots;
        system_time{3}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 4
        scheduling_time{4}(i) = i*time_slots;
        system_time{4}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 5
        scheduling_time{5}(i) = i*time_slots;
        system_time{5}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 6
        scheduling_time{6}(i) = i*time_slots;
        system_time{6}(i) = scheduled_order(i,1) + i*time_slots;
    elseif scheduled_order(i,3) == 7
        scheduling_time{7}(i) = i*time_slots;
        system_time{7}(i) = scheduled_order(i,1) + i*time_slots;        
    elseif scheduled_order(i,3) == 8
        scheduling_time{8}(i) = i*time_slots;
        system_time{8}(i) = scheduled_order(i,1) + i*time_slots;
    end   
end    



%    for j=1:num_users -1
%        if btime(i,j) > btime(i,j+1)
%            scheduled_order(i) = btime(i,j+1);
            %scheduled_order(:,i) = j+1;
%        else
%            scheduled_order(i) = btime(i,j);
            %scheduled_order(:,i) = j;
%        end
%    end   
%end