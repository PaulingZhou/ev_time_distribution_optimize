function [ income ] = get_total_income( swap_info_day )
%GET_TOTAL_INCOME 收入情况
income = 0;
for i = 1:length(swap_info_day)
    swap_info_percar = swap_info_day{i};
    if(size(swap_info_percar,1) >= 1)
        income = income + sum(1-swap_info_percar(:,2))*19.2*1.8;
    end
end
end

