clear all;

date_str = '09-Apr-2024';
cell_dose = 100e6;

cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(3,:);
cmapCR = spring(30); % pinks % responder
cCR = cmapCR(3,:);
cmapPR = summer(30); % greens % partial responder
cPR = cmapPR(3,:);

% fig specs
fgca = 18;
fleg = 14;
lw = 3;
lsNR = '-'; lsCR = '-'; lsPR = '-';

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
    cNR = cmapNR(2+ii,:);
    cCR = cmapCR(2+ii,:);
    cPR = cmapPR(2+ii,:);
    fnamebase = strcat('./sims_patients/',...
                    date_str,...
                    '_KirouacPatients',...
                    '_patID-', num2str(ii),...
                    '_dose-', num2str(cell_dose));
    fnameCR = strcat(fnamebase, '_CR.mat');
    fnameNR = strcat(fnamebase,'_NR.mat');
    fnamePR = strcat(fnamebase,'_PR.mat');

    datCR = load(fnameCR);
    datNR = load(fnameNR);
    datPR = load(fnamePR);

    % Plot CART
    subplot(1,2,1)
    plot(datNR.tNR, datNR.T_NR*sf, 'linewidth',lw, 'color', cNR,'linestyle',lsNR)
    plot(datCR.tCR, datCR.T_CR*sf, 'linewidth',lw, 'color', cCR,'linestyle',lsCR)
    plot(datPR.tPR, datPR.T_PR*sf, 'linewidth',lw, 'color', cPR, 'linestyle',lsPR)


    % Plot B-tumor cells
    subplot(1,2,2)
    plot(datNR.tNR, datNR.yNR(:,5)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,5)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,5)*sf, 'linewidth',lw, 'color', cPR)
end
subplot(1,2,1)
legend('non-responder', 'complete responder', 'partial responder','location','best')
subplot(1,2,2)
legend('non-responder', 'complete responder', 'partial responder','location','best')

AddLetters2Plots(figure(1),{'A','B'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)

%% Plot T cells
% Make plots for NR, CR, PR
ymin = 0;
ymax = 60;
figure(2);
clf;
subplot(2,2,1)
xlabel('time (day)')
ylabel('T_m (cells/\muL)')
xlim([0,365])
ylim([ymin,ymax])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,2)
xlabel('time (day)')
ylabel('T_{e1} (cells/\muL)')
xlim([0,365])
ylim([ymin,ymax])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,3)
xlabel('time (day)')
ylabel('T_{e2} (cells/\muL)')
xlim([0,365])
ylim([ymin,ymax])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,4)
xlabel('time (day)')
ylabel('T_{x} (cells/\muL)')
xlim([0,365])
ylim([ymin,ymax])
set(gca,'fontsize',fgca)
grid on
hold on

sf = 1/2e6; % scaling factor

% Set up vectors for getting output at specific time (used for next figure)
t_stop = 365;
t_output = [0:0.05:10 11:1:t_stop]; 

Tm_sim = zeros(length(t_output), 12,3); % 1 -- NR, 2 -- PR, 3 -- CR
Te1_sim = zeros(length(t_output),12,3);
Te2_sim = zeros(length(t_output),12,3);
Tx_sim = zeros(length(t_output),12,3);

for ii = 1:12
    cNR = cmapNR(2+ii,:);
    cCR = cmapCR(2+ii,:);
    cPR = cmapPR(2+ii,:);

    fnamebase = strcat('./sims_patients/',...
                    date_str,...
                    '_KirouacPatients',...
                    '_patID-', num2str(ii),...
                    '_dose-', num2str(cell_dose));
    fnameCR = strcat(fnamebase, '_CR.mat');
    fnameNR = strcat(fnamebase,'_NR.mat');
    fnamePR = strcat(fnamebase,'_PR.mat');

    datCR = load(fnameCR);
    datNR = load(fnameNR);
    datPR = load(fnamePR);

    % Tm
    subplot(2,2,1)
    plot(datNR.tNR, datNR.yNR(:,1)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,1)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,1)*sf, 'linewidth',lw, 'color', cPR)

    % Interpolate specific points
    Tm_sim(:,ii,1) = interp1(datNR.tNR, datNR.yNR(:,1), t_output);
    Tm_sim(:,ii,2) = interp1(datPR.tPR, datPR.yPR(:,1), t_output);
    Tm_sim(:,ii,3) = interp1(datCR.tCR, datCR.yCR(:,1), t_output);


    % Te1
    subplot(2,2,2)
    plot(datNR.tNR, datNR.yNR(:,2)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,2)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,2)*sf, 'linewidth',lw, 'color', cPR)

    % Interpolate specific points
    Te1_sim(:,ii,1) = interp1(datNR.tNR, datNR.yNR(:,2), t_output);
    Te1_sim(:,ii,2) = interp1(datPR.tPR, datPR.yPR(:,2), t_output);
    Te1_sim(:,ii,3) = interp1(datCR.tCR, datCR.yCR(:,2), t_output);

    % Te2
    subplot(2,2,3)
    plot(datNR.tNR, datNR.yNR(:,3)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,3)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,3)*sf, 'linewidth',lw, 'color', cPR)

    % Interpolate specific points
    Te2_sim(:,ii,1) = interp1(datNR.tNR, datNR.yNR(:,3), t_output);
    Te2_sim(:,ii,2) = interp1(datPR.tPR, datPR.yPR(:,3), t_output);
    Te2_sim(:,ii,3) = interp1(datCR.tCR, datCR.yCR(:,3), t_output);


    % Tx
    subplot(2,2,4)
    plot(datNR.tNR, datNR.yNR(:,4)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,4)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,4)*sf, 'linewidth',lw, 'color', cPR)

    % Interpolate specific points
    Tx_sim(:,ii,1) = interp1(datNR.tNR, datNR.yNR(:,4), t_output);
    Tx_sim(:,ii,2) = interp1(datPR.tPR, datPR.yPR(:,4), t_output);
    Tx_sim(:,ii,3) = interp1(datCR.tCR, datCR.yCR(:,4), t_output);
end
subplot(2,2,1)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,2)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,3)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,4)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)

AddLetters2Plots(figure(2),{'A','B','C','D'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)


%% Repeat of Fig 2 with smaller x scale
figure(3)
xmin = 0; xmax = 100;
% Make plots for NR, CR, PR
ymin = 0;
ymax = 60;
clf;
subplot(2,2,1)
xlabel('time (day)')
ylabel('T_m (cells/\muL)')
xlim([xmin,xmax])
ylim([ymin,40])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,2)
xlabel('time (day)')
ylabel('T_{e1} (cells/\muL)')
xlim([xmin,xmax])
ylim([ymin,ymax])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,3)
xlabel('time (day)')
ylabel('T_{e2} (cells/\muL)')
xlim([xmin,xmax])
ylim([ymin,30])
set(gca,'fontsize',fgca)
grid on
hold on

subplot(2,2,4)
xlabel('time (day)')
ylabel('T_{x} (cells/\muL)')
xlim([xmin,xmax])
ylim([ymin,20])
set(gca,'fontsize',fgca)
grid on
hold on

sf = 1/2e6; % scaling factor

for ii = 1:12
    cNR = cmapNR(2+ii,:);
    cCR = cmapCR(2+ii,:);
    cPR = cmapPR(2+ii,:);

    fnamebase = strcat('./sims_patients/',...
                    date_str,...
                    '_KirouacPatients',...
                    '_patID-', num2str(ii),...
                    '_dose-', num2str(cell_dose));
    fnameCR = strcat(fnamebase, '_CR.mat');
    fnameNR = strcat(fnamebase,'_NR.mat');
    fnamePR = strcat(fnamebase,'_PR.mat');

    datCR = load(fnameCR);
    datNR = load(fnameNR);
    datPR = load(fnamePR);

    % Tm
    subplot(2,2,1)
    plot(datNR.tNR, datNR.yNR(:,1)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,1)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,1)*sf, 'linewidth',lw, 'color', cPR)



    % Te1
    subplot(2,2,2)
    plot(datNR.tNR, datNR.yNR(:,2)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,2)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,2)*sf, 'linewidth',lw, 'color', cPR)



    % Te2
    subplot(2,2,3)
    plot(datNR.tNR, datNR.yNR(:,3)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,3)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,3)*sf, 'linewidth',lw, 'color', cPR)



    % Tx
    subplot(2,2,4)
    plot(datNR.tNR, datNR.yNR(:,4)*sf, 'linewidth',lw, 'color', cNR)
    plot(datCR.tCR, datCR.yCR(:,4)*sf, 'linewidth',lw, 'color', cCR)
    plot(datPR.tPR, datPR.yPR(:,4)*sf, 'linewidth',lw, 'color', cPR)

end
subplot(2,2,1)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,2)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,3)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)
subplot(2,2,4)
legend('NR', 'CR', 'PR','location','best','fontsize',fleg)

AddLetters2Plots(figure(3),{'A','B','C','D'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)



