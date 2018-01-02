function [ demand_time_dist ] = get_demand_time_dist( swap_info_day1, swap_info_day2,ratio )
%GET_DEMAND_TIME_DIST �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
P = 19.2;
demand_time_dist = cell(2880/ratio,1);
N = length(swap_info_day1);
for i = 1:N
    swap_info_per_car = swap_info_day1{i};
    for j = 1:size(swap_info_per_car,1)
        time = ceil(swap_info_per_car(j,1)/ratio);
        demand = (1-swap_info_per_car(j,2))*P;   % 100% Soc = 19.2kW
        demand_time_dist{time} = [demand_time_dist{time}, demand];
    end
    swap_info_per_car = swap_info_day2{i};
    for j = 1:size(swap_info_per_car,1)
        time = ceil(swap_info_per_car(j,1)/ratio);
        demand = (1-swap_info_per_car(j,2))*19.2;   % 100% Soc = 19.2kW
        if(time <= 24*60/ratio)
            time = time + 24*60/ratio;
            demand_time_dist{time} = [demand_time_dist{time}, demand];
        end
    end
end

end

