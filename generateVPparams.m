% Script for generating a VP parameter set
% Results are saved under "VP"
clear all;

rng(9); % set random seed

% number of VP
N = 1e3;

% Parameters from Kirouac et al. 2023
% pars = load('./pars/pars_Kirouac2023.mat');
% parsCR = pars.pCR;
% parsNR = pars.pNR;
% parsPR = pars.pPR;
% 
% % Put all the parameter values in one matrix
% parsall = [parsCR, parsNR, parsPR];
% 
% minvals = min(parsall, [], 2); % min value for each parameter
% maxvals = max(parsall, [], 2); % max value for each parameter

% Use parameter ranges from Table 1 in Kirouac et al 2023
minvals = [1e6; % B50 (1)
            0.05; %0.001; % uB (2) % FIXED VALUE
            0.001; % kkill (3)
            800; %1; % floss (4) % FIXED VALUE
            1e5; % TK50 (5)
            1; %0.2; % kt (6) % FIXED VALUE
            0.001; % kB1 (7)
            0.001; % kB2 (8)
            0.001; % um (9)
            1; %0.2; % km (10) % FIXED VALUE
            0.5; % fmax (11)
            0.2; % ke (12)
            0.001; % uE (13)
            4; % N (14)
            0.001; % kex (15)
            0.001; % dM (16)
            0.001; % dE1 (17)
            0.001; % dE2 (18)
            0.001; % dX (19)
            1e10; %1e8; % Bmax (20) % FIXED VALUE
            1; %0.2; % kx (21) % FIXED VALUE
            0.001; % rm (22)
            0.2; % kr (23)
            1; % fractionTm (24)
            1; % fractionTe1 (25)
            30; % fraction Te2(26)
            5; % fractionTx (27)
            ];

maxvals = [1e10; % B50 (1)
            0.05; %0.1; % uB (2) % FIXED VALUE
            1; % kkill (3)
            800; %1000; % floss (4) % FIXED VALUE
            1e9; % TK50 (5)
            1; %3; % kt (6)
            1; % kB1 (7)
            1; % kB2 (8)
            1; % um (9)
            1; %3; % km (10) % FIXED VALUE
            0.99; % fmax (11)
            3; % ke (12)
            1; % uE (13)
            12; % N (14)
            1; % kex (15)
            1; % dM (16)
            1; % dE1 (17)
            1; % dE2 (18)
            1; % dX (19)
            1e10; %1e12; % Bmax (20) % FIXED VALUE
            1; %3; % kx (21) % FIXED VALUE
            1; % rm (22)
            3; % kr (23)
            10; % fractionTm (24)
            10; % fractionTe1 (25)
            70; % fraction Te2(26)
            30; % fractionTx (27)
            ];

% Initialize matrix to store VP parameters
VPpars = zeros(length(minvals), N);

% Generate parameter values
for ii = 1:length(minvals)
    VPpars(ii,:) = (maxvals(ii) - minvals(ii)).*rand(1, N) + minvals(ii);
end

%% Save parameter values for VP
notes = 'minpars';
fname = strcat('./VP/', ...
                    date,...
                    '_VP',...
                    '_N-', num2str(N),...
                    '_notes-', notes,...
                    '_paramvals.mat');

save(fname)

fprintf('VP saved to: \n %s \n', fname)