function [ subsidy_minute ] = get_subsidy_minute( subsidy,ratio )
%GET_SUBSIDY_MINUTE ��subsidy������չΪ����Ϊ��λ��subsidy_minute����
subsidy_minute = zeros(24*60,1);
for i = 1:size(subsidy,1)
    subsidy_minute(ratio*(i-1)+1:ratio*i) = subsidy(i);
end

end

