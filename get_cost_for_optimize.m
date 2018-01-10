function [ total_cost ] = get_cost_for_optimize( subsidy )
%GET_COST_FOR_OPTIMIZE 用于优化的成本函数

% fprintf('new calculate instance\n');
% load('go_off_simulate.mat');
load('swap_info_6330.mat');
% if size(subsidy,1)==1
%     subsidy = subsidy';
% end
% subsidy = abs(subsidy);
% subsidy_tenmin = zeros(144,1);
% subsidy_tenmin(80:94) = subsidy;
% subsidy_minute = get_subsidy_minute(subsidy_tenmin,10);
subsidy_minute = zeros(1440,1);

swap_distribution_possibility = get_demand_ratio_via_subsidy(subsidy_minute);

% [swap_info_day1, swap_info_day2] = get_battery_swap_distribution(go_off_simulate_Day1,go_off_simulate_Day2, swap_distribution_possibility);
% demand_time_dist = get_demand_time_dist(swap_info_day1, swap_info_day2,1);
% swap_time_dist = get_swap_dist(demand_time_dist,1);
[demand_time_dist_sum,swap_time_dist_update] = update_swap_time_dist(swap_period,swap_distribution_possibility);
total_cost = get_total_cost(demand_time_dist_sum,swap_time_dist_update,subsidy_minute)/6550;
end

