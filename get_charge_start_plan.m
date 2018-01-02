function [ chargeStartPlan ] = get_charge_start_plan( swNum )
%updateChargeStartPlan 通过更换电池分布更新充电开始时间
%   充电开始于换下电池的下一时刻
chargeStartPlan = cell(48,1);
for i = 1:4880
    j = ceil(i/60)+1;
    if j <= 48
        chargeStartPlan{j} = [chargeStartPlan{j} swNum{i}];
    end
end
end