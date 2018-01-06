function [ swap_info_day1,swap_info_day2 ] = get_battery_swap_distribution( go_off_simulate_Day1,go_off_simulate_Day2,subsidy )
%   getSwapDemandDistribution 计算换电需求密度,Monte-Carlo method
%   go_off_simulate_Day1 第一天车辆出行开始时间与持续时间
%   go_off_simulate_Day2 第二天车辆出行开始时间与持续时间
%   N EV数量
%   soc_store 每辆车的储备阈值 ~U[0.35,0.55]
%   soc_origin 每辆车的起始SOC ~U[soc_store,1]
%   subsidy vector[24*60,1] 补贴矩阵 
%   swap_distribution_possibility vector[24*60,1] 换电可能性矩阵，某个时间段补贴越多换电的可能性越大
%                                                 1+0.2*subsidy 后需调整
N = length(go_off_simulate_Day1);
soc_store = unifrnd (0.35,0.55,N,1);
soc_origin = unifrnd(soc_store,1);
swap_distribution_possibility = 1+0.2*subsidy;
[soc_origin_day2, swap_info_day1] = simulate_go_off(N, go_off_simulate_Day1, soc_store, soc_origin, swap_distribution_possibility);
[~, swap_info_day2] = simulate_go_off(N, go_off_simulate_Day2, soc_store, soc_origin_day2, swap_distribution_possibility);
% for i = 1:N
%     swap_info_day1_percar = swap_info_day1{i};
%     for j = 1:size(swap_info_day1_percar,1)
%         swap_info_day1_percar_pertime = swap_info_day1_percar(j,:);
%         if(swap_info_day1_percar_pertime(1) > 24*60)
%             swap_info_day2{i} = [[swap_info_day1_percar_pertime(1)-24*60,swap_info_day1_percar_pertime(2)];swap_info_day2{i}];
%         end
%     end
% end
end
