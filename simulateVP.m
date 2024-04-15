% Script for conducting simulations for VP params made from
% "generateVPparams.m"
clear all;

% Parameter values
dat = load('./VP/11-Apr-2024_VP_N-1000_notes-minpars_paramvals.mat');
notes = 'minpars';
VPpars = dat.VPpars;

N_VP = size(VPpars,2); % number of VPs

% Dose level
cell_dose = 100e6;

% Initial conditions
Tm0 = 0;
Te10 = 0;
Te20 = 0;
Tx0 = 0;
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
VP_45 = [];
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
                        '_notes-', notes,...
                        '.mat');
    save(fname, 'params', 'ii', 'tspan', 't','y','cell_dose');

end

fprintf('VP done! \n')