function [scheduled_order, user_index, system_time, waiting_time ] = Round_Robin(Virtual_Queue, num_users, time_slots, num_frame)


scheduled_order = [];
user_index = [];

for i = 1:max(length(Virtual_Queue{2}))
    for j = 1:num_users
    %for k = 1:length(Virtual_Queue{j})
        if i < length(Virtual_Queue{j})
            scheduled_order = [scheduled_order; Virtual_Queue{j}(i)];
            user_index = [user_index; j];
        end    
    end  
end    

scheduled_order = [scheduled_order, user_index];
for i = 1:length(scheduled_order)
    scheduled_order(i,3) = i*time_slots;
end  

scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];

for i = 1:length(scheduled_order)
   if scheduled_order(i,3) < scheduled_order(i,1)
       if scheduled_order(i+1,3) < scheduled_order(i+1,1)
           b = [0, 0, i*time_slots];
           c = [scheduled_order(i,1), scheduled_order(i,2), (i+1)*time_slots];
           d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2),(((i+2:length(scheduled_order(i+1:end,1)) + (i+1)))*time_slots)'];

           scheduled_order = [scheduled_order(1:i-1,:) ;b; c; d];

       else
           c = [scheduled_order(i+1,1), scheduled_order(i+1,2), (i+1)*time_slots];
           d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2),(((i+2:length(scheduled_order(i+1:end,1)) + (i+1)))*time_slots)'];

           scheduled_order = [scheduled_order(1:i-1,:) ;c; d];      
       end    
   end
end 


for i = 1:length(scheduled_order)
    if scheduled_order(i,2) == 1
        waiting_time{1}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{1}(i) = waiting_time{1}(i) + time_slots;
    elseif scheduled_order(i,2) == 2
        waiting_time{2}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{2}(i) = waiting_time{2}(i) + time_slots;
    elseif scheduled_order(i,2) == 3
        waiting_time{3}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{3}(i) = waiting_time{3}(i) + time_slots;
    elseif scheduled_order(i,2) == 4
        waiting_time{4}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{4}(i) = waiting_time{4}(i) + time_slots;
    elseif scheduled_order(i,2) == 5
        waiting_time{5}(i) = scheduled_order(i,3) - scheduled_order(i,1) ;
        system_time{5}(i) = waiting_time{5}(i) + time_slots;
    elseif scheduled_order(i,2) == 6
        waiting_time{6}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{6}(i) = waiting_time{6}(i) + time_slots;
    elseif scheduled_order(i,2) == 7
        waiting_time{7}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{7}(i) = waiting_time{7}(i) + time_slots;        
    elseif scheduled_order(i,2) == 8
        waiting_time{8}(i) = scheduled_order(i,3) - scheduled_order(i,1);
        system_time{8}(i) = waiting_time{8}(i) + time_slots;
    end   
end    