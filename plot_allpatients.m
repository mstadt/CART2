clear all;

date_str = '04-Apr-2024';

cmapNR = cool(30); % blues % non-responder
cmapCR = spring(24); % pinks % responder
cmapPR = summer(24); % greens % partial responder

% fig specs
fgca = 18;
lw = 4;

% Make plots for NR, CR, PR
figure(1);
clf;
subplot(1,2,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-4,1e2])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(1,2,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e4+1000])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

sf = 1/2e6; % scaling factor

for ii = 1:12
    fnamebase = strcat('./sims_patients/',...
                    date_str,...
                    '_KirouacPatients',...
                    '_patID-', num2str(ii));
    fnameCR = strcat(fnamebase, '_CR.mat');
    fnameNR = strcat(fnamebase,'_NR.mat');
    fnamePR = strcat(fnamebase,'_PR.mat');

    datCR = load(fnameCR);
    datNR = load(fnameNR);
    datPR = load(fnamePR);

    % Plot CART
    subplot(1,2,1)
    plot(datNR.tNR, datNR.T_NR*sf, 'linewidth',lw, 'color', cmapNR(ii,:))
    plot(datCR.tCR, datCR.T_CR*sf, 'linewidth',lw, 'color', cmapCR(ii,:))
    plot(datPR.tPR, datPR.T_PR*sf, 'linewidth',lw, 'color', cmapPR(ii,:))


    % Plot B-tumor cells
    subplot(1,2,2)
    plot(datNR.tNR, datNR.yNR(:,5)*sf, 'linewidth',lw, 'color', cmapNR(ii,:))
    plot(datCR.tCR, datCR.yCR(:,5)*sf, 'linewidth',lw, 'color', cmapCR(ii,:))
    plot(datPR.tPR, datPR.yPR(:,5)*sf, 'linewidth',lw, 'color', cmapPR(ii,:))
end