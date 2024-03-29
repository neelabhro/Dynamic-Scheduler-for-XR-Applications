function [results_throughput, results_packet_drop, users, selected_users] = calculate_schedule(path_to_files)
%N is the number of users, i.e., trace files

% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isfolder(path_to_files)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s\nPlease specify a new folder.', path_to_files);
    uiwait(warndlg(errorMessage));
    path_to_files = uigetdir(); % Ask for a new one.
    if path_to_files == 0
         % User clicked Cancel
         return;
    end
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(path_to_files, '*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    users_original{k} = load(fullFileName);
end



%number of users
N = 10;
alpha = 3;
L = length(theFiles);
%number of simulation insances
S = 1;
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

throughput = 0;
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
        
   
        [bipartite_graph_matrix] = compute_bipartite_graph(users,selected_users,data_point,slot_length);
        
        %call all scheduling algorithms and save corresponding results
        [bipartite_val, mi, mj] = bipartite_matching(bipartite_graph_matrix);  
        %[maximum_weight_val] = maximum_weight(users,selected_users,data_point,slot_length);
        [max_weight_val, scheduled_packets_mw, dropped_packets_mw, packets_ordered_mw] = max_weight(users,selected_users,data_point,slot_length);
        [edf_alpha_val, scheduled_packets_ealpha, dropped_packets_ealpha, packets_ordered_ealpha] = edf_alpha(users,selected_users,data_point,slot_length,alpha);
        [fcfs_val_sj, scheduled_packets_fcfs, dropped_packets_fcfs, packets_ordered_fcfs] = fcfs_sj(users,selected_users,data_point,slot_length);
        %[edf_val] = edf(users,selected_users,data_point,slot_length,throughput);
        %[weight_val] = max_weight(users,selected_users,data_point,slot_length,throughput);
        %[no_dropping_val] = no_dropping(users,selected_users,data_point,slot_length,throughput);
        
        %all_packets_value = maximum_achievable_throughput(users,selected_users,data_point);
        results_throughput.bipartite_matching{data_point,sim_instance}.val = bipartite_val;
        %results_packet_drop.bipartite_matching{data_point,sim_instance}.mi = mi;
        %results_packet_drop.bipartite_matching{data_point,sim_instance}.mj = mj;
        
        %results.maximum_weight{data_point,sim_instance}.val = maximum_weight_val;
        results_throughput.max_weight{data_point,sim_instance}.val = max_weight_val;
        results_throughput.edf_alpha{data_point,sim_instance}.val = edf_alpha_val;
        results_throughput.fcfs_sj{data_point,sim_instance}.val = fcfs_val_sj;
%        results.edf{data_point,sim_instance}.val = edf_val;
        %results.no_dropping{data_point,sim_instance}.val = no_dropping_val;
        %results.all_packets{data_point,sim_instance}.val = all_packets_value;
        %results.max_weight{data_point,sim_instance}.val = weight_val;





        dropped_pack_mwbm = 0;

        results_packet_drop.max_weight{data_point,sim_instance}.val = 1- (length(scheduled_packets_mw.packet_id)/length(packets_ordered_mw.packet_id));
        results_packet_drop.edf_alpha{data_point,sim_instance}.val = 1- (length(scheduled_packets_ealpha.packet_id)/length(packets_ordered_ealpha.packet_id));
        results_packet_drop.fcfs_sj{data_point,sim_instance}.val = 1- (length(scheduled_packets_fcfs.packet_id)/length(packets_ordered_fcfs.packet_id));
        total_pack = length(packets_ordered_mw.packet_id);
        for i = 1:total_pack
            if ~ismember(packets_ordered_mw.packet_id(i),mi)
                dropped_pack_mwbm = dropped_pack_mwbm +1;
            end
        end   
        results_packet_drop.bipartite_matching{data_point,sim_instance}.val = dropped_pack_mwbm/length(packets_ordered_mw.packet_id);
        fprintf('Simulations running for: data point %i and simulation instace %i.\n',data_point,sim_instance);
    end
end
end