%clear;
clc;
%testFile = load('vr_Headset_View_1080p30_30_8000_out_bytes.mat');
testFile = readmatrix('ge_cities_40mbps_60fps');
%%Reading the input files and initializing the starting vectors

traceFiles = dir(fullfile('Atlantis', '*.mat'));
for k = 1 : length(traceFiles)
     baseFileName = traceFiles(k).name;
     fullFileName = fullfile(traceFiles(k).folder, baseFileName);
    traceFileMain{k} = load(fullFileName);
    traceFile{k} = traceFileMain{k}.frameSizeB;
end


% traceFile{1} = load('Atlantis/vr_Headset_View_1080p30_30_8000_bytes.mat');
% traceFile{1} = traceFile{1}.frameSizeB;
% traceFile{3} = load('Atlantis/vr_Headset_View_1080p30_30_11000_bytes.mat');
% traceFile{3} = traceFile{3}.frameSizeB;
% traceFile{5} = load('Atlantis/vr_Headset_View_1080p30_30_13000_bytes.mat');
% traceFile{5} = traceFile{5}.frameSizeB;
% traceFile{7} = load('Atlantis/vr_Headset_View_1080p30_30_16000_bytes.mat');
% traceFile{7} = traceFile{7}.frameSizeB;
% traceFile{2} = load('Atlantis/vr_Headset_View_1080p60_60_16000_bytes.mat');
% traceFile{2} = traceFile{2}.frameSizeB;
% traceFile{4} = load('Atlantis/vr_Headset_View_1080p60_60_22000_bytes.mat');
% traceFile{4} = traceFile{4}.frameSizeB;
% traceFile{6} = load('Atlantis/vr_Headset_View_1080p60_60_25000_bytes.mat');
% traceFile{6} = traceFile{6}.frameSizeB;
% traceFile{8} = load('Atlantis/vr_Headset_View_1080p60_60_30000_bytes.mat');
% traceFile{8} = traceFile{8}.frameSizeB;

num_users = 8;
num_frame = 10;
num_sim = 500;
%time_slots = 0.0000625*ones(70000,1);
%time_slots = 0.00025; %Time slot length in seconds
time_slots = 0.000125;
%time_slots = 0.0000625;
deadline = 1;
Burst_Size = zeros(num_frame, num_users);
t_nxt_frame = zeros(num_frame, num_users);
%alpha = 1.618;
alpha = 1;
for i=1:num_users
    Burst_Size(:,i) = traceFile{i}(201 : 200 + num_frame, 1);  %Represents the trace burst sizes in Bytes
end
% Burst_Size = Burst_Size*0.3;
% for i=1:num_users
%     t_nxt_frame(:,i) = traceFile{i}(1 : num_frame, 2); %Represents the time to next arriving frame in seconds
% end

% for i = 1:num_users
%     if mod( i , 2 ) == 0
%         t_nxt_frame(:,i) = 1/60*ones(num_frame,1)';
%     else
%         t_nxt_frame(:,i) = 1/30*ones(num_frame,1)';
%     end
% end    
for i = 1:num_users
    if traceFileMain{i}.fps == 60
        t_nxt_frame(:,i) = 1/60*ones(num_frame,1)';
    else
        t_nxt_frame(:,i) = 1/30*ones(num_frame,1)';
    end
end    
t_arrival = zeros(length(t_nxt_frame),num_users);

%num_users = ones(length(Burst_Size),1);
%num_users(length(num_users)/3 +1 : 2*length(num_users)/3) = 2;
%num_users(2*length(num_users)/3 : end) = 3;

%btime = zeros(100,1);

for i = 1:length(t_arrival)
    for j = 1:num_users
        t_arrival(i+1,j) = t_nxt_frame(i,j) + t_arrival(i,j);
        
    end
end    


t_arrival = t_arrival(1:length(t_nxt_frame),:);


% Burst_Size(1:2,2) = 0;
% t_arrival(1:2,2) = 0;
% 
% Burst_Size(1:4,3) = 0;
% t_arrival(1:4,3) = 0;
% 
% Burst_Size(1:3,4) = 0;
% t_arrival(1:3,4) = 0;
% 
% Burst_Size(1:6,6) = 0;
% t_arrival(1:6,6) = 0;
%T_arrival provides the arrival time of all the frames, with each column
%corresponding to each user's frames
%% Defining variables(num_users etc.)
n = num_users;
q = 0.016;            %quantum time- a round-robin scheduler generally employs time-sharing, giving each job a time slot or quantum


%Initial_QoE = floor(n_pack_burst./(1000.*t_nxt_frame)); %Preliminarily defining this to be a
%fraction of the total number of packets encompassing a frame and taking
%the time to next frame into account as well
n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
total_pack = sum(n_pack_burst);
av_frame_size = mean(n_pack_burst);
%[QoE_order, QoE_order_indices] = sort(round(av_frame_size));
%QoE = ones(length(t_arrival),num_users);
QoE = repmat(round((av_frame_size)./10),length(t_arrival),1);

%Sort the Scheduled frames according to the QoEs
%[sorted_QoE, sortQoEIdx] = sort(Initial_QoE,'descend');
%Captures the original indices of the QoE values to find the corresponding
%frames and times
%A = find(Initial_QoE==15); Testing the correctness
%sorted_burst = Burst_Size(sortQoEIdx);
%t_sorted_nxt_frame = t_nxt_frame(sortQoEIdx);






%% Finding the number of packets per burst and populating the cells accordingly

for i= 1:num_users
    s_no{i} = zeros(length(n_pack_burst),max(round(n_pack_burst(:,i)))); %Dimensions of
% s_no are [total_num_frames,frame_with_max_packets]
    %QoE(:,i) = i*QoE(:,i);
end
%QoE = QoE(:,QoE_order_indices);
%QoE_arr = 1:num_users;
for i = 1:length(n_pack_burst)
    for j = 1:num_users
        s_no{j}(i, 1:(round(n_pack_burst(i,j)))) = linspace(1, round(n_pack_burst(i,j)), round(n_pack_burst(i,j))); 
    end
end    
%[row,column] = size(s_no);
users = s_no;
for i=1:num_users
    users{i}(i) = i;
end    
%s_no = s_no(:).';
%s_no_numerals = ones(1,length(n_pack_burst));
%s_no_frames = repelem(linspace(1, length(n_pack_burst), length(n_pack_burst)) , column);
%t_deadline_packets = randi([-5,5],1,3257124);
%s_no = find(s_no);
%frame_packet_mapper = transpose([s_no_frames(k); s_no(k)]);
%B = frame_packet_mapper(1:10000,:);
t_arrival_packet = t_arrival./(round(n_pack_burst)); % packets having divided time?
t_arrival_packet = t_arrival; %All the packets arriving at the same time?
ty = t_arrival_packet;
for i = 1:num_users
    t_arrival_pack{i} = t_arrival_packet(:,i).*s_no{i};
    t_arrival_pack{i} = t_arrival_pack{i}./s_no{i};
    %t_arrival_pack{i}(isnan(t_arrival_pack{i}))=0;
end
%t_arrival_pack has as many cells as the number of users
%Within each cell, is the characteristics of that user
%Number of rows for a user is the frame number of a packet
%Number of non-zero columns is the number of packets for that frame
%The precise entries are the arrival time of that particular packet 

%t_arrival_packet = t_arrival_packet./s_no;
%for i = 1:length(n_pack_burst)
%    t_arrival_packet = repelem(t_arrival_packet, (round(n_pack_burst(i))));
%end    
%packet.frames = num2cell(s_no); %Rows correspond to frame number, columns correspond to packet number of that frame
p = length(n_pack_burst);
%[users.delays{:}] = deal(zeros(1,num_frames-prediction_horizon)); 
%packet.arrival = num2cell(t_arrival_pack);
%packet.QoE = num2cell(initial_QoE);
%packet.user = num2cell(users);
%%TODO build a multiple user association for the video frames and schedule
%%accordingly
%users.packet_throughput = cell(1,num_users); 

%Column1 = Frame ID
%Column2 = Frame Deadline
%Column3 = Num_Packets for that frame
%Column4 = QoE for that user
t_deadline = t_arrival(2:end,:);
t_deadline(num_frame,:) = t_deadline(num_frame-1,:) + 0.0333;
jitter = normrnd(0,0.002,[length(t_arrival),num_users]);
jitter(jitter < 0) = 0;
jitter(jitter > 0.004) = 0.004;
t_arrival = t_arrival + jitter;
for i = 1:num_users
    packets{i} = (1:1:length(t_arrival))';
    packets{i}(:,2) = t_arrival(:,i);
    packets{i}(:,3) = ceil(n_pack_burst(:,i));
    packets{i}(:,4) = QoE(:,i);
    packets{i}(:,5) = t_deadline(:,i);
end    

%for i = 1:num_frame
%    for j = 1:num_users
%        for k = 1:packets{j}(i,3)
%            frame{j,i}(k,1) = packets{j}(i,2);
            %frame{j,i}(k,2) = i;
%            frame{j,i}(k,2) = packets{j}(i,4);
%        end
%    end   
%end    
%C = {cat(1, frame{:})};
%for i = 1:num_users
%packet{1} = (cat(1, frame{1,:}));
%packet{2} = (cat(1, frame{2,:}));
%end
    %users.delivered_frames = cell(1,num_users);
% figure;
% %mean = cell2mat(struct2cell(File1))
% File1 = load('Atlantis results/mean_sys_time1_FCFS.mat');
% File2 = load('Atlantis results/mean_sys_time2_FCFS.mat');
% File3 = load('Atlantis results/mean_sys_time3_FCFS.mat');
% File4 = load('Atlantis results/mean_sys_time4_FCFS.mat');
% File5 = load('Atlantis results/mean_sys_time5_FCFS.mat');
% File6 = load('Atlantis results/mean_sys_time6_FCFS.mat');
% File7 = load('Atlantis results/mean_sys_time7_FCFS.mat');
% File8 = load('Atlantis results/mean_sys_time8_FCFS.mat');
% Mean_sys_time = [cell2mat(struct2cell(File1)), cell2mat(struct2cell(File2)), cell2mat(struct2cell(File3)), cell2mat(struct2cell(File4)), cell2mat(struct2cell(File5)), cell2mat(struct2cell(File6)), cell2mat(struct2cell(File7)), cell2mat(struct2cell(File8))];
% Mean_sys_time = 1000*Mean_sys_time;
% plot(1:8,(Mean_sys_time), 'LineWidth', 4);
% title('Average System time for different #user scenarios');
% %legend('FCFS', 'Round Robin', 'EDF')
% xlabel('#Users');
% ylabel('Time (ms)');






% 
% for j = 1:num_users
%     plot( 1:100, Burst_Size(:,j)./1000);
%     hold on;
% end    
% title('Frame Size variation across users');
% xlabel('Frame Number');
% ylabel('Frame Size in Kb');
% legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');
% figure;
% 
% for i = 1:num_users
%     histogram( Burst_Size(:,i)./1000);
%     hold on;
% end    
% title('Histogram of frame distibution');
% xlabel('Frame Size in Kb');
% legend('User 1(60 FPS)', 'User 2(30 FPS)', 'User 3(60 FPS)', 'User 4(30 FPS)', 'User 5(60 FPS)', 'User 6(30 FPS)', 'User 7(60 FPS)', 'User 8(30 FPS)');