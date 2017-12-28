function [ battery_cost ] = get_battery_cost( swap_time_dist,charge_time_dist_minute,charge_end_dist,N )
%get_battery_cost ���޵�صĳɱ�
%   demand_time_dist 48*1 cell ÿ���ӽ����µĵ������
%   charge_end_dist 2880*1 vectore ÿ���ӳ����ĵ�������ֲ�
%   battery_cost ��سɱ�
rdNum = zeros(24*2,1);
fullBatPool = 0;
rdtBatDist = zeros(24*2,1);
charge_time_dist_hour = zeros(24*2,1);
for i = 25 : 24*2
    charge_time_dist_hour(i) = charge_time_dist_minute((i-1)*60+1);
end
for i = 25 : 24*2
    fullBatPool = fullBatPool + charge_end_dist(i) - swap_time_dist(i);
    rdNum(i) = rdNum(i-1);
    if(fullBatPool < 0)
       rdNum(i) = rdNum(i) - fullBatPool;
%          fprintf('%dʱ�����Ҫ%d��������\n',i, -fullBatPool);
       fullBatPool = 0;
    end
    rdtBatDist(i) = rdNum(i) + charge_time_dist_hour(i);
end
% figure(2);
rdtBatDist(1:24,:)=[];
rdNum(1:24,:)=[];
charge_time_dist_hour(1:24,:)=[];
% plot(max(rdtBatDist)-rdtBatDist,'g');
% hold on;
% grid on;
% plot(rdNum,'b');
% plot(charge_time_dist_hour,'r');
battery_cost = 10*(max(rdtBatDist)+N);
end

