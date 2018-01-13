function [ operate_cost ] = get_operate_cost(swap_time_dist )
%get_operate_cost 运营成本
%   (换电机械+换电位)
max_swap_equip = sum(swap_time_dist(1:10));
current_swap_equip = max_swap_equip;
for i = 2:1431
    current_swap_equip = current_swap_equip-swap_time_dist(i)+swap_time_dist(i+9);
    max_swap_equip = max(max_swap_equip,current_swap_equip);
end
swap_equip_cost = (200.97)*max_swap_equip;
operate_cost = swap_equip_cost;
end

