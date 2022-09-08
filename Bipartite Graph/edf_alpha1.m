function [total_value, scheduled_packets, dropped_packets, packets_ordered] = edf_alpha1(users,selected_users,data_point,slot_length, alpha)

all_frames_together_release_times = [];
all_frames_together_frameSizeB = [];
all_frames_together_number_of_packets_per_frame = [];
all_frames_together_frame_deadline = [];
all_frames_together_frame_value = [];
all_user_ids_together = [];
total_number_of_packets = 0;
frames_ordered = struct;
packets_ordered = struct;

%Concatenating the initial data 
for user_id = 1:data_point
    all_frames_together_release_times = [all_frames_together_release_times; users{selected_users(user_id)}.frame_release_times(1:end-1)];
    all_frames_together_frameSizeB = [all_frames_together_frameSizeB; users{selected_users(user_id)}.frameSizeB(1:end-1)];
    all_frames_together_number_of_packets_per_frame = [all_frames_together_number_of_packets_per_frame; users{selected_users(user_id)}.number_of_packets_per_frame(1:end-1)];
    all_frames_together_frame_deadline = [all_frames_together_frame_deadline; users{selected_users(user_id)}.frame_deadline];
    all_frames_together_frame_value = [all_frames_together_frame_value; users{selected_users(user_id)}.value*ones(users{selected_users(user_id)}.nf-1,1)];
    all_user_ids_together = [all_user_ids_together; selected_users(user_id)*ones(users{selected_users(user_id)}.nf-1,1)];   
    total_number_of_packets = total_number_of_packets + sum(users{selected_users(user_id)}.number_of_packets_per_frame(1:end-1));             

end

%Ordering in the frame level based on earliest deadline policy
[frames_ordered.frame_deadline, frames_ordered.index] = sort(all_frames_together_frame_deadline);
frames_ordered.frameSizeB = all_frames_together_frameSizeB(frames_ordered.index);
frames_ordered.number_of_packets_per_frame = all_frames_together_number_of_packets_per_frame(frames_ordered.index);
frames_ordered.release_times = all_frames_together_release_times(frames_ordered.index);
frames_ordered.frame_value = all_frames_together_frame_value(frames_ordered.index);
frames_ordered.user_ids = all_user_ids_together(frames_ordered.index);

corresponding_frameSizeB = [];
corresponding_release_times = [];
corresponding_frames_ordered_index = [];
corresponding_frame_number_of_packets_per_frame = [];
corresponding_frame_deadline = [];
corresponding_frame_value = [];
corresponding_frame_user_id = [];

%Changing frame level data to packet level data for packet level scheduling
for frame = 1:length(frames_ordered.release_times)
    corresponding_frameSizeB = [corresponding_frameSizeB; frames_ordered.frameSizeB(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_release_times = [corresponding_release_times; frames_ordered.release_times(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_frames_ordered_index = [corresponding_frames_ordered_index; frames_ordered.index(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_frame_number_of_packets_per_frame = [corresponding_frame_number_of_packets_per_frame; frames_ordered.number_of_packets_per_frame(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_frame_deadline = [corresponding_frame_deadline; frames_ordered.frame_deadline(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_frame_value = [corresponding_frame_value; frames_ordered.frame_value(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
    corresponding_frame_user_id = [corresponding_frame_user_id; frames_ordered.user_ids(frame)*ones(frames_ordered.number_of_packets_per_frame(frame),1)];
end

packets_ordered.packet_id = [1:total_number_of_packets].';
packets_ordered.corresponding_frameSizeB = corresponding_frameSizeB;
packets_ordered.release_times = corresponding_release_times;
packets_ordered.corresponding_frames_index = corresponding_frames_ordered_index;
packets_ordered.corresponding_frame_number_of_packets_per_frame = corresponding_frame_number_of_packets_per_frame;
packets_ordered.deadlines = corresponding_frame_deadline;
packets_ordered.values = corresponding_frame_value;
packets_ordered.user_id = corresponding_frame_user_id;


scheduled_packets = struct;
dropped_packets = struct;
current_time_instance = 0;
temp_packet_index = 1;
scheduled_packet_index = 0;
dropped_packet_index = 0;
packet_exclusion_index = 0;
q = 0;

%Scheduling/Dropping policy
while(temp_packet_index <= total_number_of_packets)
    if(current_time_instance < packets_ordered.release_times(temp_packet_index))        
         current_time_instance = ceil(packets_ordered.release_times(temp_packet_index)/slot_length)*slot_length;
         
         packets_ordered.available_packets = find(packets_ordered.release_times <= current_time_instance);
         available_packets.values = packets_ordered.values(packets_ordered.available_packets);
         available_packets.packet_id = packets_ordered.packet_id(packets_ordered.available_packets);
         available_packets.release_times = packets_ordered.release_times(packets_ordered.available_packets);
         available_packets.corresponding_frameSizeB = packets_ordered.corresponding_frameSizeB(packets_ordered.available_packets);
         available_packets.deadlines = packets_ordered.deadlines(packets_ordered.available_packets);
         available_packets.corresponding_frame_number_of_packets_per_frame = packets_ordered.corresponding_frame_number_of_packets_per_frame(packets_ordered.available_packets);
         available_packets.corresponding_frames_index = packets_ordered.corresponding_frames_index(packets_ordered.available_packets);
         available_packets.user_id = packets_ordered.user_id(packets_ordered.available_packets);

         [max_val, max_index] = max(available_packets.values);
        if(packets_ordered.deadlines(max_index) >= current_time_instance + slot_length)
            scheduled_packets.packet_id(scheduled_packet_index + 1) = available_packets.packet_id(max_index);
            scheduled_packets.corresponding_frameSizeB(scheduled_packet_index + 1) = available_packets.corresponding_frameSizeB(max_index);
            scheduled_packets.release_times(scheduled_packet_index + 1) = available_packets.release_times(max_index);
            scheduled_packets.corresponding_frames_index(scheduled_packet_index + 1) = available_packets.corresponding_frames_index(max_index);
            scheduled_packets.corresponding_frame_number_of_packets_per_frame(scheduled_packet_index + 1) = available_packets.corresponding_frame_number_of_packets_per_frame(max_index);
            scheduled_packets.deadlines(scheduled_packet_index + 1) = available_packets.deadlines(max_index);
            scheduled_packets.values(scheduled_packet_index + 1) = available_packets.values(max_index);
            scheduled_packets.user_id(scheduled_packet_index + 1) = available_packets.user_id(max_index);
            
            current_time_instance = current_time_instance + slot_length;
            temp_packet_index = temp_packet_index + 1;
            scheduled_packet_index = scheduled_packet_index + 1;
        else
            dropped_packets.packet_id(dropped_packet_index + 1) = available_packets.packet_id(max_index);
            dropped_packets.corresponding_frameSizeB(dropped_packet_index + 1) = available_packets.corresponding_frameSizeB(max_index);
            dropped_packets.release_times(dropped_packet_index + 1) = available_packets.release_times(max_index);
            dropped_packets.corresponding_frames_index(dropped_packet_index + 1) = available_packets.corresponding_frames_index(max_index);
            dropped_packets.corresponding_frame_number_of_packets_per_frame(dropped_packet_index + 1) = available_packets.corresponding_frame_number_of_packets_per_frame(max_index);
            dropped_packets.deadlines(dropped_packet_index + 1) = available_packets.deadlines(max_index);
            dropped_packets.values(scheduled_packet_index + 1) = available_packets.values(max_index);
            dropped_packets.user_id(dropped_packet_index + 1) = available_packets.user_id(max_index);
            
            temp_packet_index = temp_packet_index + 1;
            dropped_packet_index = dropped_packet_index + 1;
        end
        available_packets.packet_id = [available_packets.packet_id(1:max_index -1); available_packets.packet_id(max_index +1:end)];
        available_packets.corresponding_frameSizeB = [available_packets.corresponding_frameSizeB(1:max_index -1); available_packets.corresponding_frameSizeB(max_index +1:end)];
        available_packets.release_times = [available_packets.release_times(1:max_index -1); available_packets.release_times(max_index +1:end)];
        available_packets.corresponding_frames_index = [available_packets.corresponding_frames_index(1:max_index -1); available_packets.corresponding_frames_index(max_index +1:end)];
        available_packets.corresponding_frame_number_of_packets_per_frame = [available_packets.corresponding_frame_number_of_packets_per_frame(1:max_index -1); available_packets.corresponding_frame_number_of_packets_per_frame(max_index +1:end)];
        available_packets.deadlines = [available_packets.deadlines(1:max_index -1); available_packets.deadlines(max_index +1:end)];
        available_packets.values = [available_packets.values(1:max_index -1); available_packets.values(max_index +1:end)];
        available_packets.user_id = [available_packets.user_id(1:max_index -1); available_packets.user_id(max_index +1:end)];
    
    else
        %These packets are sorted in increasing order of deadlines
        packets_ordered.available_packets = find(find(packets_ordered.release_times <= current_time_instance) > packet_exclusion_index);
        available_packets.values = packets_ordered.values(packets_ordered.available_packets);
        available_packets.packet_id = packets_ordered.packet_id(packets_ordered.available_packets);
        available_packets.release_times = packets_ordered.release_times(packets_ordered.available_packets);
        available_packets.corresponding_frameSizeB = packets_ordered.corresponding_frameSizeB(packets_ordered.available_packets);
        available_packets.deadlines = packets_ordered.deadlines(packets_ordered.available_packets);
        available_packets.corresponding_frame_number_of_packets_per_frame = packets_ordered.corresponding_frame_number_of_packets_per_frame(packets_ordered.available_packets);
        available_packets.corresponding_frames_index = packets_ordered.corresponding_frames_index(packets_ordered.available_packets);
        available_packets.user_id = packets_ordered.user_id(packets_ordered.available_packets);
        
        available_packet_number = length(available_packets.release_times);

        while (q <= available_packet_number) %Iterating through all the available packets
            [max_val, max_index] = max(available_packets.values);
            if(available_packets.deadlines(1) >= current_time_instance + slot_length) %The deadline is later than the potential slotted time for a particular packet
                if ( available_packets.values(1) >= max_val/alpha ) % Weight_e >= Weight_MaxW/alpha
                    scheduled_packets.packet_id(scheduled_packet_index + 1) = available_packets.packet_id(1);
                    scheduled_packets.corresponding_frameSizeB(scheduled_packet_index + 1) = available_packets.corresponding_frameSizeB(1);
                    scheduled_packets.release_times(scheduled_packet_index + 1) = available_packets.release_times(1);
                    scheduled_packets.corresponding_frames_index(scheduled_packet_index + 1) = available_packets.corresponding_frames_index(1);
                    scheduled_packets.corresponding_frame_number_of_packets_per_frame(scheduled_packet_index + 1) = available_packets.corresponding_frame_number_of_packets_per_frame(1);
                    scheduled_packets.deadlines(scheduled_packet_index + 1) = available_packets.deadlines(1);
                    scheduled_packets.values(scheduled_packet_index + 1) = available_packets.values(1);
                    scheduled_packets.user_id(scheduled_packet_index + 1) = available_packets.user_id(1);
            
                    current_time_instance = current_time_instance + slot_length;
                    temp_packet_index = temp_packet_index + 1;
                    scheduled_packet_index = scheduled_packet_index + 1;
                    q = q + 1;
                    available_packets.packet_id = available_packets.packet_id(2:end);
                    available_packets.corresponding_frameSizeB = available_packets.corresponding_frameSizeB(2:end);
                    available_packets.release_times = available_packets.release_times(2:end);
                    available_packets.corresponding_frames_index = available_packets.corresponding_frames_index(2:end);
                    available_packets.corresponding_frame_number_of_packets_per_frame = available_packets.corresponding_frame_number_of_packets_per_frame(2:end);
                    available_packets.deadlines = available_packets.deadlines(2:end);
                    available_packets.values = available_packets.values(2:end);
                    available_packets.user_id = available_packets.user_id(2:end);

                else
                    scheduled_packets.packet_id(scheduled_packet_index + 1) = available_packets.packet_id(max_index);
                    scheduled_packets.corresponding_frameSizeB(scheduled_packet_index + 1) = available_packets.corresponding_frameSizeB(max_index);
                    scheduled_packets.release_times(scheduled_packet_index + 1) = available_packets.release_times(max_index);
                    scheduled_packets.corresponding_frames_index(scheduled_packet_index + 1) = available_packets.corresponding_frames_index(max_index);
                    scheduled_packets.corresponding_frame_number_of_packets_per_frame(scheduled_packet_index + 1) = available_packets.corresponding_frame_number_of_packets_per_frame(max_index);
                    scheduled_packets.deadlines(scheduled_packet_index + 1) = available_packets.deadlines(max_index);
                    scheduled_packets.values(scheduled_packet_index + 1) = available_packets.values(max_index);
                    scheduled_packets.user_id(scheduled_packet_index + 1) = available_packets.user_id(max_index);
            
                    current_time_instance = current_time_instance + slot_length;
                    temp_packet_index = temp_packet_index + 1;
                    scheduled_packet_index = scheduled_packet_index + 1;
                    q = q + 1;
                    available_packets.packet_id = [available_packets.packet_id(1:max_index -1); available_packets.packet_id(max_index +1:end)];
                    available_packets.corresponding_frameSizeB = [available_packets.corresponding_frameSizeB(1:max_index -1); available_packets.corresponding_frameSizeB(max_index +1:end)];
                    available_packets.release_times = [available_packets.release_times(1:max_index -1); available_packets.release_times(max_index +1:end)];
                    available_packets.corresponding_frames_index = [available_packets.corresponding_frames_index(1:max_index -1); available_packets.corresponding_frames_index(max_index +1:end)];
                    available_packets.corresponding_frame_number_of_packets_per_frame = [available_packets.corresponding_frame_number_of_packets_per_frame(1:max_index -1); available_packets.corresponding_frame_number_of_packets_per_frame(max_index +1:end)];
                    available_packets.deadlines = [available_packets.deadlines(1:max_index -1); available_packets.deadlines(max_index +1:end)];
                    available_packets.values = [available_packets.values(1:max_index -1); available_packets.values(max_index +1:end)];
                    available_packets.user_id = [available_packets.user_id(1:max_index -1); available_packets.user_id(max_index +1:end)];
                end


            else %The deadline is earlier than the potential slotted time for a particular packet and hence the packets need to be dropped

                dropped_packets.packet_id(dropped_packet_index + 1) = available_packets.packet_id(1);
                dropped_packets.corresponding_frameSizeB(dropped_packet_index + 1) = available_packets.corresponding_frameSizeB(1);
                dropped_packets.release_times(dropped_packet_index + 1) = available_packets.release_times(1);
                dropped_packets.corresponding_frames_index(dropped_packet_index + 1) = available_packets.corresponding_frames_index(1);
                dropped_packets.corresponding_frame_number_of_packets_per_frame(dropped_packet_index + 1) = available_packets.corresponding_frame_number_of_packets_per_frame(1);
                dropped_packets.deadlines(dropped_packet_index + 1) = available_packets.deadlines(1);
                dropped_packets.values(scheduled_packet_index + 1) = available_packets.values(1);
                dropped_packets.user_id(dropped_packet_index + 1) = available_packets.user_id(1);
            
                temp_packet_index = temp_packet_index + 1;
                dropped_packet_index = dropped_packet_index + 1;
                q = q + 1;
                available_packets.packet_id = available_packets.packet_id(2:end);
                available_packets.corresponding_frameSizeB = available_packets.corresponding_frameSizeB(2:end);
                available_packets.release_times = available_packets.release_times(2:end);
                available_packets.corresponding_frames_index = available_packets.corresponding_frames_index(2:end);
                available_packets.corresponding_frame_number_of_packets_per_frame = available_packets.corresponding_frame_number_of_packets_per_frame(2:end);
                available_packets.deadlines = available_packets.deadlines(2:end);
                available_packets.values = available_packets.values(2:end);
                available_packets.user_id = available_packets.user_id(2:end);
            end
        end  
        %packet_exclusion_index = packet_exclusion_index + q;
    end
end
total_value = sum(scheduled_packets.values);
end