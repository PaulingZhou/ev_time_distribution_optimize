function [ operate_cost ] = get_operate_cost(swap_time_dist )
%get_operate_cost 运营成本
%   (换电机械+换电位)
swap_equip_cost = (0.09+0.15)*max(swap_time_dist)*10;
operate_cost = swap_equip_cost;
end

