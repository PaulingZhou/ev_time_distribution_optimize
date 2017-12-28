clc;
clear;
load('timeDistribution.mat');
N = 1000;
expectedCountDay1=unifrnd (3,3.32);   %~U[3,3.32]
expectedCountDay2=unifrnd (3,3.32);   %~U[3,3.32]
go_off_perCar_Day1=round(normrnd(expectedCountDay1, 1.0, N, 1));    %~N(expectedCount,1.0)
go_off_perCar_Day2=round(normrnd(expectedCountDay2, 1.0, N, 1));    %~N(expectedCount,1.0)
P = 19.2;
for i = 1:length(go_off_perCar_Day1)
    if(go_off_perCar_Day1(i) < 0)
        go_off_perCar_Day1(i) = 0;
    end
end
for i = 1:length(go_off_perCar_Day2)
    if(go_off_perCar_Day2(i) < 0)
        go_off_perCar_Day2(i) = 0;
    end
end
go_off_simulate_Day1 = cell(N,1);
go_off_simulate_Day2 = cell(N,1);
for i = 1:N
    go_off_simulate_Day1(i) = {calc_go_off_time_distribution_perCar(go_off_perCar_Day1(i), go_off)};
    go_off_simulate_Day2(i) = {calc_go_off_time_distribution_perCar(go_off_perCar_Day2(i), go_off)};
end

