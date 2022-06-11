function [average_system_time, average_waiting_time] = Plotting(Virtual_Queue, system_time, waiting_time)

initializations;

for i = 1:num_users
    average_system_time(i) = sum(system_time{i},2)./ sum(system_time{i}~=0,2);
    average_waiting_time(i) = sum(waiting_time{i},2)./ sum(waiting_time{i}~=0,2);
end    

%for j = 1:num_users
plot(1:length(average_waiting_time), average_waiting_time);
title('Average Waiting time across users')
xlabel('User number')
ylabel('Time in ms')


%hold on;
%end
%legend('User 1(60 FPS)', 'User 2(30 FPS)');
figure;

%for j = 1:num_users
plot(1:length(average_system_time),average_system_time)
title('Average System time across users')
xlabel('User number')
ylabel('Time in Seconds')

%hold on;
%end
%legend('User 1(60 FPS)', 'User 2(30 FPS)');
figure;
for j = 1:num_users
    plot( 1:100, Burst_Size(:,j)./1000);
    hold on;
end    
title('Frame Size variation across users');
xlabel('Frame Number');
ylabel('Frame Size in Kb');
legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');
figure;

for i = 1:num_users
    histogram( Burst_Size(:,i)./1000);
    hold on;
end    
title('Histogram of frame distibution');
xlabel('Frame Size in Kb');
legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');
figure;
File1 = load('mean_sys_time1.mat');
File2 = load('mean_sys_time2.mat');
File3 = load('mean_sys_time3.mat');
File4 = load('mean_sys_time4.mat');
File5 = load('mean_sys_time5.mat');
File6 = load('mean_sys_time6.mat');
File7 = load('mean_sys_time7.mat');
File8 = load('mean_sys_time8.mat');

%figure;
Mean_sys_time = [cell2mat(struct2cell(File1)), cell2mat(struct2cell(File2)), cell2mat(struct2cell(File3)), cell2mat(struct2cell(File4)), cell2mat(struct2cell(File5)), cell2mat(struct2cell(File6)), cell2mat(struct2cell(File7)), cell2mat(struct2cell(File8))];
%Mean_sys_time = struct2cell(Mean_sys_time);
plot(1:8,Mean_sys_time);
title('Average System time for different #user scenarios');
xlabel('#Users');
ylabel('Time(s)');