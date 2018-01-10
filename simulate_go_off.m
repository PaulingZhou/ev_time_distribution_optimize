function [ new_soc_origin,swap_info,swap_period ] = simulate_go_off( N, go_off_simulate_Day,soc_store,soc_origin,swap_distribution_possibility_all)
%SIMULATE_GO_OFF 使用蒙特卡洛方法模拟得到N辆电动车的实时soc状态和换电时信息（换电时间和剩余SOC）
%   N EV数量
%   go_off_simulate_Day 一天中车辆出行开始时间与持续时间
%   soc_store 每辆车的储备阈值 ~U[0.35,0.55]
%   soc_origin 每辆车的起始SOC ~U[soc_store,1]
%   soc_low 每辆车的低电量阈值 ~U[0.10,0.20]
%   velocity_db 每分钟车速 ~N[21,3^2]km/h
%   soc_realtime vector N*1440, N辆车在一天中的soc变化
%   soc_consume_dist 每辆车在驾驶过程中的耗电分布
%   swapping_times 换电次数
%   swapping_time_sim vector[swapping_times*2] 每辆车每天的换电时间和换电时剩余电量分布
%   swapping_details vector[1*2] 每次换电的时间和剩余电量
%   swap_distribution_possibility vector[24*60,1] 换电可能性矩阵

soc_low = [0.20,0.10];
velocity_db = makedist('Normal', 'mu', 21, 'sigma', 3);
new_soc_origin = ones(N,1);
swap_info = cell(N,1);
swap_distribution_possibility_all = [swap_distribution_possibility_all;swap_distribution_possibility_all];
total_consume_distance = 200;
% start_yuzhi = 14*60+1;
% end_yuzhi = 21*60;
swap_period = [];
for carIndex = 1:N
    soc_realtime_perhour = ones(1,24*60);
    soc_consume_dist = zeros(24*60,1);
    go_off_info_per_car = go_off_simulate_Day{carIndex}';
    swapping_time_sim = [];
    if ~isempty(go_off_info_per_car)
        for go_off_info_per_time = go_off_info_per_car
            for i = 1:go_off_info_per_time(2)
                soc_consume_dist(go_off_info_per_time(1)+i-1) = random(velocity_db)/60/total_consume_distance;
            end
        end
        soc_realtime_perhour(1,1) = soc_origin(carIndex)-soc_consume_dist(1);
        swapping_time_dist = zeros(1,2);
        iter_time = 2;
        swapping_times = 1;
        swapping_details = [0 0];
        while iter_time <= 24*60
            soc_realtime_perhour(1,iter_time) = soc_realtime_perhour(1,iter_time-1) - soc_consume_dist(iter_time);
            if(soc_realtime_perhour(1,iter_time)<=soc_low(1) && soc_realtime_perhour(1,iter_time-1)>soc_low(1))
                swapping_time_dist(1) = iter_time;
            end
            if(soc_realtime_perhour(1,iter_time)<soc_low(2) && soc_realtime_perhour(1,iter_time-1)>=soc_low(2))
                swapping_time_dist(2) = iter_time-1;
                swap_distribution_time = swapping_time_dist(1):swapping_time_dist(2);
                swap_distribution_possibility = swap_distribution_possibility_all(swap_distribution_time)...
                    .*(soc_consume_dist(swap_distribution_time));
                time = randsample(swap_distribution_time, 1, 'true', swap_distribution_possibility);

                
                swapping_details(1) = time;
                swapping_details(2) = soc_realtime_perhour(1,time);
                swapping_time_sim = [swapping_time_sim;swapping_details];
                
                swap_period = [swap_period;struct('start_end',swapping_time_dist,...
                        'driving_detail',(soc_consume_dist(swapping_time_dist(1):swapping_time_dist(2))>0),...
                        'soc_detail',soc_realtime_perhour(swapping_time_dist(1):swapping_time_dist(2)))]; 
                    
                swapping_times = swapping_times+1;
                soc_realtime_perhour(1,time)=1.0;
                iter_time = time;
        
            end
            if iter_time == 24*60
                if soc_realtime_perhour(1,iter_time)<soc_store(carIndex)
                    last_start = max(swapping_details(1),go_off_info_per_car(1,size(go_off_info_per_car,2)));
                    last_stop = go_off_info_per_car(1,size(go_off_info_per_car,2))+go_off_info_per_car(2,size(go_off_info_per_car,2))-1;
                    swap_distribution_time = (last_start:last_stop)';
                    swap_distribution_possibility = swap_distribution_possibility_all(swap_distribution_time);
%                     driving_time = last_stop-last_start;    
                    if last_start == last_stop
                        1;
                    end
                    time = randsample(swap_distribution_time, 1, 'true', swap_distribution_possibility);
                    
                    swapping_details(1) = time;
                    swapping_details(2) = soc_realtime_perhour(1,time);
                    swapping_time_sim = [swapping_time_sim;swapping_details];
                    
                    iter_time = time;
                    soc_realtime_perhour(1,time)=1.0;
                    swapping_times = swapping_times+1;
                    swap_period = [swap_period;struct('start_end',[last_start,last_stop],...
                        'driving_detail',(soc_consume_dist(last_start:last_stop)>0),...
                        'soc_detail',soc_realtime_perhour(last_start:last_stop))];
                else
                    new_soc_origin(carIndex) = soc_realtime_perhour(1,iter_time);
                end
            end
            iter_time = iter_time+1;
        end
        swap_info{carIndex} = swapping_time_sim;    
    end
    
end

end
