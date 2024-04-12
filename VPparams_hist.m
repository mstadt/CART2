% Create histograms of the NR, Responder, Diverger parameter values (from
% 10K VP)
clear all;

% IDs for viritual patient categories
load('./VP/VPsort_notes-minpars.mat')

% VP parameter values
dat = load('./VP/11-Apr-2024_VP_N-1000_notes-minpars_paramvals.mat');
VPpars = dat.VPpars;

% figure specs
% colors for plot
cmapNR = parula(30); % blues % non-responder
cNR = cmapNR(1,:);
cmapCR = spring(24); % pinks % responder (PR or CR)
cCR = 'red'; %cmapCR(1,:);

cmapDiv = autumn(5);
cDiv = 'k'; %cmapDiv(2,:);

alpha1 = 0.8;
alpha2 = 0.6;
alpha3 = 0.4;

cOther = 'k'; 

pnames = get_parnames(); % get parameter names
fgca = 16;

pvals = nan(size(pnames));

% Histogram of each parameter
for ii = 1:27
    figure(ii)
    clf;
    hold on
    xlabel(pnames{ii})
    parsDiv = VPpars(ii, ids_diverge);
    parsPRCR = VPpars(ii, ids_PRCR);
    parsNR = VPpars(ii,ids_NR);

    h1 = histogram(parsDiv, 'FaceColor', cDiv, 'FaceAlpha', alpha1, ...
                'Normalization', 'probability', 'DisplayName', 'diverger');
    if ii == 1
        h1.BinWidth = 0.5e9;
    elseif ii == 3
        h1.BinWidth = 0.1;
    elseif ii == 8
        h1.BinWidth = 0.05;
    elseif ii == 9
        h1.BinWidth = 0.05; %0.1;
    elseif ii == 11
        h1.BinWidth = 0.05;
    elseif ii == 12
        h1.BinWidth = 0.1;
    elseif ii == 13
        h1.BinWidth = 0.05; %0.1;
    elseif ii == 14
        h1.BinWidth = 0.5;
    elseif ii == 16
        h1.BinWidth = 0.05; %0.1;
    elseif ii == 22
        h1.BinWidth = 0.05;
    end
    h2 = histogram(parsPRCR, 'FaceColor', cCR, 'FaceAlpha', alpha2, ...
                'Normalization', 'probability',...
                'DisplayName', 'responder');
    h2.BinWidth = h1.BinWidth;
    h3 = histogram(parsNR, 'FaceColor', cNR, 'FaceAlpha', alpha3, ...
                'Normalization', 'probability',...
                'DisplayName', 'non-responder');
    h3.BinWidth = h1.BinWidth;

    legend()
    ylabel('Density')
    set(gca,'fontsize',fgca)

    G = [repmat({'Div'}, numel(parsDiv), 1); repmat({'PRCR'}, numel(parsPRCR), 1); repmat({'NR'}, numel(parsNR), 1)];

    pvals(ii) = anova1([parsDiv, parsPRCR, parsNR], G, 'off'); % ANOVA test between groups
end


%% Plot ANOVA test results
ids_nonan = find(~isnan(pvals));

figure(28)
clf;
hold on
plot(pvals(ids_nonan),'linestyle','none','marker','o','MarkerFaceColor','blue','markersize',15)
yline(0.05, 'k','linewidth',3,'linestyle',':')
ylabel('p')
xticks(1:length(ids_nonan))
xlim([.5,21.5])
xticklabels(pnames(ids_nonan))
title('ANOVA results')
grid on
set(gca,'fontsize',fgca)

[vals,ids]=sort(pvals);


