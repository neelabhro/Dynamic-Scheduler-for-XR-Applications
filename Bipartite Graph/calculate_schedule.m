function [results] = calculate_schedule(path_to_files)
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
    users{k} = load(fullFileName);
end



%number of users
N = length(theFiles);
%number of simulation insances
S = 1;
%slot length in ms(depends on the SCS)
slot_length = 0.125;
%maximum release time in ms
max_release_time = 5000;
%packetsize in B
packet_size = 1320;

for n = 1 : N
    users{n}.number_of_packets_per_frame = ceil(users{n}.frameSizeB./packet_size); 
end

%Trace filese too big! Truncate trace files due to memory issue problems. 
for n = 1 : N
    truncuated_length = ceil(users{n}.nf/1000);
    trace_slice_lower_bound = randi([1 users{n}.nf-truncuated_length],1,1);
    trace_slice_upper_bound = trace_slice_lower_bound + truncuated_length;
    users_truncuated{n}.avgframeSizekB = users{n}.avgframeSizekB;
    users_truncuated{n}.fps = users{n}.fps;
    users_truncuated{n}.frameSizeB = users{n}.frameSizeB(trace_slice_lower_bound:trace_slice_upper_bound-1);
    users_truncuated{n}.frametype = users{n}.frametype(trace_slice_lower_bound:trace_slice_upper_bound-1);
    users_truncuated{n}.info = users{n}.info;
    users_truncuated{n}.nf = truncuated_length;
    users_truncuated{n}.number_of_packets_per_frame = users{n}.number_of_packets_per_frame(trace_slice_lower_bound:trace_slice_upper_bound-1);
end

users = users_truncuated;

for n = 1:N
    for sim_instance = 1:S
        %select a set of users uniformly at random for a simulation scanario
        selected_users = randi([1 N],1,n);
        %select release times of the first frame for each user uniformly at
        %random for a simulation scanario
        first_frame_release_times = randi([1 max_release_time],1,n);
        
        for user_id = 1:n
            fps_increment = (1/users{selected_users(user_id)}.fps)*1000;
            users{selected_users(user_id)}.frame_release_times = first_frame_release_times(user_id) + fps_increment*(0:users{selected_users(user_id)}.nf-1)';            
        end
        
        [bipartite_graph_matrix] = compute_bipartite_graph(users,selected_users,n,slot_length);
        
        %call all scheduling algorithms and save corresponding results
        [val mi mj] = bipartite_matching(bipartite_graph_matrix);          
        results{n,sim_instance}.val = val;
        results{n,sim_instance}.mi = mi;
        results{n,sim_instance}.mj = mj;
    end
end
end

