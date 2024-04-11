function [T,Y] = vary_res(par_ratio, par_num)
% INPUT: par_ratio -- ratio for parameter
%        par_num -- parameter number (set to -1 for no change)
% Get Kirouac2023 parameters
parsK2023 = load('./pars/pars_Kirouac2023.mat');
IC = load('./IC/ICbase_celldose-1e6.mat').IC;
% Get example simulation for NR, CR, PR
pars_NR = parsK2023.pNR(:,1);
pars_PR = parsK2023.pPR(:,2);
pars_CR = parsK2023.pCR(:,5);

if par_num > 0
    pars_NR(par_num) = pars_NR(par_num) * par_ratio;
    pars_PR(par_num) = pars_PR(par_num) * par_ratio;
    pars_CR(par_num) = pars_CR(par_num) * par_ratio;
end

% Time span
t0 = 0;
tf = 365; % simulation time in days
tspan = [t0,tf];
options = odeset('RelTol',1e-4, 'AbsTol',1e-7); % ODE solver settings

[tCR,yCR]=ode15s(@(t,y) mod_eqns(t,y,pars_CR),...
                            tspan, IC, options);
[tNR,yNR]=ode15s(@(t,y) mod_eqns(t,y,pars_NR),...
                            tspan, IC, options);
[tPR,yPR]=ode15s(@(t,y) mod_eqns(t,y,pars_PR),...
                            tspan, IC, options);

T = {tNR, tPR, tCR};
Y = {yNR, yPR, yCR};
end