function [fcfs_val, number_of_packets_per_frame, frame_release_times, user, value] = fcfs(users, selected_users, n, slot_length)

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
    number_of_packets_per_frame = [(users{selected_users(user_id)}.number_of_packets_per_frame(1:end-1)) ; number_of_packets_per_frame ];
    frame_release_times = [(users{selected_users(user_id)}.frame_release_times(1:end-1)) ; frame_release_times ];
    frameSizeB = [(users{selected_users(user_id)}.frameSizeB(1:end-1)) ; frameSizeB ];
    value = [repmat((users{selected_users(user_id)}.value),(length(users{selected_users(user_id)}.frameSizeB(1:end-1))),1) ; value ];
    fps = [repmat((users{selected_users(user_id)}.fps),(length(users{selected_users(user_id)}.frameSizeB(1:end-1))),1) ; fps ];
    nf = [repmat((users{selected_users(user_id)}.nf),(length(users{selected_users(user_id)}.frameSizeB(1:end-1))),1) ; nf ];
end
number_of_packets_per_frame = cat(1, number_of_packets_per_frame{:});
frame_release_times = cat(1, frame_release_times{:});
frameSizeB = cat(1, frameSizeB{:});
value = cat(1, value{:});
fps = cat(1, fps{:});
nf = cat(1, nf{:});
%total_number_of_packets = sum(user.number_of_packets_per_frame); 


%Sorting the frame release time according to FCFS policy
[frame_release_times, sorted_frame_release_times_index] = sort(frame_release_times);

% Reordering the existing elements according to the changed order
nf = nf(sorted_frame_release_times_index);
frameSizeB = frameSizeB(sorted_frame_release_times_index);
number_of_packets_per_frame = number_of_packets_per_frame(sorted_frame_release_times_index);
value = value(sorted_frame_release_times_index);
fps = fps(sorted_frame_release_times_index);

user = {};
user = struct('number_of_packets_per_frame', number_of_packets_per_frame, 'frame_release_times', frame_release_times, 'frameSizeB', frameSizeB, 'fps', fps, 'nf', nf, 'value', value);

% total_packets = users.nf * users.number_of_packets_per_frame;
% %Changing frame level data to packet level data for packet level scheduling
% user.value = user.value*ones(user.nf .* user.number_of_packets_per_frame, 1);
% for user_id = 1:n
%     for frame = 1:user(user_id).nf(1) - 1
%         packets(frame) = user.number_
%         user.number_of_packets_per_frame(frame);
%     end
% end
% %Scheduling/Dropping policy
% 
% while(current_packet_index <= total_packets)














fcfs_val = frame_release_times;