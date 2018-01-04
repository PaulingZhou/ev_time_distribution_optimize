function [ charge_start_dist ] = get_new_charge_dist( ePrice,demand_time_dist,swap_time_dist )
%GET_NEW_CHARGE_DIST 使用线性规划获得充电策略
%   考虑的因素包括充电成本和充电设备成本
%   ePrice vector 24*1
%   demand_time_dist cell 1440*1
%   swap_time_dist double 1440*1
load('e_price.mat')
e_price_4hour = zeros(6,1);
for i = 1:24
time = ceil((mod(i+1,24)+1)/4);
e_price_4hour(time) = e_price_4hour(time)+ePrice(i);
end
charge_demand_all = 0;
for i = 1:1440
    charge_demand_all = charge_demand_all + sum(demand_time_dist{i});
end
charge_demand_each_battery = charge_demand_all/sum(swap_time_dist);
f = e_price_4hour'*charge_demand_each_battery/20 + (40.5*5+5.4)/2/30*[1,1,0,0,0,0];
intcon = 1:6;
A = [-1 -1 2 0 0 0; -1 -1 0 2 0 0; -1 -1 0 0 2 0; -1 -1 0 0 0 2];b = zeros(4,1);
Aeq = ones(1,6); beq = sum(swap_time_dist);
lb = zeros(6,1); rb = [];
charge_start_dist = intlinprog(f, intcon, A, b, Aeq, beq, lb, rb);
end

