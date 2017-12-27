function [go_off_simulate] = calc_go_off_time_distribution_perCar( go_off_perCar_perDay, go_off_survey_hour)
%CALC_GO_OFF_TIME_DISTRIBUTION_PERCAR 计算电动车的出行分布
%   go_off_perCar_perDay 该车今日出行次数
%   go_off_survey 出行分布
%   go_off_sim 模拟出的该车今日出行分布
go_off_survey_min = zeros(24*60,1);
b = 11.17/21*60;   %arg in rayleigh distribution
pd = makedist('Rayleigh', 'b', b);
go_off_simulate = [0 0];
for i = 1:length(go_off_survey_min)
    go_off_survey_min(i) = ceil(go_off_survey_hour(ceil(i/60))/60); % make go-off time dist per min
end
go_off_index = 1;
while go_off_index <= go_off_perCar_perDay
    go_off_start_sim = randsample(1:24*60, 1, 'true', go_off_survey_min);
    go_off_persist = ceil(random(pd));
    isValid = 1;
    for i = 2:size(go_off_simulate,1)
        if go_off_start_sim >= go_off_simulate(i,1)+go_off_simulate(i,2)
            continue
        else
            if go_off_start_sim >= go_off_simulate(i,1)
               isValid = 0;
               break;
            else
                if go_off_start_sim+go_off_persist >= go_off_simulate(i,1)
                    isValid = 0;
                end
                break;
            end
        end

    end
    if isValid
          go_off_simulate = [go_off_simulate;[go_off_start_sim,go_off_persist]];
          go_off_simulate = sortrows(go_off_simulate);
          go_off_index = go_off_index+1;
    end
end
for i = 1:size(go_off_simulate,1)-1
     if go_off_simulate(i,1)+go_off_simulate(i,2) > go_off_simulate(i+1,1)
        1
     end
end
go_off_simulate(1,:) = [];
end
