% Script for varying TK50 and seeing how it impacts the model results
clear all;

% Get results for varied TK50 ratios
minratio = 1e-3;
maxratio = 3;
nvals = 25;
TK50ratios = sort([linspace(minratio, maxratio, nvals), 1]);

par_num = 5; % TK50 parameter number
notes = 'widerrange';


%  Get baseline simulation for NR, CR, PR example patients
[Tbase, Ybase] = vary_res(1, -1); % No change
tNR = Tbase{1}; tPR = Tbase{2}; tCR = Tbase{3};
yNR = Ybase{1}; yPR = Ybase{2}; yCR = Ybase{3};
T_CR = yCR(:,1) + yCR(:,2) + yCR(:,3) + yCR(:,4);
T_NR = yNR(:,1) + yNR(:,2) + yNR(:,3) + yNR(:,4);
T_PR = yPR(:,1) + yPR(:,2) + yPR(:,3) + yPR(:,4);

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

disp('done. Use "plot_varyTK50.m" for analysis')

