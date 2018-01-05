ratio = 60;
swap_time_dist_ratio = zeros(1440/ratio,1);
for i = 1:size(swap_time_dist_ratio,1)
    swap_time_dist_ratio(i) = sum(swap_time_dist(1440+ratio*(i-1)+1:1440+ratio*i));
end
plot(swap_time_dist_ratio)
grid on;