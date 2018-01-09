function [ battery_cost ] = get_battery_cost( swap_time_dist,charge_start_dist )
%get_battery_cost 租赁电池的成本
%   swap_time_dist 1440*1 double 每分钟交换下的电池数量
%   charge_start_dist 24*1 double 每小时开始充电的电池数量
%   battery_cost 电池成本
rdtBatDist = zeros(24,1);
swap_time_dist_hour = zeros(24,1);
charge_end_dist = zeros(24,1);
for i = 1 : 24
    swap_time_dist_hour(i) = sum(swap_time_dist((i-1)*60+1:i*60));
    charge_end_dist(1+mod((i+3),24)) = charge_start_dist(i);
end
swap_time_dist_hour = [swap_time_dist_hour;swap_time_dist_hour];
charge_start_dist = [charge_start_dist;charge_start_dist];
charge_end_dist = [charge_end_dist;charge_end_dist];
fullBat = zeros(48,1);
unFullBat = zeros(48,1);
for i = 3 : 26
    fullBat(i) = fullBat(i-1)+charge_end_dist(i)-swap_time_dist_hour(i-1);
    if fullBat(i)<0
        fullBat(i) = 0;
    end
    unFullBat(i) = unFullBat(i-1)-charge_end_dist(i)+swap_time_dist_hour(i-1);
    if unFullBat(i)<0
        unFullBat(i) = 0;
    end
end
% plot(max(rdtBatDist)-rdtBatDist,'g');
% figure(2);
% plot(charge_end_dist);
% hold on;
% plot(swap_time_dist_hour);
% plot(unFullBat(3:26));
% hold on;
% plot(fullBat(3:26),'g');
% legend('未充满电池','已充满电池');
% grid on;
% hold off;
battery_cost = 0.55*(fullBat(26)+unFullBat(26));
end

