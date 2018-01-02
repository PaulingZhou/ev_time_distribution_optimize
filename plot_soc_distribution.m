function [] = plot_soc_distribution(swap_info_day, times, duration)
% plot_soc_distribution ��vector time�ڽ��л���ĵ��soc�ֲ�
% swap_info_day cell ������Ϣ
% time vector ʱ������
% duration int ʱ�䳤�ȣ���λ����
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
