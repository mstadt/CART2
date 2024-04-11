% PCA of parameter sets between NR, PR, and CR
% This code is modified from the code provided in Kirouac et al. 2023

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
%disp(EXPLAINED(1:2))
fprintf('PC1 variability: %f \n', EXPLAINED(1))
fprintf('PC2 variability: %f \n', EXPLAINED(2))
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
xlabel('PC-1')
ylabel('PC-2')
set(gca,'fontsize',18)
box on


figure(3)
clf;
subplot(2,1,1)
% Waterfall plot (PC1)
colours = spring(4);
c1 = colours(2,:);
c3 = c1;
c2 = c1;
parnames = {'B50','\mu_B','k_{kill}','f_{loss}','TK50','kt','k_{B1}','k_{B2}',...
    '\mu_M','km','f_{max}','ke','\mu_E','N','k_{ex}','d_M','d_{E1}','d_{E2}',...
    'd_X','B_{max}','kx','r_M','kr','f_{TM}','f_{TE1}','f_{TE2}','f_{TX}'};
[B,I] = sort(PCAcoeff(:,1),'descend');
b = bar(B,'FaceColor','flat');
set(gca,'XTick',1:length(B));
set(gca,'XTickLabel',parnames(I));
xtickangle(90)
box on
ylabel('PC-1 Coefficients')
xlabel('Parameter')
b.CData(1:3,:) = repmat(c1,[3,1]);
b.CData(4:end-1,:) = repmat(c2,[23,1]);
b.CData(end,:) = repmat(c3,[1,1]);
set(gca,'fontsize',18)

I1 = I;


% Waterfall plot (PC2)
subplot(2,1,2)

c3 = c1; %colours(1,:);
c2 = c1; %colours(2,:);
parnames = {'B50','\mu_B','k_{kill}','f_{loss}','TK50','kt','k_{B1}','k_{B2}',...
    '\mu_M','km','f_{max}','ke','\mu_E','N','k_{ex}','d_M','d_{E1}','d_{E2}',...
    'd_X','B_{max}','kx','r_M','kr','f_{TM}','f_{TE1}','f_{TE2}','f_{TX}'};
%[B,I] = sort(PCAcoeff(:,2),'descend');
B2 = PCAcoeff(:,2);
B = B2(I1);
b = bar(B,'FaceColor','flat');
set(gca,'XTick',1:length(B));
set(gca,'XTickLabel',parnames(I1));
xtickangle(90)
box on
ylabel('PC-2 Coefficients')
xlabel('Parameter')
b.CData(1:3,:) = repmat(c1,[3,1]);
b.CData(4:end-1,:) = repmat(c2,[23,1]);
b.CData(end,:) = repmat(c3,[1,1]);
set(gca,'fontsize',18)

AddLetters2Plots(figure(3),{'A','B'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)

