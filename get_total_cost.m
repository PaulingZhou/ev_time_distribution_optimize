function [ total_cost ] = get_total_cost(subsidy)
%get_total_cost 代价函数，调整subsidy获得最优的total cost
%   此处显示详细说明
load('go_off_simulate.mat');
subsidy_minute = zeros(24*60,1);
if size(subsidy,1)==1
    subsidy = subsidy';
end
ratio = 60*24/size(subsidy,1);
subsidy = abs(subsidy);
for i = 1:size(subsidy,1)
    subsidy_minute(ratio*(i-1)+1:ratio*i) = subsidy(i);
end
P=40;
[swap_info_day1, swap_info_day2] = get_battery_swap_distribution(go_off_simulate_Day1,go_off_simulate_Day2, subsidy_minute);
% ratio = 60;
demand_time_dist = cell(2880/ratio,1);
N = length(swap_info_day1);
for i = 1:N
    swap_info_per_car = swap_info_day1{i};
    for j = 1:size(swap_info_per_car,1)
        time = ceil(swap_info_per_car(j,1)/ratio);
        demand = (1-swap_info_per_car(j,2))*P;   % 100% Soc = 19.2kW
        demand_time_dist{time} = [demand_time_dist{time}, demand];
    end
    swap_info_per_car = swap_info_day2{i};
    for j = 1:size(swap_info_per_car,1)
        time = ceil(swap_info_per_car(j,1)/ratio);
        demand = (1-swap_info_per_car(j,2))*19.2;   % 100% Soc = 19.2kW
        if(time <= 24*60/ratio)
            time = time + 24*60/ratio;
            demand_time_dist{time} = [demand_time_dist{time}, demand];
        end
    end
end
swap_time_dist = zeros(24*60*2/ratio,1);
for i = 1:size(swap_time_dist,1)
    swap_time_dist(i) = length(demand_time_dist{i});
end
% plot(swap_time_dist,'b');
% axis tight;
% grid on;
% hold on;

[charge_start_dist, charge_time_dist, charge_end_dist] = get_charge_dist(demand_time_dist);
% plot(charge_start_dist,'g');
% 
% plot(charge_end_dist,'r');
charge_cost = get_charge_cost(charge_time_dist);
battery_cost = get_battery_cost(swap_time_dist,charge_time_dist,charge_end_dist,N);
subsidy_cost = subsidy' * swap_time_dist(24*60/ratio+1:24*60*2/ratio);
total_cost = charge_cost + battery_cost + subsidy_cost;
end

