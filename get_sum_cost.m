function [ sum_price ] = get_sum_cost( swap_dist )
%GETSUMPRICE ��ȡ����վ�ܷ��ã���������Ѻ͵�����޳ɱ��Ͳ����ɱ�
%   swap_dist 1Сʱ�ڣ�������ص�������
sum_price = 0;
chargeStartPlan = updateChargeStartPlan(swap_dist);                              %use updated swNum to update chargeStartPlan
for i = 1:24
    startChargingBattery = chargeStartPlan{i};
    for demand = startChargingBattery
        sum_price = sum_price + calc_charging_price(demand, i);
    end
end
end

