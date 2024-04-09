clear all

parsK2023 = load('./pars/pars_Kirouac2023.mat');
IC = load('./IC/ICbase_celldose-1e6.mat').IC;
% Get example simulation for NR, CR, PR
parsNR = parsK2023.pNR(:,1);
parsPR = parsK2023.pPR(:,2);
parsCR = parsK2023.pCR(:,5);

Pmat = [parsCR parsPR parsNR];