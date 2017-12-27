go_off_acc_Day1=zeros(max(go_off_simulate_Day1+1), 1);
% go_off_acc_Day2=zeros(max(go_off_perCar_Day2+1), 1);
for i = 1:length(go_off_acc_Day1)
    if(i<=1)   
        go_off_acc_Day1(i) = sum(go_off_simulate_Day1<=i-1); 
%         go_off_acc_Day2(i) = sum(go_off_perCar_Day2<=i-1); 
    else
        go_off_acc_Day1(i) = sum(go_off_simulate_Day1==i-1);
%         go_off_acc_Day2(i) = sum(go_off_perCar_Day2==i-1);
    end
end
plot(go_off_acc_Day1);
hold on;
plot(go_off_acc_Day2);