function [scheduled_order] = Round_Robin(Virtual_Queue, num_users, time_slots)


scheduled_order = [];
user_index = [];
for i = 1:length(time_slots)
    for j = 1:num_users
        scheduled_order = [scheduled_order; Virtual_Queue{j}(i)];
        user_index = [user_index; j];
    end  
end    
scheduled_order = [scheduled_order, user_index];