% Create histograms of the NR, CR, and PR parameter values
clear all;

cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(1,:);
cmapCR = spring(24); % pinks % responder
cCR = cmapCR(3,:);
cmapPR = summer(24); % greens % partial responder
cPR = cmapPR(3,:);

% Parameters
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

% Top 6 parameters by variance
% dE2 - 18
% muM - 9
% dM - 16
% dE1 - 17
% kkill - 3
% TK50 - 5
yminmax = [0,12];
fgca = 16;
labs = {'complete responder','partial responder', 'non-responder'};

figure(2)
clf;
nr = 2; nc = 3;
subplot(nr,nc,1)
hold on
% de2
id = 18; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 2;
xlabel('d_{E2}')
ylim(yminmax)
set(gca,'fontsize',fgca)
legend(labs)

subplot(nr,nc,2)
hold on
% uM
id = 9; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 10;
ylim(yminmax)
xlabel('\mu_{M}')
set(gca,'fontsize',fgca)
legend(labs)

subplot(nr,nc,3)
hold on
% dM
id = 16; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 10;
ylim(yminmax)
xlabel('d_{M}')
set(gca,'fontsize',fgca)
legend(labs)

subplot(nr,nc,4)
hold on
% dE1
id = 17; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 10;
ylim(yminmax)
xlabel('d_{E1}')
set(gca,'fontsize',fgca)
legend(labs)


subplot(nr,nc,5)
hold on
% kkill
id = 3; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 10;
ylim(yminmax)
xlabel('k_{kill}')
set(gca,'fontsize',fgca)
legend(labs)


subplot(nr,nc,6)
hold on
% TK50
id = 5; % param id
h1 = histogram(parsCR(id,:), 'FaceColor', cCR, 'FaceAlpha', 0.8);
h1.NumBins = 10;
h2 = histogram(parsPR(id,:), 'FaceColor', cPR, 'FaceAlpha', 0.6);
h2.NumBins = 10;
h3 = histogram(parsNR(id,:), 'FaceColor', cNR, 'FaceAlpha', 0.4);
h3.NumBins = 10;
ylim(yminmax)
xlabel('TK50')
set(gca,'fontsize',fgca)
legend(labs)
