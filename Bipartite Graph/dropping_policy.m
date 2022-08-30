function [scheduled_order] = dropping_policy(scheduled_order)
time_slots = 0.000125;
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];
for i = 1:length(scheduled_order)
   if scheduled_order(i,5) < scheduled_order(i,6)
       d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+1:end,4), scheduled_order(i+1:end,5), (((i:length(scheduled_order(i+1:end,1)) + (i-1)))*time_slots)'];
       scheduled_order = [scheduled_order(1:i-1,:) ; d];
   end 
end 
scheduled_order  = [scheduled_order; zeros(size(scheduled_order)/2)];
for i = 1:length(scheduled_order)

   if scheduled_order(i,6) < scheduled_order(i,1)
       b = [0, 0, 0, 0, 0, i*time_slots];
       c = [scheduled_order(i,1), scheduled_order(i,2), scheduled_order(i,3),scheduled_order(i,4), scheduled_order(i,5), (i+1)*time_slots];
       d = [scheduled_order(i+1:end,1), scheduled_order(i+1:end,2), scheduled_order(i+1:end,3), scheduled_order(i+1:end,4), scheduled_order(i+1:end,5), (((i+2:length(scheduled_order(i+1:end,1)) + (i+1)))*time_slots)'];
       scheduled_order = [scheduled_order(1:i-1,:) ;b; c; d];
   end
end
%scheduled_order  = [scheduled_order; zeros(size(scheduled_order))];