function [no_dropping_val, number_of_packets_per_frame, frame_release_times, user, value, total_number_of_packets, throughput, dropped_packets] = no_dropping(users, selected_users, n, slot_length, throughput)

%Initial definition and concatenation of input data points
current_packet_index = 0;
dropped_packet_index = 0;
scheduled_packet_index = 0;

%Dimensions of Selected users is number_of_max_simulated_usersXnum_sim_instances
%Row number corresponds to the number of users being simulated together
number_of_packets_per_frame= {};
frame_release_times = {};
frameSizeB = {};
fps = {};
value = {};
nf = {};
frame_deadline = {};
user_id = {};
scheduled_packets = {};
dropped_packets = {};

for user_number = 1:n
    number_of_packets_per_frame = [(users{selected_users(user_number)}.number_of_packets_per_frame(1:end-1)) ; number_of_packets_per_frame ];
    frame_release_times = [(users{selected_users(user_number)}.frame_release_times(1:end-1)) ; frame_release_times ];
    frameSizeB = [(users{selected_users(user_number)}.frameSizeB(1:end-1)) ; frameSizeB ];
    value = [repmat((users{selected_users(user_number)}.value),(length(users{selected_users(user_number)}.frameSizeB(1:end-1))),1) ; value ];
    fps = [repmat((users{selected_users(user_number)}.fps),(length(users{selected_users(user_number)}.frameSizeB(1:end-1))),1) ; fps ];
    nf = [repmat((users{selected_users(user_number)}.nf),(length(users{selected_users(user_number)}.frameSizeB(1:end-1))),1) ; nf ];
    frame_deadline = [(users{selected_users(user_number)}.frame_deadline(1:end)) ; frame_deadline ];
    user_id = [repmat((users{selected_users(user_number)}.user_id),(length(users{selected_users(user_number)}.frameSizeB(1:end-1))),1) ; user_id ];
end

number_of_packets_per_frame = cat(1, number_of_packets_per_frame{:});
frame_release_times = cat(1, frame_release_times{:});
frame_deadline = cat(1, frame_deadline{:});
frameSizeB = cat(1, frameSizeB{:});
value = cat(1, value{:});
fps = cat(1, fps{:});
nf = cat(1, nf{:});
user_id = cat(1, user_id{:});
%Sorting the frame release time according to FCFS policy
[frame_release_times, sorted_frame_release_times_index] = sort(frame_release_times);

% Reordering the existing elements according to the changed order
nf = nf(sorted_frame_release_times_index);
frameSizeB = frameSizeB(sorted_frame_release_times_index);
number_of_packets_per_frame = number_of_packets_per_frame(sorted_frame_release_times_index);
value = value(sorted_frame_release_times_index);
user_id = user_id(sorted_frame_release_times_index);
fps = fps(sorted_frame_release_times_index);
frame_deadline = frame_deadline(sorted_frame_release_times_index);

user = {};
user = struct('number_of_packets_per_frame', number_of_packets_per_frame, 'frame_release_times', frame_release_times, 'frameSizeB', frameSizeB, 'fps', fps, 'nf', nf, 'value', value, 'frame_deadline', frame_deadline, 'user_id', user_id);

%Changing frame level data to packet level data for packet level scheduling
total_number_of_packets = sum(user.number_of_packets_per_frame);
for i = 1:length(frame_release_times)
      user.frame_release_times(i, 1:user.number_of_packets_per_frame(i)) = (user.frame_release_times(i).*ones(user.number_of_packets_per_frame(i),1));
      user.frame_deadline(i, 1:user.number_of_packets_per_frame(i)) = (user.frame_deadline(i).*ones(user.number_of_packets_per_frame(i),1));
      user.frameSizeB(i, 1:user.number_of_packets_per_frame(i)) = (user.frameSizeB(i).*ones(user.number_of_packets_per_frame(i),1));
      user.value(i, 1:user.number_of_packets_per_frame(i)) = (user.value(i).*ones(user.number_of_packets_per_frame(i),1));
      user.user_id(i, 1:user.number_of_packets_per_frame(i)) = (user.user_id(i).*ones(user.number_of_packets_per_frame(i),1));
end    


%Scheduling/Dropping policy
current_time = 0;
for i = 1:length(frame_release_times)
    for j = 1:length(user.frame_release_times(i,:))
%         if user.frame_deadline(i,j) >= current_time + slot_length
            scheduled_packets = [scheduled_packets user.frame_deadline(i,j)];
            scheduled_packet_index = scheduled_packet_index +1;
            current_packet_index = current_packet_index +1;
            throughput = throughput + user.value(i,j);
            current_time = current_time + slot_length;

%         elseif (user.frame_deadline(i,j) < current_time + slot_length) && (user.frame_deadline(i,j) ~= 0)
%             dropped_packets = [dropped_packets user.frame_deadline(i,j)];
%             dropped_packet_index = dropped_packet_index +1;
%             current_packet_index = current_packet_index +1;
%             %current_time = current_time + slot_length;
%         end
%
   end
end    
no_dropping_val = throughput;