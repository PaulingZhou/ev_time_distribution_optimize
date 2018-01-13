function [ charge_start_dist_store_battery,charge_cost_amount,charge_cost_base,charge_cost_equip,battery_cost ] = get_new_charge_dist( demand_time_dist,swap_time_dist )
%GET_NEW_CHARGE_DIST 使用线性规划获得充电策略
%   考虑的因素包括充电成本和充电设备成本
%   ePrice vector 24*1
%   demand_time_dist cell 1440*1
%   swap_time_dist double 1440*1
%   6个充电时刻分别为22:00-2:00,2:00-6:00,6:00-10:00,10:00-14:00,14:00-18:00,18:00-22:00
load('e_price.mat')
e_price_4hour = zeros(6,1);
for i = 1:6
    e_price_4hour(i) = mean(ePrice((i-1)*4+1:(i-1)*4+4));
end
charge_demand_all = sum(demand_time_dist);
charge_demand_each_battery = charge_demand_all/sum(swap_time_dist);
fca = e_price_4hour'*charge_demand_each_battery;  %amount
fca = [fca,zeros(1,3)];
fcb = 6.75*[0,0,0,0,0,1,0,0,0];   %base
fce = 0.72*[0,0,0,0,0,1,0,0,0];   %charge_equip
fcbat = 2.19*[0,0,0,0,0,0,1,1,1];   %battery
f = fca + fcb + fce+fcbat;
intcon = 1:9;
charge_end = [[zeros(1,5);tril(ones(5,5),0)],ones(6,1),zeros(6,3)];
A1 = [eye(5),-ones(5,1),zeros(5,3)];b1 = zeros(5,1);  %最低的两个时间段之和大于其他时间段的两倍
A2 = -[zeros(6,6),ones(6,1),zeros(6,2)]-charge_end; %满电电池约束矩阵
b2 = zeros(6,1); 
for i = 1:6
    b2(i) = -sum(swap_time_dist(1:240*i));
end
A3 = -[tril(ones(6,6),0),zeros(6,1),ones(6,1),zeros(6,1)]+charge_end; b3 = zeros(6,1);
A4 = [tril(ones(6,6),0),zeros(6,1),zeros(6,1),-ones(6,1)];b4=-b2;
A = [A1;A2;A3;A4]; b = [b1;b2;b3;b4];
Aeq = [ones(1,6),zeros(1,3)]; beq = sum(swap_time_dist);
lb = zeros(9,1); rb = [];
charge_start_dist_store_battery = intlinprog(f, intcon, A, b, Aeq, beq, lb, rb);
charge_start_dist = charge_start_dist_store_battery(1:6);
charge_end_dist = [[zeros(1,5);eye(5)],[1;zeros(5,1)]]*charge_start_dist;
bf = zeros(6,1);bc = zeros(6,1);bn = zeros(6,1);
for i = 1:6
    swap_dist_hour = sum(swap_time_dist((i-1)*240+1:(i-1)*240+240));
    newFull = charge_end_dist(i)-swap_dist_hour;
    newCharge = charge_start_dist(i)-charge_end_dist(i);
    newNotCharge = swap_dist_hour-charge_start_dist(i);
    if i == 1
        lastFull = charge_start_dist_store_battery(7);
        lastCharge = charge_start_dist_store_battery(8);
        lastNotCharge = charge_start_dist_store_battery(9);
    else
        lastFull = bf(i-1);
        lastCharge = bc(i-1);
        lastNotCharge = bn(i-1);
    end
    bf(i) = lastFull+newFull;
    bc(i) = lastCharge+newCharge;
    bn(i) = lastNotCharge+newNotCharge;
end
bf = round(bf);bc = round(bc);bn = round(bn);
charge_cost_amount = fca*charge_start_dist_store_battery;
charge_cost_base = fcb*charge_start_dist_store_battery;
charge_cost_equip = fce*charge_start_dist_store_battery;
battery_cost = fcbat*charge_start_dist_store_battery;
end

