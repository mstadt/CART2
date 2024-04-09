% Script for varying TK50 and seeing how it impacts the model results
clear all;

% Get results for varied TK50 ratios
minratio = 1/6;
maxratio = 7;
nvals = 20;
TK50ratios = linspace(minratio, maxratio, nvals);
%TK50ratios = (1/6):1:6;



% Set color scheme
cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(3,:);
cmapCR = spring(24); % pinks % responder
cCR = cmapCR(3,:);
cmapPR = summer(24); % greens % partial responder
cPR = cmapPR(3,:);

% Fig specs
sf = 1/2e6; % scaling factor
fgca = 18;
lw = 2;
ls1 = ':'; ls = '-';

%  Get baseline simulation for NR, CR, PR example patients
[Tbase, Ybase] = vary_res(1, -1); % No change
tNR = Tbase{1}; tPR = Tbase{2}; tCR = Tbase{3};
yNR = Ybase{1}; yPR = Ybase{2}; yCR = Ybase{3};
T_CR = yCR(:,1) + yCR(:,2) + yCR(:,3) + yCR(:,4);
T_NR = yNR(:,1) + yNR(:,2) + yNR(:,3) + yNR(:,4);
T_PR = yPR(:,1) + yPR(:,2) + yPR(:,3) + yPR(:,4);

par_num = 5; % TK50 parameter number
notes = 'try1';
for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    [T, Y] = vary_res(TK50ratio, par_num);
    fname = strcat('./varyTK50/',...
                        date,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    save(fname, 'T', 'Y', 'TK50ratio')
end

% Plot baseline model results
figure(2);
clf;
nr = 1; nc = 2;
% Make plots for NR, CR, PR
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-4,1e2])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e4+1000])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

% Plot CART
subplot(nr,nc,1)
plot(tNR, T_NR*sf, 'linewidth',lw,'color',cNR,'linestyle',ls1)
plot(tCR, T_CR*sf, 'linewidth',lw,'color',cCR,'linestyle',ls1)
plot(tPR, T_PR*sf, 'linewidth',lw,'color',cPR,'linestyle',ls1)
legend('non-responder', 'complete responder', 'partial responder')

subplot(nr,nc,2)
plot(tNR, yNR(:,5)*sf, 'linewidth',lw,'color',cNR,'linestyle',ls1)
plot(tCR, yCR(:,5)*sf, 'linewidth',lw,'color',cCR,'linestyle',ls1)
plot(tPR, yPR(:,5)*sf, 'linewidth',lw,'color',cPR,'linestyle',ls1)
legend('non-responder', 'complete responder', 'partial responder')

%% TK50 impact on NR
figure(3)
clf;
nr = 1; nc = 2;
% Make plots for NR, CR, PR
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-4,1e2])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e4+1000])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

% Plot CART
subplot(nr,nc,1)
plot(tNR, T_NR*sf, 'linewidth',lw,'color',cNR,'linestyle',ls)

subplot(nr,nc,2)
plot(tNR, yNR(:,5)*sf, 'linewidth',lw,'color',cNR,'linestyle',ls)

for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    dat = load(fname);
    % get NR results
    t = dat.T{1}; 
    y = dat.Y{1};

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapNR(ii+3, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapNR(ii+3,:),'linestyle',ls)
end
sgtitle('TK50 impact on NR')

%% TK50 impact on PR
figure(4)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-4,1e2])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e4+1000])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

% Plot CART
subplot(nr,nc,1)
plot(tPR, T_PR*sf, 'linewidth',lw,'color',cPR,'linestyle',ls)

subplot(nr,nc,2)
plot(tPR, yPR(:,5)*sf, 'linewidth',lw,'color',cPR,'linestyle',ls)

for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    dat = load(fname);
    % get PR results
    t = dat.T{2}; 
    y = dat.Y{2};

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapPR(ii+3, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapPR(ii+3,:),'linestyle',ls)
end
sgtitle('TK50 impact on PR')

%% TK50 impact on CR
figure(5)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-4,1e2])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e4+1000])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,1)
plot(tCR, T_CR*sf, 'linewidth',lw,'color',cCR,'linestyle',ls)

subplot(nr,nc,2)
plot(tPR, yPR(:,5)*sf, 'linewidth',lw,'color',cCR,'linestyle',ls)

for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    dat = load(fname);
    % get CR results
    t = dat.T{3}; 
    y = dat.Y{3};

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapCR(ii+3, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapCR(ii+3,:),'linestyle',ls)
end
sgtitle('TK50 impact on CR')

