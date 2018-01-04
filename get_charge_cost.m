function [ charge_cost ] = get_charge_cost( charge_time_dist )
%get_charge_cost 计算充电成本，包括基本电价和电量电价
%   charge_time_dist 1440*1 vector 一天内每分钟充电电池数的分布
%   charge_cost 充电总成本
load('e_price.mat');
amount_cost = 0;
for i = 1:1440
    time_hour = ceil(i/60);
    amount_cost = amount_cost+ePrice(time_hour)*charge_time_dist(i)/60;
end
basis_cost = (40.5+27)*max(charge_time_dist)/30;
charge_cost = amount_cost+basis_cost;
end

