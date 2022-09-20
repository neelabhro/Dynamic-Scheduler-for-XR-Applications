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
end

throughput = 0;

%number of users
N = 15;
user1 = 5;
user2 = 10;
user3 = 15;

Alpha = 3;

L = length(theFiles);
%number of simulation instances
S = 120;
%slot length in ms(depends on the SCS)
slot_length = 0.125;
%maximum release time in ms
max_release_time = 10;
%packetsize in B
packet_size = 1500;
values_range = [10 50];
user_list = [5,10,15];

for l = 1 : L
    users_original{l}.number_of_packets_per_frame = ceil(users_original{l}.frameSizeB./packet_size); 
end

for data_point = 1:Alpha
    for sim_instance = 1:S        
        for n = 1:N
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
        users1 = users;
        users2 = users;
        users3 = users;

        %select a set of users uniformly at random for a simulation scanario
        selected_users1 = randperm(N,user1);
        selected_users2 = randperm(N,user2);
        selected_users3 = randperm(N,user3);

        
        %select release times of the first frame for each user uniformly at
        %random for a simulation scanario
        %first_frame_release_times = randi([1 max_release_time],1,data_point);
        first_frame_release_times = unifrnd(1, max_release_time,[1 data_point]);
        
        for user_id = 1:selected_users1
            fps_increment = (1/users1{selected_users1(user_id)}.fps)*1000;
            users1{selected_users1(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment*(0:users1{selected_users1(user_id)}.nf-1)'; 
            users1{selected_users1(user_id)}.user_id = selected_users1(user_id);
            for frame = 1:users1{selected_users1(user_id)}.nf - 1
                users1{selected_users1(user_id)}.frame_deadline(frame,1) = users1{selected_users1(user_id)}.frame_release_times(frame+1);                
            end
        end

        for user_id = 1:selected_users2
            fps_increment = (1/users2{selected_users2(user_id)}.fps)*1000;
            users2{selected_users2(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment*(0:users2{selected_users2(user_id)}.nf-1)'; 
            users2{selected_users2(user_id)}.user_id = selected_users2(user_id);
            for frame = 1:users2{selected_users2(user_id)}.nf - 1
                users2{selected_users2(user_id)}.frame_deadline(frame,1) = users2{selected_users2(user_id)}.frame_release_times(frame+1);                
            end
        end

        for user_id = 1:selected_users3
            fps_increment = (1/users3{selected_users3(user_id)}.fps)*1000;
            users3{selected_users3(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment*(0:users3{selected_users3(user_id)}.nf-1)'; 
            users3{selected_users3(user_id)}.user_id = selected_users3(user_id);
            for frame = 1:users3{selected_users3(user_id)}.nf - 1
                users3{selected_users3(user_id)}.frame_deadline(frame,1) = users3{selected_users3(user_id)}.frame_release_times(frame+1);                
            end
        end        

        %[bipartite_graph_matrix, B] = compute_bipartite_graph(users,selected_users,data_point,slot_length);
        
        %call all scheduling algorithms and save corresponding results
        %[bipartite_val, mi, mj] = bipartite_matching(bipartite_graph_matrix);  
        [max_weight_val, scheduled_packets_mw, dropped_packets_mw, packets_ordered_mw] = max_weight(users,selected_users,user_list(data_point),slot_length);
        [edf_alpha_val1, scheduled_packets_ealpha1, dropped_packets_ealpha1, packets_ordered_ealpha1] = edf_alpha(users,selected_users1,5,slot_length,data_point);
        [edf_alpha_val2, scheduled_packets_ealpha2, dropped_packets_ealpha2, packets_ordered_ealpha2] = edf_alpha(users,selected_users2,10,slot_length,data_point);
        [edf_alpha_val3, scheduled_packets_ealpha3, dropped_packets_ealpha3, packets_ordered_ealpha3] = edf_alpha(users,selected_users3,15,slot_length,data_point);

        
        %all_packets_value = maximum_achievable_throughput(users,selected_users,data_point);
        %results_throughput.bipartite_matching{data_point,sim_instance}.val = bipartite_val/bipartite_val;
        
        results_throughput.max_weight{data_point,sim_instance}.val = max_weight_val/max_weight_val;
        results_throughput.edf_alpha1{data_point,sim_instance}.val =  max_weight_val/edf_alpha_val1;
        results_throughput.edf_alpha2{data_point,sim_instance}.val =  max_weight_val/edf_alpha_val2;
        results_throughput.edf_alpha3{data_point,sim_instance}.val =  max_weight_val/edf_alpha_val3;



%       Calculating packet drop data
        %dropped_pack_mwbm = 0;
        results_packet_drop.max_weight{data_point,sim_instance}.val = 1- (length(scheduled_packets_mw.packet_id)/length(packets_ordered_mw.packet_id));
        results_packet_drop.edf_alpha1{data_point,sim_instance}.val = 1- (length(scheduled_packets_ealpha1.packet_id)/length(packets_ordered_ealpha1.packet_id));
        results_packet_drop.edf_alpha2{data_point,sim_instance}.val = 1- (length(scheduled_packets_ealpha2.packet_id)/length(packets_ordered_ealpha2.packet_id));
        results_packet_drop.edf_alpha3{data_point,sim_instance}.val = 1- (length(scheduled_packets_ealpha3.packet_id)/length(packets_ordered_ealpha3.packet_id));
        %total_pack = length(packets_ordered_fcfs.packet_id);
%         for i = 1:total_pack
%             if ~ismember(packets_ordered_fcfs.packet_id(i),mi)
%                 dropped_pack_mwbm = dropped_pack_mwbm +1;
%             end
%         end   
%         results_packet_drop.bipartite_matching{data_point,sim_instance}.val = dropped_pack_mwbm/length(packets_ordered_fcfs.packet_id);
%         
%       Calculating system time data
        results_system_time.max_weight{data_point,sim_instance}.val = mean(scheduled_packets_mw.slotted_times - scheduled_packets_mw.release_times);
        results_system_time.edf_alpha1{data_point,sim_instance}.val = mean(scheduled_packets_ealpha1.slotted_times - scheduled_packets_ealpha1.release_times);
        results_system_time.edf_alpha2{data_point,sim_instance}.val = mean(scheduled_packets_ealpha2.slotted_times - scheduled_packets_ealpha2.release_times);
        results_system_time.edf_alpha3{data_point,sim_instance}.val = mean(scheduled_packets_ealpha3.slotted_times - scheduled_packets_ealpha3.release_times);
        
%         mwbm_sys_time = zeros(length(mi),1);
%         for j = 1:length(mi)
%             mwbm_sys_time(j) = mwbm_sys_time(j) + ((mj(j)*slot_length) - (find(bipartite_graph_matrix(mi(j),:),1)-1)*slot_length);
%         end
%         %results_system_time.bipartite_matching{data_point,sim_instance}.val = mean(mj*slot_length - packets_ordered_fcfs.release_times(mi));  
%         results_system_time.bipartite_matching{data_point,sim_instance}.val = mean(mwbm_sys_time);
        
        fprintf('Simulations running for: data point %i and simulation instace %i.\n',data_point,sim_instance);

    end
end