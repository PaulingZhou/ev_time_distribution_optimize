function [ swap_time_dist ] = get_swap_dist( demand_time_dist,ratio )
%GET_SWAP_DIST �˴���ʾ�йش˺�����ժҪ
swap_time_dist = zeros(24*60*2/ratio,1);
for i = 1:size(swap_time_dist,1)
    swap_time_dist(i) = length(demand_time_dist{i});
end

end

