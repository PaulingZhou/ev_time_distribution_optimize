function [ chargeStartPlan ] = get_charge_start_plan( swNum )
%updateChargeStartPlan ͨ��������طֲ����³�翪ʼʱ��
%   ��翪ʼ�ڻ��µ�ص���һʱ��
chargeStartPlan = cell(48,1);
for i = 1:47
    j = i+1;
    chargeStartPlan{j} = swNum{i};
end
end