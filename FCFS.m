function [scheduled_order, temp_order] = FCFS(Virtual_Queue, num_users)
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
    user_order = scheduled_order(:,2);
    scheduled_order = [scheduled_order(temp_order_indices), user_order(temp_order_indices)];
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