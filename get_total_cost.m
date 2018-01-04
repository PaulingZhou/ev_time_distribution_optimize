function [ total_cost ] = get_total_cost(swap_time_dist,charge_time_dist,charge_end_dist,subsidy_minute)
%get_total_cost 代价函数，输入subsidy矩阵，输出total_cost总成本
%   总成本为充电成本，运营设备成本与补贴成本之和
%   demand_time_dist ceil 需求分时分布，
%   swap_time_dist double vector 换电数量分时分布
load('go_off_simulate.mat');
charge_cost = 0;
charge_cost = get_charge_cost(charge_time_dist);
operate_cost = get_operate_cost(swap_time_dist,charge_time_dist,charge_end_dist,N);
subsidy_cost = subsidy_minute' * swap_time_dist(24*60+1:24*60*2);
total_cost = charge_cost + operate_cost + subsidy_cost;
end

