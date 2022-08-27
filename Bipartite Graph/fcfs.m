function [fcfs_val, number_of_packets_per_frame, frame_release_times] = fcfs(users, selected_users, n, slot_length)

%Initial definition and concatenation of input data points
current_packet_index = 0;
dropped_packet_index = 0;
scheduled_packet_index = 0;
total_number_packets = 0;


%Dimensions of Selected users is number_of_max_simulated_usersXnum_sim_instances
%Row number corresponds to the number of users being simulated together
number_of_packets_per_frame= {};
frame_release_times = {};
frameSizeB = {};
fps = {};
value = {};
nf = {};

for user_id = 1:n
    number_of_packets_per_frame = [(users{selected_users(user_id)}.number_of_packets_per_frame(1:end-1)) number_of_packets_per_frame ];
    frame_release_times = [(users{selected_users(user_id)}.frame_release_times(1:end-1)) frame_release_times ];
    frameSizeB = [(users{selected_users(user_id)}.frameSizeB(1:end-1)) frameSizeB ];
    value = [(users{selected_users(user_id)}.value(1:end-1)) value ];
    fps = [(users{selected_users(user_id)}.fps(1:end-1)) fps ];
    nf = [(users{selected_users(user_id)}.nf(1:end-1)) nf ];
end

%total_number__of_packets = sum(number_of_packets_per_frame); 


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














fcfs_val = total_number_packets;