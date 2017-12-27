function [ chargeStartPlan ] = get_charge_start_plan( swNum )
%updateChargeStartPlan 通过更换电池分布更新充电开始时间
%   充电开始于换下电池的下一时刻
chargeStartPlan = cell(48,1);
for i = 1:47
    j = i+1;
    chargeStartPlan{j} = swNum{i};
end
end