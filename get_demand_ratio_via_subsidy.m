function [ demand_ratio ] = get_demand_ratio_via_subsidy( subsidy_minute )
%GET_DEMAND_RATIO_VIA_PRICE ͨ�������۸��û�������ı�����ϵ
%subsidy_minute demand_ratio��Ϊ����1440*1
price_average = 1.8-mean(subsidy_minute);
x = (1.8-subsidy_minute)/price_average;
demand_ratio = (0.331945*(1.000000-x).^1.450242+1.000000).*(x<1)...
                +1*(x==1)...
                +(-0.449984*(x-1.000000).^1.553679+1.000000).*(x>1);
demand_ratio = demand_ratio.*(demand_ratio>0)+eps;
end

