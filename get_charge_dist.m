function [ charge_start_dist, charge_time_dist, charge_end_dist ] = get_charge_dist( demand_time_dist )
%get_charge_dist 获取充电分布
%   demand_time_dist 24*1 cell 需求分布
%   charge_time_dist 1440*1 vector 充电分布
%   P 充电功率5kW
charge_start_soc_dist = get_charge_start_plan(demand_time_dist);
charge_time_dist = zeros(24*60*2,1);
charge_start_dist = zeros(24*2,1);
charge_end_dist = zeros(24*2,1);
P = 5;
for i = 1:48
    demand_for_batteris = charge_start_soc_dist{i};
    for demand = demand_for_batteris
        time = ceil(demand*60/P); %min
        for j = 1:time
            iter_time = mod(((i-1)*60+j-1),2880)+1;
            charge_time_dist(iter_time) = charge_time_dist(iter_time)+1;
            if j == 1
                charge_start_dist(ceil(iter_time/60)) = charge_start_dist(ceil(iter_time/60))+1;
            end
            if j == time
                charge_end_dist(ceil(iter_time/60)) = charge_end_dist(ceil(iter_time/60))+1;
            end
        end
    end
end

end

