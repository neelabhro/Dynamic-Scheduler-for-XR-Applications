function [average_system_time, average_waiting_time] = Plotting(Virtual_Queue, system_time, waiting_time)

initializations;

for i = 1:num_users
    average_system_time{i} = sum(system_time{i},2)./ sum(system_time{i}~=0,2);
    average_waiting_time{i} = sum(waiting_time{i},2)./ sum(waiting_time{i}~=0,2);
end    

for j = 1:num_users
    plot(average_waiting_time{j});
    title('Average Waiting time per frame')
    xlabel('Frame number')
    ylabel('Time in ms')

    hold on;
end
legend('User 1(60 FPS)', 'User 2(30 FPS)');
figure;

for j = 1:num_users
    plot(average_system_time{j});
    title('Average System time per frame')
    xlabel('Frame number')
    ylabel('Time in Seconds')
    hold on;
end
legend('User 1(60 FPS)', 'User 2(30 FPS)');
figure;
for j = 1:num_users
    plot( 1:100, Burst_Size(:,j)./1000);
    hold on;
end    
title('Frame Size variation across users');
xlabel('Frame Number');
ylabel('Frame Size in Kb');
legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');figure;

for i = 1:num_users
    histogram( Burst_Size(:,i)./1000);
    hold on;
end    
title('Histogram of frame distibution');
xlabel('Frame Size in Kb');
legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');