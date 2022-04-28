%%Reading the input files and initializing the starting vectors
traceFile = readmatrix('ge_cities_40mbps_60fps'); %Google VR trace file
Burst_Size = traceFile(1 : 100, 1);  %Represents the trace burst sizes in Bytes
t_nxt_frame = traceFile(1 : 100, 2); %Represents the time to next arriving frame in seconds
t_arrival = zeros(length(t_nxt_frame),1);

for i=1:length(t_arrival)
    t_arrival(i+1) = t_nxt_frame(i) + t_arrival(i);
end    
t_arrival = t_arrival(1:length(t_nxt_frame));
%T_arrival provides the arrival time of all the frames
%% Defining variables(num_users etc.)
n = 10;
q = 0.016;            %quantum time- a round-robin scheduler generally employs time-sharing, giving each job a time slot or quantum


%Initial_QoE = floor(n_pack_burst./(1000.*t_nxt_frame)); %Preliminarily defining this to be a
%fraction of the total number of packets encompassing a frame and taking
%the time to next frame into account as well


%Sort the Scheduled frames according to the QoEs
%[sorted_QoE, sortQoEIdx] = sort(Initial_QoE,'descend');
%Captures the original indices of the QoE values to find the corresponding
%frames and times
%A = find(Initial_QoE==15); Testing the correctness
%sorted_burst = Burst_Size(sortQoEIdx);
%t_sorted_nxt_frame = t_nxt_frame(sortQoEIdx);






%% Finding the number of packets per burst and populating the cells accordingly
n_pack_burst = Burst_Size./1320;       %Number of packets per burst 
s_no = zeros(length(n_pack_burst),max(round(n_pack_burst))); %Dimensions of
% s_no are [total_num_frames,frame_with_max_packets]

for i = 1:length(n_pack_burst)
    s_no(i, 1:max(round(n_pack_burst(i)))) = linspace(1, round(n_pack_burst(i)), round(n_pack_burst(i)));    
end    
[row,column] = size(s_no);

%s_no = s_no(:).';
%s_no_numerals = ones(1,length(n_pack_burst));
%s_no_frames = repelem(linspace(1, length(n_pack_burst), length(n_pack_burst)) , column);
%t_deadline_packets = randi([-5,5],1,3257124);
%s_no = find(s_no);
%frame_packet_mapper = transpose([s_no_frames(k); s_no(k)]);
%B = frame_packet_mapper(1:10000,:);
t_arrival_packet = t_arrival./(round(n_pack_burst));
ty = t_arrival_packet;
t_arrival_packet = t_arrival_packet.*s_no;
t_arrival_packet = t_arrival_packet./s_no;
t_arrival_packet(isnan(t_arrival_packet))=0;
%for i = 1:length(n_pack_burst)
%    t_arrival_packet = repelem(t_arrival_packet, (round(n_pack_burst(i))));
%end    
packet.frames = num2cell(s_no); %Rows correspond to frame number, columns correspond to packet number of that frame
p = length(n_pack_burst);
%[users.delays{:}] = deal(zeros(1,num_frames-prediction_horizon)); 
packet.arrival = num2cell(t_arrival_packet);
%users.packet_throughput = cell(1,num_users); 
 
%users.delivered_frames = cell(1,num_users);