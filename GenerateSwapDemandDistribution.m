load('go_off_simulate.mat');
fprintf('new calculate instance\n');
subsidy = zeros(24*60,1);
if size(subsidy,1)==1
    subsidy = subsidy';
end
subsidy = abs(subsidy);
ratio = 60*24/size(subsidy,1);
subsidy_minute = get_subsidy_minute(subsidy,ratio);
e_price_origin = 1.8*ones(24*60,1);
e_price_update = e_price_origin - subsidy_minute;
price_ratio = e_price_update/e_price_origin;
swap_distribution_possibility = -0.9720*price_ratio.^3+2.7968*price_ratio.^2-2.5179*price_ratio+1.7010;
swap_distribution_possibility = swap_distribution_possibility.*(swap_distribution_possibility>0)+eps;
[swap_info_day1, swap_info_day2] = get_battery_swap_distribution(go_off_simulate_Day1,go_off_simulate_Day2, swap_distribution_possibility);
demand_time_dist = get_demand_time_dist(swap_info_day1, swap_info_day2,ratio);
swap_time_dist = get_swap_dist(demand_time_dist,ratio);
% [charge_start_dist, charge_time_dist, charge_end_dist] = get_charge_dist(demand_time_dist);
total_cost = get_total_cost(demand_time_dist(1441:2880),swap_time_dist(1441:2880),subsidy_minute);
total_income = get_total_income(demand_time_dist);