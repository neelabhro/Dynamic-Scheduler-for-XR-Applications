function [bipartite_graph_matrix] = compute_bipartite_graph(users,selected_users,n,slot_length)
bipartite_graph_dimension = 0;
latest_frame = 0;
for user_id = 1:n   
    bipartite_graph_dimension = bipartite_graph_dimension + sum(users{selected_users(user_id)}.number_of_packets_per_frame);
    latest_frame = max(latest_frame,users{selected_users(user_id)}.frame_release_times(end));
end

bipartite_graph_matrix = zeros(bipartite_graph_dimension, ceil(latest_frame/slot_length));

matrix_pointer = 1;
for user_id = 1:n
    for frame = 1:users{selected_users(user_id)}.nf - 1
        bipartite_graph_matrix(matrix_pointer:users{selected_users(user_id)}.number_of_packets_per_frame(frame),ceil(users{selected_users(user_id)}.frame_release_times(frame)./slot_length):floor(users{selected_users(user_id)}.frame_release_times(frame+1)./slot_length)-1) = users{selected_users(user_id)}.avgframeSizekB;
        matrix_pointer = users{selected_users(user_id)}.number_of_packets_per_frame(frame) + 1;
        [a, b] = size(bipartite_graph_matrix);
        assert(bipartite_graph_dimension == a)
        assert(ceil(latest_frame/slot_length) == b)
    end
end
end