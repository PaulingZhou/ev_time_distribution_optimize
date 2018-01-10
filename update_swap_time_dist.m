function [ demand_time_dist_update,swap_time_dist_update ] = update_swap_time_dist( swap_periods,swap_distribution_possibility )
%UPDATE_SWAP_TIME_DIST 通过新的分布概率向量获得新的换电需求向量
% swap_time_dist_update = swap_time_dist_origin.*swap_distribution_possibility;
% sum_swap_origin = sum(swap_time_dist_origin);
% sum_swap_update = sum(swap_time_dist_update);
% swap_time_dist_update = round(swap_time_dist_update/sum_swap_update*sum_swap_origin);
swap_time_dist_update = zeros(24*60,1);
demand_time_dist_update = zeros(24*60,1);
for swap_period = swap_periods'
%     time = randsample(swap_period.start_end(1):swap_period.start_end(2), 1, ...
%         'true', swap_distribution_possibility(swap_period.start_end(1):swap_period.start_end(2)).*swap_period.driving_detail);
%     swap_time_dist_update(swap_period.start_end(1):swap_period.start_end(2)) = swap_time_dist_update(time)+1;
%     demand_time_dist_update{time} = [demand_time_dist_update{time};19.2*(1-swap_period.soc_detail(time-swap_period.start_end(1)+1))];

    time = swap_period.start_end(1):swap_period.start_end(2);
    swap_possible = swap_distribution_possibility(time).*swap_period.driving_detail;
    swap_possible = swap_possible/sum(swap_possible);
    swap_time_dist_update(time) = swap_time_dist_update(time)+swap_possible;
    demand_time_dist_update(time) = demand_time_dist_update(time)+19.2*(1-swap_period.soc_detail').*swap_possible;
end
end

