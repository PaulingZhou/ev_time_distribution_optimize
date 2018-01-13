function [ total_cost ] = get_total_cost(demand_time_dist_sum,swap_time_dist,subsidy_minute)
%get_total_cost 代价函数，输入subsidy矩阵，输出total_cost总成本
%   总成本为充电成本，运营设备成本与补贴成本之和
%   demand_time_dist cell 需求分时分布，
%   swap_time_dist double vector 换电数量分时分布
%   charge_cost_amount 电量电价成本
%   charge_cost_base 基本电价成本
%   charge_cost_equip 充电设备成本
%   operate_cost 电池及换电设备成本
load('go_off_simulate.mat');
[ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip,battery_cost ] = get_new_charge_dist(demand_time_dist_sum,swap_time_dist);
% [ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_charge_dist(demand_time_dist_sum,swap_time_dist);
charge_start_dist = zeros(24,1);
for i = 1:6
    charge_start_dist(mod(i*4-3,24)) = charge_start_dist_4hour(i);
end
% charge_start_dist = round(charge_start_dist);
operate_cost = get_operate_cost(swap_time_dist);
% demand_time_dist_sum = zeros(24*60,1);
% for i = 1:24*60
%     if size(demand_time_dist{i},1)
%         demand_time_dist_sum(i) = mean(demand_time_dist{i})* swap_time_dist(i);
%     end
% end
subsidy_cost = subsidy_minute' * demand_time_dist_sum;
% subsidy_cost = 0;
% battery_cost = get_battery_cost(swap_time_dist,charge_start_dist);
total_cost = charge_cost_amount + charge_cost_base + battery_cost + charge_cost_equip + operate_cost + subsidy_cost;
% total_cost = operate_cost + subsidy_cost; %只有换电设备成本和补贴成本与DSM相关

end

