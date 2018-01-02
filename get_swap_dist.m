function [ swap_time_dist ] = get_swap_dist( demand_time_dist,ratio )
%GET_SWAP_DIST 此处显示有关此函数的摘要
swap_time_dist = zeros(24*60*2/ratio,1);
for i = 1:size(swap_time_dist,1)
    swap_time_dist(i) = length(demand_time_dist{i});
end

end

