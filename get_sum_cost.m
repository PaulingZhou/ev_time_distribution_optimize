function [ sum_price ] = get_sum_cost( swap_dist )
%GETSUMPRICE 获取换电站总费用，包括充电电费和电池租赁成本和补贴成本
%   swap_dist 1小时内，更换电池的数量和
sum_price = 0;
chargeStartPlan = updateChargeStartPlan(swap_dist);                              %use updated swNum to update chargeStartPlan
for i = 1:24
    startChargingBattery = chargeStartPlan{i};
    for demand = startChargingBattery
        sum_price = sum_price + calc_charging_price(demand, i);
    end
end
end

