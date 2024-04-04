clear all;
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(1,:);
cmapCR = spring(24); % pinks % responder
cCR = cmapCR(3,:);
cmapPR = summer(24); % greens % partial responder
cPR = cmapPR(3,:);

Pmat = [parsCR parsPR parsNR];
[COEFF, SCORE, LATENT, ~, EXPLAINED, ~] = pca(log10(Pmat)');
disp(EXPLAINED(1:2))
PCAcoeff = COEFF(:,[1 2]);
figure(2)
clf;
hold on
ms = 100;
scatter(SCORE(1:12,1)',SCORE(1:12,2)',ms,cCR,'filled','o')
scatter(SCORE(13:24,1)',SCORE(13:24,2)',ms,cPR,'filled','s')
scatter(SCORE(25:36,1)',SCORE(25:36,2)',ms,cNR,'filled','^')
legend('complete responder','partial responder','non-responder','location','southwest')
hold off
%set(figure(2),'Units','inches','Position',[5,5,4.25/2,4.25/2])
xlabel('PC-1')
ylabel('PC-2')
set(gca,'fontsize',18)
box on