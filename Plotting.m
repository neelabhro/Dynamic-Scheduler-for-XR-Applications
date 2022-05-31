function Plotting(Virtual_Queue, Dropped_Queue, system_time, waiting_time)

initializations;

for i = 1:num_users
    average_system_time{i} = sum(system_time{i},2)./ sum(system_time{i}~=0,2);
    average_waiting_time{i} = sum(waiting_time{i},2)./ sum(waiting_time{i}~=0,2);
end    

for j = 1:num_users
    plot(average_waiting_time{j});
    title('Average Waiting time per frame for User', j)
    xlabel('Frame number')
    ylabel('Time in Seconds')
    figure;
    plot(average_system_time{j});
    title('Average System time per frame for User', j)
    xlabel('Frame number')
    ylabel('Time in Seconds')
    figure;
end    