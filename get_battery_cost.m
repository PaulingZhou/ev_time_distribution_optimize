function [ battery_cost ] = get_battery_cost( swap_time_dist,charge_start_dist_4hour )
%get_battery_cost 租赁电池的成本
%   swap_time_dist 1440*1 double 每分钟交换下的电池数量
%   charge_start_dist 24*1 double 每小时开始充电的电池数量
%   battery_cost 电池成本
swap_time_dist_4hour = zeros(24,1);
charge_end_dist_4hout = zeros(24,1);
for i = 1 : 4 : 24
    swap_time_dist_4hour(i) = sum(swap_time_dist((i-1)*60+1:(i-1)*60+240));
    charge_end_dist_4hout(mod((i+4),24)) = charge_start_dist_4hour(i);
end
swap_time_dist_4hour = round(swap_time_dist_4hour);
fullBat = zeros(24,1);
unFullBat = zeros(24,1);
% fullBat(1)=950;
% unFullBat(1)=806;
for i = 1 : 24
    full = charge_end_dist_4hout(i)-swap_time_dist_4hour(i);
    unFull = charge_start_dist_4hour(i)+swap_time_dist_4hour(i);
    if i == 1
        fullBat(i) = full;
    else
        fullBat(i) = fullBat(i-1)+full;
    end
    fullBat(i) = fullBat(i) * (fullBat(i)>=0);
    unFullBat(i) = unFull;
end
for i = 1:24
    unFullBat(i) = unFullBat(ceil(i/4)*4-3);
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
battery_cost = 2.19*(fullBat(24)+unFullBat(24));
end

