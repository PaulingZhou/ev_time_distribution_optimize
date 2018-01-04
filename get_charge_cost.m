function [ charge_cost ] = get_charge_cost( charge_time_dist )
%get_charge_cost ������ɱ�������������ۺ͵������
%   charge_time_dist 1440*1 vector һ����ÿ���ӳ�������ķֲ�
%   charge_cost ����ܳɱ�
load('e_price.mat');
amount_cost = 0;
for i = 1:1440
    time_hour = ceil(i/60);
    amount_cost = amount_cost+ePrice(time_hour)*charge_time_dist(i)/60;
end
basis_cost = (40.5+27)*max(charge_time_dist)/30;
charge_cost = amount_cost+basis_cost;
end

