function [ total_cost ] = get_total_cost(demand_time_dist_sum,swap_time_dist,subsidy_minute)
%get_total_cost ���ۺ���������subsidy�������total_cost�ܳɱ�
%   �ܳɱ�Ϊ���ɱ�����Ӫ�豸�ɱ��벹���ɱ�֮��
%   demand_time_dist cell �����ʱ�ֲ���
%   swap_time_dist double vector ����������ʱ�ֲ�
%   charge_cost_amount ������۳ɱ�
%   charge_cost_base ������۳ɱ�
%   charge_cost_equip ����豸�ɱ�
%   operate_cost ��ؼ������豸�ɱ�
load('go_off_simulate.mat');
[ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip,battery_cost ] = get_new_charge_dist(demand_time_dist_sum,swap_time_dist);
% [ charge_start_dist_4hour,charge_cost_amount,charge_cost_base,charge_cost_equip ] = get_charge_dist(demand_time_dist_sum,swap_time_dist);
charge_start_dist = zeros(24,1);
for i = 1:6
    charge_start_dist(mod(i*4-3,24)) = charge_start_dist_4hour(i);
end
% charge_start_dist = round(charge_start_dist);
operate_cost = get_operate_cost(swap_time_dist);
% demand_time_dist_sum = zeros(24*60,1);
% for i = 1:24*60
%     if size(demand_time_dist{i},1)
%         demand_time_dist_sum(i) = mean(demand_time_dist{i})* swap_time_dist(i);
%     end
% end
subsidy_cost = subsidy_minute' * demand_time_dist_sum;
% subsidy_cost = 0;
% battery_cost = get_battery_cost(swap_time_dist,charge_start_dist);
total_cost = charge_cost_amount + charge_cost_base + battery_cost + charge_cost_equip + operate_cost + subsidy_cost;
% total_cost = operate_cost + subsidy_cost; %ֻ�л����豸�ɱ��Ͳ����ɱ���DSM���

end

