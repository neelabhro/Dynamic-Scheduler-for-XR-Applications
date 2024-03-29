clear;
clc;
%close all;
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
    users_original_MLVE{k} = load(fullFileName);
end

throughput = 0;

%number of users
N = 20;
alpha = 3;
L = length(theFiles);
%number of simulation insances
S = 120;
%slot length in ms(depends on the SCS)
slot_length = 0.125;
%slot_length = 0.0625;
%slot_length = 0.25;

%maximum release time in ms
max_release_time = 10;
%packetsize in B
packet_size = 1500;
values_range = [10 50];
mlve_factor_1 = 1;
%values_range = ceil(values_range/mlve_factor);
mlve_factor_2 = 3;
for l = 1 : L
    users_original{l}.number_of_packets_per_frame = ceil(users_original{l}.frameSizeB./(packet_size*mlve_factor_1)); 
    users_original_MLVE{l}.number_of_packets_per_frame = ceil(users_original_MLVE{l}.frameSizeB./(packet_size*mlve_factor_2));
end
current_data_point = 1;
for data_point = 1:2:N    
    for sim_instance = 1:S        
        for n = 1 : N
            l = randi(L);
            truncuated_length = ceil(users_original{l}.nf/1000);
            trace_slice_lower_bound = randi([1 users_original{l}.nf-truncuated_length],1,1);
            trace_slice_upper_bound = trace_slice_lower_bound + truncuated_length;
            users_truncuated{n}.avgframeSizekB = (users_original{l}.avgframeSizekB)./mlve_factor_1;
            users_truncuated{n}.fps = users_original{l}.fps;
            users_truncuated{n}.frameSizeB = (users_original{l}.frameSizeB(trace_slice_lower_bound:trace_slice_upper_bound-1))./mlve_factor_1;
            users_truncuated{n}.frametype = users_original{l}.frametype(trace_slice_lower_bound:trace_slice_upper_bound-1);
            users_truncuated{n}.info = users_original{l}.info;
            users_truncuated{n}.nf = truncuated_length;
            users_truncuated{n}.number_of_packets_per_frame = users_original{l}.number_of_packets_per_frame(trace_slice_lower_bound:trace_slice_upper_bound-1);
            users_truncuated{n}.value = randi(values_range,1);


            truncuated_length_MLVE = ceil(users_original_MLVE{l}.nf/1000);
            trace_slice_lower_bound_MLVE = randi([1 users_original_MLVE{l}.nf-truncuated_length_MLVE],1,1);
            trace_slice_upper_bound_MLVE = trace_slice_lower_bound_MLVE + truncuated_length_MLVE;
            users_truncuated_MLVE{n}.avgframeSizekB = (users_original_MLVE{l}.avgframeSizekB)./mlve_factor_2;
            users_truncuated_MLVE{n}.fps = users_original_MLVE{l}.fps;
            users_truncuated_MLVE{n}.frameSizeB = (users_original_MLVE{l}.frameSizeB(trace_slice_lower_bound_MLVE:trace_slice_upper_bound_MLVE-1))./mlve_factor_2;
            users_truncuated_MLVE{n}.frametype = users_original_MLVE{l}.frametype(trace_slice_lower_bound_MLVE:trace_slice_upper_bound_MLVE-1);
            users_truncuated_MLVE{n}.info = users_original_MLVE{l}.info;
            users_truncuated_MLVE{n}.nf = truncuated_length_MLVE;
            users_truncuated_MLVE{n}.number_of_packets_per_frame = users_original_MLVE{l}.number_of_packets_per_frame(trace_slice_lower_bound_MLVE:trace_slice_upper_bound_MLVE-1);
            users_truncuated_MLVE{n}.value = randi(values_range,1);
        end
        users = users_truncuated;
        users_MLVE = users_truncuated_MLVE;
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

            fps_increment_MLVE = (1/users_MLVE{selected_users(user_id)}.fps)*1000;
            users_MLVE{selected_users(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment_MLVE*(0:users_MLVE{selected_users(user_id)}.nf-1)'; 
            users_MLVE{selected_users(user_id)}.user_id = selected_users(user_id);
            
            for frame = 1:users{selected_users(user_id)}.nf - 1
                users{selected_users(user_id)}.frame_deadline(frame,1) = users{selected_users(user_id)}.frame_release_times(frame+1);                
                users_MLVE{selected_users(user_id)}.frame_deadline(frame,1) = users_MLVE{selected_users(user_id)}.frame_release_times(frame+1);                

            end
        end

        [bipartite_graph_matrix, B] = compute_bipartite_graph(users,selected_users,data_point,slot_length);
        
        %call all scheduling algorithms and save corresponding results
        [bipartite_val, mi, mj] = bipartite_matching(bipartite_graph_matrix);  
        [max_weight_val, scheduled_packets_mw, dropped_packets_mw, packets_ordered_mw] = maximum_weight(users,selected_users,data_point,slot_length);
        [edf_alpha_val, scheduled_packets_ealpha, dropped_packets_ealpha, packets_ordered_ealpha, scheduled_packet_index_ealpha, max_pack_counter, edf_pack_counter] = edf_alpha(users,selected_users,data_point,slot_length,alpha);
        [fcfs_val_sj, scheduled_packets_fcfs, dropped_packets_fcfs, packets_ordered_fcfs] = fcfs(users,selected_users,data_point,slot_length);
        [edf_val, scheduled_packets_edf, dropped_packets_edf, packets_ordered_edf] = edf(users,selected_users,data_point,slot_length);
        [no_dropping_val] = no_dropping(users,selected_users,data_point,slot_length,throughput);
 
        [bipartite_graph_matrix_MLVE, B_MLVE] = compute_bipartite_graph(users_MLVE,selected_users,data_point,slot_length);
        
        %call all scheduling algorithms and save corresponding results
        [bipartite_val_MLVE, mi_MLVE, mj_MLVE] = bipartite_matching(bipartite_graph_matrix_MLVE);  
        [max_weight_val_MLVE, scheduled_packets_mw_MLVE, dropped_packets_mw_MLVE, packets_ordered_mw_MLVE] = maximum_weight(users_MLVE,selected_users,data_point,slot_length);
        [edf_alpha_val_MLVE, scheduled_packets_ealpha_MLVE, dropped_packets_ealpha_MLVE, packets_ordered_ealpha_MLVE, scheduled_packet_index_ealpha_MLVE, max_pack_counter_MLVE, edf_pack_counter_MLVE] = edf_alpha(users_MLVE,selected_users,data_point,slot_length,alpha);
        [fcfs_val_sj_MLVE, scheduled_packets_fcfs_MLVE, dropped_packets_fcfs_MLVE, packets_ordered_fcfs_MLVE] = fcfs(users_MLVE,selected_users,data_point,slot_length);
        [edf_val_MLVE, scheduled_packets_edf_MLVE, dropped_packets_edf_MLVE, packets_ordered_edf_MLVE] = edf(users_MLVE,selected_users,data_point,slot_length);
        [no_dropping_val_MLVE] = no_dropping(users_MLVE,selected_users,data_point,slot_length,throughput);



        %all_packets_value = maximum_achievable_throughput(users,selected_users,data_point);
        results_throughput.bipartite_matching{current_data_point,sim_instance}.val = no_dropping_val/bipartite_val;
        
        results_throughput.max_weight{current_data_point,sim_instance}.val = max_weight_val/no_dropping_val;
        results_throughput.edf_alpha{current_data_point,sim_instance}.val = edf_alpha_val/no_dropping_val;
        results_throughput.edf{current_data_point,sim_instance}.val = edf_val/no_dropping_val;
        results_throughput.fcfs_sj{current_data_point,sim_instance}.val = fcfs_val_sj/no_dropping_val;
%       results.edf{data_point,sim_instance}.val = bipartite_val/edf_val;
        results_throughput.no_dropping{current_data_point,sim_instance}.val = no_dropping_val/no_dropping_val;
        %results.all_packets{data_point,sim_instance}.val = all_packets_value;

        results_probability.max_weight{current_data_point,sim_instance}.val = max_pack_counter/scheduled_packet_index_ealpha;
        results_probability.edf{current_data_point,sim_instance}.val = edf_pack_counter/scheduled_packet_index_ealpha;
        results_probability.ratio{current_data_point,sim_instance}.val = max_pack_counter/edf_pack_counter;

%       Calculating packet drop data
        dropped_pack_mwbm = 0;
        results_packet_drop.max_weight{current_data_point,sim_instance}.val = 1- (length(scheduled_packets_mw.packet_id)/length(packets_ordered_mw.packet_id));
        results_packet_drop.edf_alpha{current_data_point,sim_instance}.val = 1- (length(scheduled_packets_ealpha.packet_id)/length(packets_ordered_ealpha.packet_id));
        results_packet_drop.edf{current_data_point,sim_instance}.val = 1- (length(scheduled_packets_edf.packet_id)/length(packets_ordered_edf.packet_id));
        results_packet_drop.fcfs_sj{current_data_point,sim_instance}.val = 1- (length(scheduled_packets_fcfs.packet_id)/length(packets_ordered_fcfs.packet_id));
        total_pack = length(packets_ordered_fcfs.packet_id);
        for i = 1:total_pack
            if ~ismember(packets_ordered_fcfs.packet_id(i),mi)
                dropped_pack_mwbm = dropped_pack_mwbm +1;
            end
        end   
        results_packet_drop.bipartite_matching{current_data_point,sim_instance}.val = dropped_pack_mwbm/length(packets_ordered_fcfs.packet_id);
        
%       Calculating system time data
        results_system_time.max_weight{current_data_point,sim_instance}.val = mean(scheduled_packets_mw.slotted_times - scheduled_packets_mw.release_times) -  mean(scheduled_packets_mw_MLVE.slotted_times - scheduled_packets_mw_MLVE.release_times);
        results_system_time.edf_alpha{current_data_point,sim_instance}.val = mean(scheduled_packets_ealpha.slotted_times - scheduled_packets_ealpha.release_times) - mean(scheduled_packets_ealpha_MLVE.slotted_times - scheduled_packets_ealpha_MLVE.release_times);
        results_system_time.edf{current_data_point,sim_instance}.val = mean(scheduled_packets_edf.slotted_times - scheduled_packets_edf.release_times) - mean(scheduled_packets_edf_MLVE.slotted_times - scheduled_packets_edf_MLVE.release_times);
        results_system_time.fcfs_sj{current_data_point,sim_instance}.val = mean(scheduled_packets_fcfs.slotted_times - scheduled_packets_fcfs.release_times) - mean(scheduled_packets_fcfs_MLVE.slotted_times - scheduled_packets_fcfs_MLVE.release_times);
        
        mwbm_sys_time = zeros(length(mi),1);
        for j = 1:length(mi)
            mwbm_sys_time(j) = mwbm_sys_time(j) + ((mj(j)*slot_length) - (find(bipartite_graph_matrix(mi(j),:),1)-1)*slot_length);
        end
        
        mwbm_sys_time_MLVE = zeros(length(mi_MLVE),1);
        for j = 1:length(mi_MLVE)
            mwbm_sys_time_MLVE(j) = mwbm_sys_time_MLVE(j) + ((mj_MLVE(j)*slot_length) - (find(bipartite_graph_matrix_MLVE(mi_MLVE(j),:),1)-1)*slot_length);
        end
        %results_system_time.bipartite_matching{data_point,sim_instance}.val = mean(mj*slot_length - packets_ordered_fcfs.release_times(mi));  
        results_system_time.bipartite_matching{current_data_point,sim_instance}.val = mean(mwbm_sys_time) - mean(mwbm_sys_time_MLVE);
        
        fprintf('Simulations running for: data point %i and simulation instace %i.\n',data_point,sim_instance);

    end
    current_data_point = current_data_point + 1;
end