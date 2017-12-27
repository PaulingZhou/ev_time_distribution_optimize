load('go_off_simulate.mat');
subsidy = zeros(24*60,1);
swap_info = getSwapDemandDistribution(go_off_simulate_Day1,go_off_simulate_Day2, subsidy);
ratio = 60;
demand_time_dist = cell(2880/ratio,1);
N = length(swap_info_day1);
for i = 1:N
    swap_info_per_car = swap_info_day1{i};
    for j = 1:size(swap_info_per_car,1)
        time = ceil(swap_info_per_car(j,1)/ratio);
        demand = (1-swap_info_per_car(j,2))*19.2;   % 100% Soc = 19.2kW
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
plot(swap_time_dist,'b');
axis tight;
grid on;
hold on;

[charge_start_dist, charge_time_dist, charge_end_dist] = get_charge_dist(demand_time_dist);
plot(charge_start_dist,'g');

plot(charge_end_dist,'r');
charge_cost = get_charge_cost(charge_time_dist);
battery_cost = get_battery_cost(swap_time_dist,charge_time_dist,charge_end_dist,N);
subsidy_cost = sum(subsidy);