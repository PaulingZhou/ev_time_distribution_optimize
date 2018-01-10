function [ charge_start_plan_battery, charge_start_plan_power ] = get_charge_start_plan( demand_time_dist_min,swap_time_dist_min )
%updateChargeStartPlan ͨ��������طֲ����³�翪ʼʱ��
%   ��翪ʼ�ڻ��µ�ص���һʱ��
%   4СʱΪһ���������1-4��5-8��9-12��13-16��17-21��21-24
charge_period = [(1:240:1440);(240:240:1440)]';
charge_start_plan_battery = zeros(6,1);
charge_start_plan_power = zeros(6,1);
for i = 1:6
    charge_start_plan_battery(i)=sum(swap_time_dist_min(charge_period(i,1):charge_period(i,2)));
    charge_start_plan_power(i)=sum(demand_time_dist_min(charge_period(i,1):charge_period(i,2)));
end
end