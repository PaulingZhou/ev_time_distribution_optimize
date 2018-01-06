function [ total_cost ] = get_total_cost(demand_time_dist,swap_time_dist,subsidy_minute)
%get_total_cost 代价函数，输入subsidy矩阵，输出total_cost总成本
%   总成本为充电成本，运营设备成本与补贴成本之和
%   demand_time_dist ceil 需求分时分布，
%   swap_time_dist double vector 换电数量分时分布
%   charge_cost_amount 电量电价成本
%   charge_cost_base 基本电价成本
%   charge_cost_equip 充电设备成本
%   operate_cost 电池及换电设备成本
load('go_off_simulate.mat');
% [ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_new_charge_dist(demand_time_dist,swap_time_dist);
[ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_charge_dist(demand_time_dist);
charge_start_dist = zeros(24,1);
for i = 1:6
    charge_start_dist(mod(i*4-5,24)) = charge_start_dist_4hour(i);
end
operate_cost = get_operate_cost(swap_time_dist,charge_start_dist);
subsidy_cost = subsidy_minute' * swap_time_dist(1:24*60);
total_cost = charge_cost_amount + charge_cost_base + charge_cost_equip + operate_cost + subsidy_cost;
end

