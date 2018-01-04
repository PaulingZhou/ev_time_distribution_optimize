function [ total_cost ] = get_total_cost(swap_time_dist,charge_time_dist,charge_end_dist,subsidy_minute)
%get_total_cost ���ۺ���������subsidy�������total_cost�ܳɱ�
%   �ܳɱ�Ϊ���ɱ�����Ӫ�豸�ɱ��벹���ɱ�֮��
%   demand_time_dist ceil �����ʱ�ֲ���
%   swap_time_dist double vector ����������ʱ�ֲ�
load('go_off_simulate.mat');
charge_cost = 0;
charge_cost = get_charge_cost(charge_time_dist);
operate_cost = get_operate_cost(swap_time_dist,charge_time_dist,charge_end_dist,N);
subsidy_cost = subsidy_minute' * swap_time_dist(24*60+1:24*60*2);
total_cost = charge_cost + operate_cost + subsidy_cost;
end

