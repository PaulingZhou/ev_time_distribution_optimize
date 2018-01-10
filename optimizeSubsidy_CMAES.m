clc;
clear;
% cmaes('get_cost_for_optimize', 1.8*zeros(8,1),1);
    opts.LBounds = 0; opts.UBounds = 1.5; 
%     opts.Restarts = 3;  % doubles the popsize for each restart
    X = cmaes('get_cost_for_optimize', 1.5*rand(15,1),0.6, opts);
