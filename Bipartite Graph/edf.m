function [total_value , scheduled_packets, dropped_packets, packets_ordered] = edf(users,selected_users,data_point,slot_length)

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

%Ordering in the frame level
[frames_ordered.release_times, frames_ordered.index] = sort(all_frames_together_release_times);
frames_ordered.frameSizeB = all_frames_together_frameSizeB(frames_ordered.index);
frames_ordered.number_of_packets_per_frame = all_frames_together_number_of_packets_per_frame(frames_ordered.index);
frames_ordered.frame_deadline = all_frames_together_frame_deadline(frames_ordered.index);
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




%max_weight_queue = java.util.PriorityQueue;
available_packet_queue = [];
available_packet_queue_ids = [];
available_packet_queue_deadlines = [];
scheduled_packets = struct;
dropped_packets = struct;
temp_packet_index = 1;
scheduled_packet_index = 0;
dropped_packet_index = 0;
temp_available_packet_index = 1;
%edf_index = 1;


current_time_instance = ceil(packets_ordered.release_times(temp_packet_index)/slot_length)*slot_length;

while(temp_packet_index <= total_number_of_packets)

    if(current_time_instance < packets_ordered.release_times(temp_available_packet_index) && isempty(available_packet_queue))
        current_time_instance = ceil(packets_ordered.release_times(temp_available_packet_index)/slot_length)*slot_length;
    end

    while(temp_available_packet_index <= total_number_of_packets)

        if(packets_ordered.release_times(temp_available_packet_index) <= current_time_instance)
            available_packet_queue = [available_packet_queue packets_ordered.values(temp_available_packet_index)];
            available_packet_queue_ids = [available_packet_queue_ids packets_ordered.packet_id(temp_available_packet_index)];
            available_packet_queue_deadlines = [available_packet_queue_deadlines packets_ordered.deadlines(temp_available_packet_index)];
            temp_available_packet_index = temp_available_packet_index + 1;
        else
            break;
        end

    end

    if(temp_available_packet_index > total_number_of_packets)
        temp_available_packet_index = total_number_of_packets;
    end

    if(~isempty(available_packet_queue))
        [~, edf_index] = min(available_packet_queue_deadlines);
        if(packets_ordered.deadlines(available_packet_queue_ids(edf_index)) >= current_time_instance + slot_length)
            scheduled_packets.packet_id(scheduled_packet_index + 1) = packets_ordered.packet_id(available_packet_queue_ids(edf_index));
            scheduled_packets.corresponding_frameSizeB(scheduled_packet_index + 1) = packets_ordered.corresponding_frameSizeB(available_packet_queue_ids(edf_index));
            scheduled_packets.release_times(scheduled_packet_index + 1) = packets_ordered.release_times(available_packet_queue_ids(edf_index));
            scheduled_packets.corresponding_frames_index(scheduled_packet_index + 1) = packets_ordered.corresponding_frames_index(available_packet_queue_ids(edf_index));
            scheduled_packets.corresponding_frame_number_of_packets_per_frame(scheduled_packet_index + 1) = packets_ordered.corresponding_frame_number_of_packets_per_frame(available_packet_queue_ids(edf_index));
            scheduled_packets.deadlines(scheduled_packet_index + 1) = packets_ordered.deadlines(available_packet_queue_ids(edf_index));
            scheduled_packets.values(scheduled_packet_index + 1) = packets_ordered.values(available_packet_queue_ids(edf_index));
            scheduled_packets.user_id(scheduled_packet_index + 1) = packets_ordered.user_id(available_packet_queue_ids(edf_index));

            current_time_instance = current_time_instance + slot_length;
            scheduled_packets.slotted_times(scheduled_packet_index + 1) = current_time_instance;

            temp_packet_index = temp_packet_index + 1;
            scheduled_packet_index = scheduled_packet_index + 1;
        else
            dropped_packets.packet_id(dropped_packet_index + 1) = packets_ordered.packet_id(available_packet_queue_ids(edf_index));
            dropped_packets.corresponding_frameSizeB(dropped_packet_index + 1) = packets_ordered.corresponding_frameSizeB(available_packet_queue_ids(edf_index));
            dropped_packets.release_times(dropped_packet_index + 1) = packets_ordered.release_times(available_packet_queue_ids(edf_index));
            dropped_packets.corresponding_frames_index(dropped_packet_index + 1) = packets_ordered.corresponding_frames_index(available_packet_queue_ids(edf_index));
            dropped_packets.corresponding_frame_number_of_packets_per_frame(dropped_packet_index + 1) = packets_ordered.corresponding_frame_number_of_packets_per_frame(available_packet_queue_ids(edf_index));
            dropped_packets.deadlines(dropped_packet_index + 1) = packets_ordered.deadlines(available_packet_queue_ids(edf_index));
            dropped_packets.values(dropped_packet_index + 1) = packets_ordered.values(available_packet_queue_ids(edf_index));
            dropped_packets.user_id(dropped_packet_index + 1) = packets_ordered.user_id(available_packet_queue_ids(edf_index));

            temp_packet_index = temp_packet_index + 1;
            dropped_packet_index = dropped_packet_index + 1;
        end
        available_packet_queue(edf_index) = [];
        available_packet_queue_ids(edf_index) = [];
        available_packet_queue_deadlines(edf_index) = [];
    end
end
total_value = sum(scheduled_packets.values);
end

