function [scheduled_order, waiting_time, system_time,time_slots_col] = FCFS(Virtual_Queue, num_users, time_slots)
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
    scheduled_order = [Virtual_Queue{i};scheduled_order];
end    
%scheduled_order = [btime(:,1); btime(:,2)];
[temp_order, temp_order_indices] = sort(scheduled_order(:,1));

if size(scheduled_order,2) > 1
    user_order = scheduled_order(:,3);
    frame_order = scheduled_order(:,2);
    scheduled_order = [scheduled_order(temp_order_indices), frame_order(temp_order_indices), user_order(temp_order_indices)];
end  

for i = 1:length(scheduled_order)
    scheduled_order(i,4) = i*time_slots;
end  

for i = 1:2*length(scheduled_order)
    time_slots_col(i) = (i*time_slots)';
end    

scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];

for i = 1:length(scheduled_order)
%i = 1;
%while (i <= 60000) 
   if scheduled_order(i,4) < scheduled_order(i,1)
       b = [0, 0, 0, i*time_slots];
       c = [scheduled_order(i,1), scheduled_order(i,2), scheduled_order(i,3), (i+1)*time_slots];
       %d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+1:end,4)];
       %d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), time_slots_col( i+2 :(length(scheduled_order) - (i+1)))];
       %d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+2:end,4)];
       d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), (((i+2:length(scheduled_order(i+1:end,1)) + (i+1)))*time_slots)'];

       scheduled_order = [scheduled_order(1:i-1,:) ;b; c; d];
   end
   %i = i+1;
end 
% time_slots_col(i+2:(length(scheduled_order) - (i-1))) 
%Scheduled Order Column Representations:
%Col 1: t_arrival
%Col 2: Frame number
%Col 3: User Number
%Col 4: Elapsed time
for i = 1:length(scheduled_order)
    if scheduled_order(i,3) == 1
        waiting_time{1}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{1}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 2
        waiting_time{2}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{2}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 3
        waiting_time{3}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{3}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 4
        waiting_time{4}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{4}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 5
        waiting_time{5}(i) = scheduled_order(i,4) - scheduled_order(i,1) ;
        system_time{5}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 6
        waiting_time{6}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{6}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
    elseif scheduled_order(i,3) == 7
        waiting_time{7}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{7}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;        
    elseif scheduled_order(i,3) == 8
        waiting_time{8}(i) = scheduled_order(i,4) - scheduled_order(i,1);
        system_time{8}(i) = scheduled_order(i,4) - scheduled_order(i,1) + time_slots;
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