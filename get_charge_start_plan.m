function [ chargeStartPlan ] = get_charge_start_plan( swNum )
%updateChargeStartPlan ͨ��������طֲ����³�翪ʼʱ��
%   ��翪ʼ�ڻ��µ�ص���һʱ��
chargeStartPlan = cell(48,1);
for i = 1:4880
    j = ceil(i/60)+1;
    if j <= 48
        chargeStartPlan{j} = [chargeStartPlan{j} swNum{i}];
    end
end
end