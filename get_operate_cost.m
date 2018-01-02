function [ operate_cost ] = get_operate_cost( swap_time_dist,charge_time_dist,charge_end_dist,N )
%get_operate_cost 运营成本
%   电池+电池充电机+换电机械+换电位
battery_cost = get_battery_cost(swap_time_dist(24*60+1:48*60),charge_time_dist,charge_end_dist,N);
charge_equip_cost = 0.18*max(charge_time_dist);
swap_equip_cost = (0.09+0.15)*max(swap_time_dist)*10;
operate_cost = battery_cost + charge_equip_cost + swap_equip_cost;
end

