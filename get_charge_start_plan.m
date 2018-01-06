function [ charge_start_plan_battery, charge_start_plan_power ] = get_charge_start_plan( demand_time_dist_min )
%updateChargeStartPlan 通过更换电池分布更新充电开始时间
%   充电开始于换下电池的下一时刻
charge_start_plan = cell(24,1);
demand_time_dist_hour = cell(24,1);
for i = 1:24
    demand_time_dist_hour{i} = [demand_time_dist_min{(i-1)*60+1:i*60}];
end
for i = 3:4:23
    charge_start_plan{i} = [demand_time_dist_hour{mod((i-5:i-2),24)+1}];
end
charge_start_plan_battery = zeros(6,1);
charge_start_plan_power = zeros(6,1);
for i = 1:6
    time = mod(i*4-5,24);
    charge_start_plan_battery(i) = size(charge_start_plan{time},2);
    charge_start_plan_power(i) = sum(charge_start_plan{time});
end
end