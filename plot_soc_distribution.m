function [] = plot_soc_distribution(swap_info_day, times, duration)
% plot_soc_distribution 画vector time内进行换电的电池soc分布
% swap_info_day cell 换电信息
% time vector 时间序列
% duration int 时间长度，单位分钟
swap_info_distribution = cell(24*60/duration,1);
for i = 1:size(swap_info_day)
    swap_info_car = swap_info_day{i};
    for j = 1:size(swap_info_car, 1)
        swap_info_time = swap_info_car(j,:);
        swap_time = ceil(swap_info_time(1)/duration);
        if swap_time <= 24*60/duration
            swap_info_distribution{swap_time} = [swap_info_distribution{swap_time},ceil(swap_info_time(2)*40)];
        end
    end
end
for j = 1:size(swap_info_distribution)
    sort(swap_info_distribution{j});
end
for time = times
    figure(time);
end
end
