% Script for conductin simulations for VP params
clear all;

% Parameter values
dat = load('./VP/10-Apr-2024_VP_N-10000_paramvals.mat');
%dat = load('./VP/09-Apr-2024_VP_N-10000_paramvals.mat');

VPpars = dat.VPpars;

N_VP = size(VPpars,2); % number of VPs

% Dose level
cell_dose = 100e6;

% Initial conditions
% NOTE: I got this from looking at the first row of the sim results
% in Kirouac code
Tm0 = 0;
Te10 = 0;
Te20 = 0;
Tx0 = 0;
% B0 = 1; % start > 0 for tumor growth
% Ba0 = 0;
%B0 = 2.271440561000000e+08; %2.2714e+08; %9.7317e+07; %9.7e7; % steady state B0 %1e10;
%Ba0 = 8.804326318471625e+08; %8.8043e+08; %3.7721e+08; %1e10;
B0 = 1e10;
Ba0 = 1e10;
dose0 = cell_dose; %0; % dose at t  = 0
doseX0 = 0;

IC = [Tm0;Te10;Te20;Tx0;B0;Ba0;dose0;doseX0];

% Time span
t0 = 0;
tf = 365; % simulation time in days
tspan = [t0,tf];

options = odeset('RelTol',1e-4, 'AbsTol',1e-4,...
                'NonNegative', 1:numel(IC)); % ODE solver settings

%% Conduct simulations for each parameter set
VP_45 = [1468, 2369, 2463, 2464, 2793, 4401, 5444, 6551,...
        7591, 7851, 8670, 9591, 9647, 9906];


for ii = 1:N_VP
    if mod(ii,1) == 0
        fprintf('VP number: %i \n', ii);
    end
    params = VPpars(:,ii);

    % Conduct simulation
    if ismember(ii,VP_45)
        [t,y] = ode45(@(t,y) mod_eqns(t,y,params),...
                            tspan, IC, options);
    else
        [t,y] = ode15s(@(t,y) mod_eqns(t,y,params),...
                            tspan, IC, options);
    end
    

    fname = strcat('./VPsims/',...
                        date,...
                        '_VPnum-', num2str(ii),...
                        '_dose-', num2str(cell_dose),...
                        '.mat');
    save(fname, 'params', 'ii', 'tspan', 't','y','cell_dose');

end

fprintf('VP done! \n')