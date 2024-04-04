clear all;

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

% Parameters
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

for ii = 1:12
    disp(ii)
    % Example patient
    paramsCR = parsCR(:,ii); 
    paramsNR = parsNR(:,ii);
    paramsPR = parsPR(:,ii);
    
    
    % Run simulation
    options = odeset('RelTol',1e-4, 'AbsTol',1e-7); % ODE solver settings
    [tCR,yCR]=ode15s(@(t,y) mod_eqns(t,y,paramsCR),...
                            tspan, IC, options);
    %T = Tm + Te1 + Te2 +Tx
    T_CR = yCR(:,1) + yCR(:,2) + yCR(:,3) + yCR(:,4);

    [tNR,yNR]=ode15s(@(t,y) mod_eqns(t,y,paramsNR),...
                            tspan, IC, options);
    T_NR = yNR(:,1) + yNR(:,2) + yNR(:,3) + yNR(:,4);

    [tPR,yPR]=ode15s(@(t,y) mod_eqns(t,y,paramsPR),...
                            tspan, IC, options);
    T_PR = yPR(:,1) + yPR(:,2) + yPR(:,3) + yPR(:,4);


    fnamebase = strcat('./sims_patients/',...
                    date,...
                    '_KirouacPatients',...
                    '_patID-', num2str(ii));
    fnameCR = strcat(fnamebase, '_CR.mat');
    fnameNR = strcat(fnamebase,'_NR.mat');
    fnamePR = strcat(fnamebase,'_PR.mat');

    save(fnameCR, 'tCR', 'yCR', 'T_CR');
    save(fnameNR, 'tNR', 'yNR', 'T_NR');
    save(fnamePR, 'tPR', 'yPR', 'T_PR');
end % for ii