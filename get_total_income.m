function [ income ] = get_total_income( demand_time_dist )
%GET_TOTAL_INCOME 收入情况
income = 0;
for i = 1:length(demand_time_dist)
    demand_info_percar = demand_time_dist{i};
    income = income + sum(demand_info_percar)*1.8;
end
end

