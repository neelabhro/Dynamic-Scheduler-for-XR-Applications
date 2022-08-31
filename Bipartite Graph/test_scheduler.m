clear;
clc;
close all;
%N is the number of users, i.e., trace files

% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile('Atlantis', '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    users_original{k} = load(fullFileName);
end

throughput = 0;

%number of users
N = 12;

L = length(theFiles);
%number of simulation insances
S = 10;
%slot length in ms(depends on the SCS)
slot_length = 0.125;
%maximum release time in ms
max_release_time = 10;
%packetsize in B
packet_size = 1500;
values_range = [10 50];

for l = 1 : L
    users_original{l}.number_of_packets_per_frame = ceil(users_original{l}.frameSizeB./packet_size); 
end

for data_point = 1:N    
    for sim_instance = 1:S        
        for n = 1 : N
            l = randi(L);
            truncuated_length = ceil(users_original{l}.nf/1000);
            trace_slice_lower_bound = randi([1 users_original{l}.nf-truncuated_length],1,1);
            trace_slice_upper_bound = trace_slice_lower_bound + truncuated_length;
            users_truncuated{n}.avgframeSizekB = users_original{l}.avgframeSizekB;
            users_truncuated{n}.fps = users_original{l}.fps;
            users_truncuated{n}.frameSizeB = users_original{l}.frameSizeB(trace_slice_lower_bound:trace_slice_upper_bound-1);
            users_truncuated{n}.frametype = users_original{l}.frametype(trace_slice_lower_bound:trace_slice_upper_bound-1);
            users_truncuated{n}.info = users_original{l}.info;
            users_truncuated{n}.nf = truncuated_length;
            users_truncuated{n}.number_of_packets_per_frame = users_original{l}.number_of_packets_per_frame(trace_slice_lower_bound:trace_slice_upper_bound-1);
            users_truncuated{n}.value = randi(values_range,1);
        end
        users = users_truncuated;
        %select a set of users uniformly at random for a simulation scanario
        selected_users = randperm(N,data_point);
        
        %select release times of the first frame for each user uniformly at
        %random for a simulation scanario
        %first_frame_release_times = randi([1 max_release_time],1,data_point);
        first_frame_release_times = unifrnd(1, max_release_time,[1 data_point]);
        
        for user_id = 1:data_point
            fps_increment = (1/users{selected_users(user_id)}.fps)*1000;
            users{selected_users(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment*(0:users{selected_users(user_id)}.nf-1)'; 
            users{selected_users(user_id)}.user_id = selected_users(user_id);
            for frame = 1:users{selected_users(user_id)}.nf - 1
                users{selected_users(user_id)}.frame_deadline(frame,1) = users{selected_users(user_id)}.frame_release_times(frame+1);                
            end
        end
        
   
        %[fcfs_val, number_of_packets_per_frame, frame_release_times, userA, value, total_number_of_packets, throughput, dropped_packets] = fcfs(users,selected_users,data_point,slot_length, throughput);
        [weight_val , scheduled_packets, dropped_packets, packets_ordered] = fcfs_sj(users,selected_users,data_point,slot_length);
 
        %results.fcfs{data_point,sim_instance}.val = fcfs_val;
        results.max_weight{data_point,sim_instance}.val = weight_val;
        %results.all_packets{data_point,sim_instance}.val = all_packets_value;
        fprintf('Simulations running for: data point %i and simulation instace %i.\n',data_point,sim_instance);
    end
end


