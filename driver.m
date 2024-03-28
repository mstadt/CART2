clear all;

% Initial conditions
% NOTE: I got this from looking at the first row of the sim results
% in Kirouac code
Tx0 = 0;
T0 = 0;
B0 = 1e10;
Ba0 = 1e10;
Tm0 = 0;
Te10 = 0;
Te20 = 0;


% Parameters
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

% take first set of parameters for one simulation
params = parsCR(:,1); 


% Time span
t0 = 0;
tf = 365; % simulation time in days
tspan = [t0,tf];

% Dose level
cell_dose = 100e6;

