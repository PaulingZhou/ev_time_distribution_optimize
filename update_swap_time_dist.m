function [ swap_time_dist_update ] = update_swap_time_dist( swap_time_dist_origin,swap_distribution_possibility )
%UPDATE_SWAP_TIME_DIST 通过新的分布概率向量获得新的换电需求向量
swap_time_dist_update = swap_time_dist_origin.*swap_distribution_possibility;
sum_swap_origin = sum(swap_time_dist_origin);
sum_swap_update = sum(swap_time_dist_update);
swap_time_dist_update = round(swap_time_dist_update/sum_swap_update*sum_swap_origin);
end

