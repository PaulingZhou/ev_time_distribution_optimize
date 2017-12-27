function [ soc_realtime,swap_info ] = simulate_go_off( N, go_off_simulate_Day,soc_store,soc_origin,swap_distribution_possibility_all)
%SIMULATE_GO_OFF ʹ�����ؿ��巽��ģ��õ�N���綯����ʵʱsoc״̬�ͻ���ʱ��Ϣ������ʱ���ʣ��SOC��
%   N EV����
%   go_off_simulate_Day һ���г������п�ʼʱ�������ʱ��
%   soc_store ÿ�����Ĵ�����ֵ ~U[0.35,0.55]
%   soc_origin ÿ��������ʼSOC ~U[soc_store,1]
%   soc_low ÿ�����ĵ͵�����ֵ ~U[0.10,0.20]
%   velocity_db ÿ���ӳ��� ~N[21,3^2]km/h
%   soc_realtime vector N*1440, N������һ���е�soc�仯
%   soc_consume_dist ÿ�����ڼ�ʻ�����еĺĵ�ֲ�
%   swapping_times �������
%   swapping_time_sim vector[swapping_times*2] ÿ����ÿ��Ļ���ʱ��ͻ���ʱʣ������ֲ�
%   swapping_details vector[1*2] ÿ�λ����ʱ���ʣ�����
%   swap_distribution_possibility vector[24*60,1] ��������Ծ���

soc_low = [0.20,0.10];
velocity_db = makedist('Normal', 'mu', 21, 'sigma', 3);
soc_realtime = ones(N,26*60);
swap_info = cell(N,1);
swap_distribution_possibility_all = [swap_distribution_possibility_all;swap_distribution_possibility_all];
for carIndex = 1:N
    carIndex
    soc_consume_dist = zeros(1, 26*60);
    go_off_info_per_car = go_off_simulate_Day{carIndex}';
    if ~isempty(go_off_info_per_car)
        for go_off_info_per_time = go_off_info_per_car
            for i = 1:go_off_info_per_time(2)
                soc_consume_dist(go_off_info_per_time(1)+i-1) = random(velocity_db)/60/100;
            end
        end
        soc_realtime(carIndex,1) = soc_origin(carIndex)-soc_consume_dist(1);
        swapping_time_dist = zeros(1,2);
        iter_time = 2;
        swapping_times = 1;
        swapping_time_sim = [];
        swapping_details = [0 0];
        while iter_time <= 26*60
            soc_realtime(carIndex,iter_time) = soc_realtime(carIndex,iter_time-1) - soc_consume_dist(iter_time);
            if(soc_realtime(carIndex,iter_time)<=soc_low(1) && soc_realtime(carIndex,iter_time-1)>soc_low(1))
                swapping_time_dist(1) = iter_time;
            end
            if(soc_realtime(carIndex,iter_time)<soc_low(2) && soc_realtime(carIndex,iter_time-1)>=soc_low(2))
                swapping_time_dist(2) = iter_time-1;
                driving_time = 0;
                for i = swapping_time_dist(1):swapping_time_dist(2)
                    if soc_consume_dist(i) ~= 0
                        driving_time = driving_time+1;
                        swap_distribution_time(driving_time) = i;
                        swap_distribution_possibility(driving_time) = swap_distribution_possibility_all(i);
                    end
                end             
%                 time = ceil(unifrnd(0.000001, driving_time));
                time = randsample(swap_distribution_time, 1, 'true', swap_distribution_possibility);
%                 swapping_details(1) = time;
%                 driving_time = 0;
%                 for i = swapping_time_dist(1):swapping_time_dist(2)
%                     if soc_consume_dist(i) ~= 0
%                         driving_time = driving_time+1;
%                     end
%                     if swapping_details(1) == driving_time
%                         swapping_details(1) = i;
%                         swapping_details(2) = soc_realtime(carIndex,swapping_details(1));
%                         swapping_time_sim = [swapping_time_sim;swapping_details];
%                         break
%                     end
%                 end
                soc_realtime(carIndex,time)=1.0;
                iter_time = time;
                swapping_times = swapping_times+1;
            end
            if(iter_time == 26*60 && soc_realtime(carIndex,iter_time)<soc_store(carIndex))
                last_start = max(swapping_details(1),go_off_info_per_car(1,size(go_off_info_per_car,2)));
                last_stop = go_off_info_per_car(1,size(go_off_info_per_car,2))+go_off_info_per_car(2,size(go_off_info_per_car,2));
                swap_distribution_time = (last_start:last_stop)';
                swap_distribution_possibility = swap_distribution_possibility_all(swap_distribution_time);
                driving_time = last_stop-last_start;              
                time = randsample(swap_distribution_time, 1, 'true', swap_distribution_possibility);
                swapping_details(1) = time;
                swapping_details(2) = soc_realtime(carIndex,time);
                swapping_time_sim = [swapping_time_sim;swapping_details];
                iter_time = time;
                soc_realtime(carIndex,time)=1.0;
                swapping_times = swapping_times+1;
            end
            iter_time = iter_time+1;
        end
    end
%     for time = swapping_time_sim
%        if time(1) == 0
%            swapping_time_sim = [];
%        end
%     end
    swap_info{carIndex} = swapping_time_sim;
    
    
end
new_soc_origin = soc_realtime(:,26*60);
end
