function [ operate_cost ] = get_operate_cost(swap_time_dist,charge_start_dist )
%get_operate_cost ��Ӫ�ɱ�
%   ���+(�����е+����λ)
battery_cost = get_battery_cost(swap_time_dist,charge_start_dist);
swap_equip_cost = (0.09+0.15)*max(charge_start_dist)*10;
operate_cost = battery_cost + swap_equip_cost;
end

