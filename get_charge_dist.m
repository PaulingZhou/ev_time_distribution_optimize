function [ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_charge_dist( demand_time_dist,swap_time_dist )
%get_charge_dist
%��ȡ�ڶ�����ֲ�,���Ż��������Դ�ǰһ��22��00��ʼ��ʱ����Ϊ4Сʱ��ÿ��ʱ�����ڵĵ������һ�����ڻ�ͳһ���뼯�г��վ���
%   demand_time_dist 24*1 cell ����ֲ�
%   P ��繦��5kW
%   6�����ʱ�̷ֱ�Ϊ22:00-2:00,2:00-6:00,6:00-10:00,10:00-14:00,14:00-18:00,18:00-22:00

[ charge_start_plan_battery, charge_start_plan_power ] = get_charge_start_plan(demand_time_dist,swap_time_dist);

load('e_price.mat')
e_price_4hour = zeros(6,1);
for i = 1:24
time = ceil((mod(i+1,24)+1)/4);
e_price_4hour(time) = e_price_4hour(time)+ePrice(i);
end
e_price_4hour = e_price_4hour/4;

fca = e_price_4hour';  %amount
fcb = 6.75;   %base 40.5/30*5
fce = 0.72;   %charge_equip

charge_cost_amount = fca*charge_start_plan_power;
max_battery = max(charge_start_plan_battery);
charge_cost_base = fcb*max_battery;
charge_cost_equip = fce*max_battery;
charge_start_dist_4hour = charge_start_plan_battery;
end

