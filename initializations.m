%clear;
clc;
testFile = load('vr_Headset_View_1080p30_30_8000_out_bytes.mat');
%%Reading the input files and initializing the starting vectors
traceFile{1} = readmatrix('ge_cities_40mbps_60fps'); %Google Earth VR - Cities trace file
traceFile{2} = readmatrix('ge_cities_40mbps_30fps'); %Google Earth VR - Cities trace file
traceFile{3} = readmatrix('ge_tour_40mbps_60fps'); %Google Earth VR - Tour trace file
traceFile{4} = readmatrix('ge_tour_40mbps_30fps'); %Google Earth VR - Tour VR trace file
traceFile{5} = readmatrix('mc_40mbps_60fps'); %Minecraft trace file
traceFile{6} = readmatrix('mc_40mbps_30fps'); %Minecraft trace file
traceFile{7} = readmatrix('vp_40mbps_60fps'); %Virus Popper trace file
traceFile{8} = readmatrix('vp_40mbps_30fps'); %Virus Popper trace file
num_users = 4;
num_frame = 100;
time_slots = 0.0000625*ones(num_frame,1);
time_slots = 0.0000625;
Burst_Size = zeros(num_frame, num_users);
t_nxt_frame = zeros(num_frame, num_users);

for i=1:num_users
    Burst_Size(:,i) = traceFile{i}(1 : num_frame, 1);  %Represents the trace burst sizes in Bytes
end

for i=1:num_users
    t_nxt_frame(:,i) = traceFile{i}(1 : num_frame, 2); %Represents the time to next arriving frame in seconds
end

t_arrival = zeros(length(t_nxt_frame),num_users);

%num_users = ones(length(Burst_Size),1);
%num_users(length(num_users)/3 +1 : 2*length(num_users)/3) = 2;
%num_users(2*length(num_users)/3 : end) = 3;

%btime = zeros(100,1);
initial_QoE = ones(100,98);
for i = 1:length(t_arrival)
    for j = 1:num_users
        t_arrival(i+1,j) = t_nxt_frame(i,j) + t_arrival(i,j);
        
    end
end    


t_arrival = t_arrival(1:length(t_nxt_frame),:);
%T_arrival provides the arrival time of all the frames, with each column
%corresponding to each user's frames
%% Defining variables(num_users etc.)
n = num_users;
q = 0.016;            %quantum time- a round-robin scheduler generally employs time-sharing, giving each job a time slot or quantum


%Initial_QoE = floor(n_pack_burst./(1000.*t_nxt_frame)); %Preliminarily defining this to be a
%fraction of the total number of packets encompassing a frame and taking
%the time to next frame into account as well
n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
av_frame_size = mean(n_pack_burst);
[QoE_order, QoE_order_indices] = sort(round(av_frame_size));
QoE = ones(length(t_arrival),num_users);


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
    QoE(:,i) = i*QoE(:,i);
end
%QoE = QoE(:,QoE_order_indices);

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
for i = 1:num_users
    packets{i} = (1:1:length(t_arrival))';
    packets{i}(:,2) = t_arrival(:,i);
    packets{i}(:,3) = round(n_pack_burst(:,i));
    packets{i}(:,4) = QoE(:,i);
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