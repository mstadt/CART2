% Conduct PCA for the VP population.
clear all;

load('./VP/VPsort_notes-minpars.mat')

dat = load('./VP/11-Apr-2024_VP_N-1000_notes-minpars_paramvals.mat');
VPpars = dat.VPpars;

% colors for plot
cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(1,:);
cmapCR = spring(24); % pinks % responder (PR or CR)
cCR = cmapCR(3,:);

cmapDiv = autumn(5);
cDiv = cmapDiv(2,:);

cOther = 'k'; 

[COEFF, SCORE, LATENT, ~, EXPLAINED, ~] = pca(log10(VPpars)');

disp(EXPLAINED(1:2))

PCAcoeff = COEFF(:,[1 2]);

figure(2)
clf;
hold on
ms = 100;
scatter(SCORE(ids_PRCR,1)',SCORE(ids_PRCR,2)',ms,cCR,'filled','o')
scatter(SCORE(ids_diverge,1)',SCORE(ids_diverge,2)',ms,cDiv,'filled','s')
scatter(SCORE(ids_NR,1)',SCORE(ids_NR,2)',ms,cNR,'filled','^')