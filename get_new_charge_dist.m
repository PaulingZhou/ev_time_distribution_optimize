function [ charge_start_dist,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_new_charge_dist( demand_time_dist,swap_time_dist )
%GET_NEW_CHARGE_DIST ʹ�����Թ滮��ó�����
%   ���ǵ����ذ������ɱ��ͳ���豸�ɱ�
%   ePrice vector 24*1
%   demand_time_dist cell 1440*1
%   swap_time_dist double 1440*1
load('e_price.mat')
e_price_4hour = zeros(6,1);
for i = 1:24
time = ceil((mod(i+1,24)+1)/4);
e_price_4hour(time) = e_price_4hour(time)+ePrice(i);
end
e_price_4hour = e_price_4hour/4;
charge_demand_all = 0;
for i = 1:1440
    charge_demand_all = charge_demand_all + sum(demand_time_dist{i});
end
charge_demand_each_battery = charge_demand_all/sum(swap_time_dist);
fca = e_price_4hour'*charge_demand_each_battery;  %amount
fcb = 6.75*[1,1,0,0,0,0];   %base
fce = 2.37*[1,1,0,0,0,0];   %equip
f = fca + fcb + fce;
intcon = 1:6;
A = [-1 -1 2 0 0 0; -1 -1 0 2 0 0; -1 -1 0 0 2 0; -1 -1 0 0 0 2];b = zeros(1,4);
Aeq = ones(1,6); beq = sum(swap_time_dist);
lb = zeros(6,1); rb = [];
charge_start_dist = intlinprog(f, intcon, A, b, Aeq, beq, lb, rb);
charge_start_dist(1) = ceil(charge_start_dist(2)/2);
charge_start_dist(2) = charge_start_dist(2)-charge_start_dist(1);
charge_cost_amount = fca*charge_start_dist;
charge_cost_base = fcb*charge_start_dist;
charge_cost_equip = fce*charge_start_dist;
end

