% figure();
max_swap_equip = sum(swap_time_dist(1:10));
current_swap_equip = zeros(24*60,1);
current_swap_equip(10) = max_swap_equip;
for i = 11:1440
    current_swap_equip(i) = current_swap_equip(i-1)-swap_time_dist(i-10)+swap_time_dist(i);
end
plot(current_swap_equip(10:1440),'r')
grid on;
hold on;