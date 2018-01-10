function [ charge_start_dist,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_new_charge_dist( demand_time_dist,swap_time_dist )
%GET_NEW_CHARGE_DIST ʹ�����Թ滮��ó�����
%   ���ǵ����ذ������ɱ��ͳ���豸�ɱ�
%   ePrice vector 24*1
%   demand_time_dist cell 1440*1
%   swap_time_dist double 1440*1
%   6�����ʱ�̷ֱ�Ϊ22:00-2:00,2:00-6:00,6:00-10:00,10:00-14:00,14:00-18:00,18:00-22:00
load('e_price.mat')
e_price_4hour = zeros(6,1);
for i = 1:6
    e_price_4hour(i) = mean(ePrice((i-1)*4+1:(i-1)*4+4));
end
charge_demand_all = sum(demand_time_dist);
charge_demand_each_battery = charge_demand_all/sum(swap_time_dist);
fca = e_price_4hour'*charge_demand_each_battery;  %amount
fcb = 6.75*[1,0,0,0,0,1]/2;   %base
fce = 0.72*[1,0,0,0,0,1]/2;   %charge_equip
f = fca + fcb + fce;
intcon = 1:6;
A = [-1 2 0 0 0 -1; -1 0 2 0 0 -1; -1 0 0 2 0 -1; -1 -1 0 0 2 -1];b = zeros(1,4);
Aeq = ones(1,6); beq = sum(swap_time_dist);
lb = zeros(6,1); rb = [];
charge_start_dist = intlinprog(f, intcon, A, b, Aeq, beq, lb, rb);
sum_battery_1_6 = charge_start_dist(1) + charge_start_dist(6);
charge_start_dist(1) = ceil(sum_battery_1_6/2);
charge_start_dist(6) = sum_battery_1_6-charge_start_dist(1);
charge_cost_amount = fca*charge_start_dist;
charge_cost_base = fcb*charge_start_dist;
charge_cost_equip = fce*charge_start_dist;
end

