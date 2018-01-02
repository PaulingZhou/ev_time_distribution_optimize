load('go_off_simulate.mat');
subsidy = zeros(24*60,1);
if size(subsidy,1)==1
    subsidy = subsidy';
end
subsidy = abs(subsidy);
ratio = 60*24/size(subsidy,1);
subsidy_minute = get_subsidy_minute(subsidy,ratio);
[swap_info_day1, swap_info_day2] = get_battery_swap_distribution(go_off_simulate_Day1,go_off_simulate_Day2, subsidy_minute);
demand_time_dist = get_demand_time_dist(swap_info_day1, swap_info_day2,ratio);
swap_time_dist = get_swap_dist(demand_time_dist,ratio);
[charge_start_dist, charge_time_dist, charge_end_dist] = get_charge_dist(demand_time_dist);
total_cost = get_total_cost(swap_time_dist, charge_time_dist, charge_end_dist, subsidy_minute);
total_income = get_total_income(swap_info_day2);