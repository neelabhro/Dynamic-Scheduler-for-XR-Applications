function [fcfs_val, users, selected_users] = fcfs(users, selected_users, data_point, slot_length)

%Initial definition and concatenation of input data points
%Dimensions of Selected users is number_of_max_simulated_usersXnum_sim_instances
%Row number corresponds to the number of users being simulated together
users = users(selected_users);
% 
% current_packet_index = 0;
% dropped_packet_index = 0;
% scheduled_packet_index = 0;
% 
% users.frame_release_times = [selected_users.frame_release_times ; users.frame_release_times];
% users.nf = [selected_users.nf ; users.nf];
% users.frameSizeB = [selected_users.frameSizeB ; users.frameSizeB];
% users.number_of_packets_per_frame = [selected_users.number_of_packets_per_frame ; users.number_of_packets_per_frame];
% users.value = [selected_users.value ; users.value];
% users.fps = [selected_users.fps ; users.fps];
% 
% %Sorting the frame release time according to FCFS policy
% [users.sorted_frame_release_times, sorted_frame_release_times_index] = sort(users.frame_release_times);
% 
% %Reordering the existing elements according to the changed order
% users.nf = users.nf(sorted_frame_release_times_index);
% users.frameSizeB = users.frameSizeB(sorted_frame_release_times_index);
% users.number_of_packets_per_frame = users.number_of_packets_per_frame(sorted_frame_release_times_index);
% users.value = users.value(sorted_frame_release_times_index);
% users.fps = users.fps(sorted_frame_release_times_index);
% total_packets = users.nf * users.number_of_packets_per_frame;
% %Changing frame level data to packet level data for packet level scheduling
% 
% 
% %Scheduling/Dropping policy
% 
% while(current_packet_index <= total_packets)














fcfs_val = users;