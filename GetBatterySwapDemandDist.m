battery_swap_demand_distribution = zeros(26,1);
max_soc = zeros(26,1);
min_soc = ones(26,1);
for i = 1:length(swap_info)
    swap_details = swap_info{i};
    for j = 1 : size(swap_details, 1)
        swap_time = swap_details(j,1);
        remain_soc = swap_details(j,2);
        ceil(swap_time/60)
        max_soc(ceil(swap_time/60)) = max(max_soc(ceil(swap_time/60)),remain_soc);
        min_soc(ceil(swap_time/60)) = min(min_soc(ceil(swap_time/60)),remain_soc);
        battery_swap_demand_distribution(ceil(swap_time/60)) = battery_swap_demand_distribution(ceil(swap_time/60))+1;
    end
%         swap_time = 
%         battery_swap_demand_distribution(ceil(swap_detail/60),1) = battery_swap_demand_distribution(ceil(swap_detail/60),1)+1;
end
plot(battery_swap_demand_distribution);
hold on;
% % plot(go_off);
grid on;
