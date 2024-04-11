% Plot results from varyTK50.m
clear all;

% Get results for varied TK50 ratios
minratio = 1e-3;
maxratio = 3;
nvals = 25;
TK50ratios = sort([linspace(minratio, maxratio, nvals), 1]);

date_str = '11-Apr-2024';
notes = 'widerrange';


% Set color scheme
cmapNR = parula(length(TK50ratios)); % blues % non-responder
cNR = cmapNR(3,:);
cmapCR = spring(length(TK50ratios)); % pinks % responder
cCR = cmapCR(3,:);
cmapPR = summer(length(TK50ratios)); % greens % partial responder
cPR = cmapPR(3,:);

% Fig specs
sf = 1/2e6; % scaling factor
fgca = 18;
fleg = 12;
fsgtit = 24;
lw1 = 2;
ls1 = ':'; ls2 = '-';
yminmax_CART = [1e-3,1e2];
yminmax_B = [1e-2,1e4];

%  Get baseline simulation for NR, CR, PR example patients
[Tbase, Ybase] = vary_res(1, -1); % No change
tNR = Tbase{1}; tPR = Tbase{2}; tCR = Tbase{3};
yNR = Ybase{1}; yPR = Ybase{2}; yCR = Ybase{3};
T_CR = yCR(:,1) + yCR(:,2) + yCR(:,3) + yCR(:,4);
T_NR = yNR(:,1) + yNR(:,2) + yNR(:,3) + yNR(:,4);
T_PR = yPR(:,1) + yPR(:,2) + yPR(:,3) + yPR(:,4);

% Plot baseline model results
figure(2);
clf;
nr = 1; nc = 2;
% Make plots for NR, CR, PR
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim(yminmax_CART)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim(yminmax_B)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

% Plot CART
subplot(nr,nc,1)
plot(tNR, T_NR*sf, 'linewidth',lw1,'color',cNR,'linestyle',ls1)
plot(tCR, T_CR*sf, 'linewidth',lw1,'color',cCR,'linestyle',ls1)
plot(tPR, T_PR*sf, 'linewidth',lw1,'color',cPR,'linestyle',ls1)
legend('non-responder', 'complete responder', 'partial responder')

subplot(nr,nc,2)
plot(tNR, yNR(:,5)*sf, 'linewidth',lw1,'color',cNR,'linestyle',ls1)
plot(tCR, yCR(:,5)*sf, 'linewidth',lw1,'color',cCR,'linestyle',ls1)
plot(tPR, yPR(:,5)*sf, 'linewidth',lw1,'color',cPR,'linestyle',ls1)
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
ylim(yminmax_CART)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim(yminmax_B)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

labs = cell(size(TK50ratios));
for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date_str,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    if TK50ratio < 0.1
        labs{ii} = sprintf('%0.1d x TK50', TK50ratio);
    else
        labs{ii} = sprintf('%0.2f x TK50', TK50ratio);
    end
    dat = load(fname);
    % get NR results
    t = dat.T{1}; 
    y = dat.Y{1};

    if TK50ratio == 1
        ls = ls1;
        lw = 2*lw1;
    else
        ls = ls2;
        lw = lw1;
    end

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapNR(ii, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapNR(ii,:),'linestyle',ls)
end
sgtitle('TK50 impact on NR','fontsize',fsgtit)
legend(labs, 'fontsize', fleg)
AddLetters2Plots(figure(3),{'A','B'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)

%% TK50 impact on PR
figure(4)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim(yminmax_CART)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim(yminmax_B)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on


for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date_str,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    dat = load(fname);
    % get PR results
    t = dat.T{2}; 
    y = dat.Y{2};

    if TK50ratio == 1
        ls = ls1;
        lw = 2*lw1;
    else
        ls = ls2;
        lw = lw1;
    end

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapPR(ii, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapPR(ii,:),'linestyle',ls)
end
sgtitle('TK50 impact on PR','fontsize',fsgtit)
legend(labs, 'fontsize', fleg)
AddLetters2Plots(figure(4),{'A','B'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)

%% TK50 impact on CR
figure(5)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim(yminmax_CART)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(nr,nc,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim(yminmax_B)
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on


for ii = 1:length(TK50ratios)
    TK50ratio = TK50ratios(ii);
    fname = strcat('./varyTK50/',...
                        date_str,...
                        '_varyTK50',...
                        '_TK50rat-', num2str(TK50ratio),...
                        '_notes-', notes,...
                        '.mat');
    dat = load(fname);
    % get CR results
    t = dat.T{3}; 
    y = dat.Y{3};

    if TK50ratio == 1
        ls = ls1;
        lw = 2*lw1;
    else
        ls = ls2;
        lw = lw1;
    end

    subplot(nr,nc,1)
    T = y(:,1) + y(:,2) + y(:,3) + y(:,4);
    plot(t, T*sf, 'linewidth',lw,'color',cmapCR(ii, :), 'linestyle',ls)

    subplot(nr,nc,2)
    plot(t, y(:,5)*sf, 'linewidth',lw,'color',cmapCR(ii,:),'linestyle',ls)

end
sgtitle('TK50 impact on CR','fontsize',fsgtit)
legend(labs, 'fontsize', fleg)
AddLetters2Plots(figure(5),{'A','B'},'HShift', -0.06, 'VShift', -0.06, ...
                'fontsize', 22)


