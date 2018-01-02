function [ battery_cost ] = get_battery_cost( swap_time_dist,charge_time_dist_minute,charge_end_dist,N )
%get_battery_cost ���޵�صĳɱ�
%   swap_time_dist 2880*1 cell ÿ���ӽ����µĵ������
%   charge_time_dist_minute 1440*1 double ÿ�������ڳ��ĵ������
%   charge_end_dist 24*1 double ÿСʱ�����ĵ�������ֲ�
%   battery_cost ��سɱ�
rdNum = zeros(24,1);
fullBatPool = 0;
rdtBatDist = zeros(24,1);
charge_time_dist_hour = zeros(24,1);
swap_time_dist_hour = zeros(24,1);
for i = 1 : 24
    charge_time_dist_hour(i) = max(charge_time_dist_minute(60*(i-1)+1:60*i));
    swap_time_dist_hour(i) = sum(swap_time_dist((i-1)*60+1:i*60));
end
for i = 1 : 24
    fullBatPool = fullBatPool + charge_end_dist(i) - swap_time_dist_hour(i);
    if i>1
        rdNum(i) = rdNum(i-1);
    end
    if(fullBatPool < 0)
       rdNum(i) = rdNum(i) - fullBatPool;
%          fprintf('%dʱ�����Ҫ%d��������\n',i, -fullBatPool);
       fullBatPool = 0;
    end
    rdtBatDist(i) = rdNum(i) + charge_time_dist_hour(i);
end
plot(max(rdtBatDist)-rdtBatDist,'g');
figure(2);
plot(charge_end_dist);
hold on;
plot(swap_time_dist_hour);
battery_cost = 0.55*(max(rdtBatDist)+N);
end

