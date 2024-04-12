% Postprocess VP
clear all;

% Postprocess VP results
notes = 'minpars';
date_str = '11-Apr-2024';
cell_dose = 100e6;

%load('./VP/2024-04-11_VPids.mat')
load('./VP/VPsort_notes-minpars.mat');


% fig specs
fgca = 18;
lw = 4;
sf = 1/2e6; % scaling factor

figure(3);
clf;
subplot(1,2,1)
xlabel('time (day)')
ylabel('CAR-T (cells/\muL)')
xlim([0,365])
ylim([1e-12,1e10])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

subplot(1,2,2)
xlabel('time (day)')
ylabel('B-tumor (cells/\muL)')
xlim([0,365])
ylim([0,1e6])
set(gca,'fontsize',fgca, 'YScale','log')
grid on
hold on

ids = ids_diverge;
N = length(ids);
cmap = turbo(N);
% Plot VP
for ii = 1:length(ids)
    id = ids(ii);
    fname = strcat('./VPsims/',...
                        date_str,...
                        '_VPnum-', num2str(id),...
                        '_dose-', num2str(cell_dose),...
                        '_notes-',notes,...
                        '.mat');
    dat = load(fname);
    T = dat.y(:,1) + dat.y(:,2) + dat.y(:,3) + dat.y(:,4);

    subplot(1,2,1)
    plot(dat.t, real(T) *sf, 'linewidth',lw,'color',cmap(ii,:))
    
    subplot(1,2,2)
    plot(dat.t, real(dat.y(:,5)) * sf, 'linewidth',lw,'color',cmap(ii,:))

%     if min(dat.y(:,5)) < 1e-9
%         disp('small CART')
%     end

%     figure(4)
%     subplot(2,2,1)
%     plot(dat.t, dat.y(:,1),'linewidth',lw)
%     subplot(2,2,2)
%     plot(dat.t, dat.y(:,2),'linewidth',lw)
%     subplot(2,2,3)
%     plot(dat.t, dat.y(:,3),'linewidth',lw)
%     subplot(2,2,4)
%     plot(dat.t, dat.y(:,4),'linewidth',lw)
%     
%flag = 0;
%flag = input('break? (enter 1 for break, 0 otherwise)');
%disp(id)
%pause(1)
% if flag
%     break;
% end
end