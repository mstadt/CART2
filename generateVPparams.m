% Script for generating a VP
clear all;

rng(24); % set random seed

% number of VP
N = 1e4;

% Parameters from Kirouac et al. 2023
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

% Put all the parameter values in one matrix
parsall = [parsCR, parsNR, parsPR];

minvals = min(parsall, [], 2); % min value for each parameter
maxvals = max(parsall, [], 2); % max value for each parameter

% Initialize matrix to store VP parameters
VPpars = zeros(length(minvals), N);

% Generate parameter values
for ii = 1:length(minvals)
    VPpars(ii,:) = (maxvals(ii) - minvals(ii)).*rand(1, N) + minvals(ii);
end

%% Save parameter values for VP

fname = strcat('./VP/', ...
                    date,...
                    '_VP',...
                    '_N-', num2str(N),...
                    '_paramvals.mat');

save(fname)

fprintf('VP saved to: \n %s \n', fname)