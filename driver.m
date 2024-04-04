clear all;

% Initial conditions
% NOTE: I got this from looking at the first row of the sim results
% in Kirouac code
Tm0 = 0;
Te10 = 0;
Te20 = 0;
Tx0 = 0;
B0 = 1; % start > 0 for tumor growth
Ba0 = 0;
%B0 = 2.271440561000000e+08; %2.2714e+08; %9.7317e+07; %9.7e7; % steady state B0 %1e10;
%Ba0 = 8.804326318471625e+08; %8.8043e+08; %3.7721e+08; %1e10;
dose0 = 0;
doseX0 = 0;

IC = [Tm0;Te10;Te20;Tx0;B0;Ba0;dose0;doseX0];


% Parameters
pars = load('./pars/pars_Kirouac2023.mat');
parsCR = pars.pCR;
parsNR = pars.pNR;
parsPR = pars.pPR;

% take first set of parameters for one simulation
params = parsCR(:,1); 


% Time span
t0 = 0;
tf = 5e3; % simulation time in days
tspan = [t0,tf];

% Dose level
cell_dose = 100e6;

%% Run simulation
options = odeset('RelTol',1e-4, 'AbsTol',1e-7); % ODE solver settings
[t,y]=ode15s(@(t,y) mod_eqns(t,y,params),...
                        tspan, IC, options);

%% Compute steady state
% IG = y(end,:)'; %IC; % initial guess
% opts_fsolve = optimoptions('fsolve','Display', 'iter',...
%                                 'MaxFunEvals', 1e6,...
%                                 'MaxIter', 1e6,...
%                                 'FunctionTolerance', 1e-16);
% [SSdat, residual, ...
%     exitflag, output] = fsolve(@(y) mod_eqns(0, y, params),...
%                                 IG, opts_fsolve);


%% Plot results
% fig specs
fgca=18;
cmap = parula(6);
c1 = cmap(3,:);
lw = 5;

xminmax = [0,tf];

disp('done')

% T cells
figure(1)
clf;
nr = 2; nc = 2;
subplot(nr,nc,1)
plot(t,zerolimit(y(:,1),1),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('Tm')
ymin = zerolimit(min(0, min(zerolimit(y(:,1),1)) - 1),1);
ymax = max(zerolimit(y(:,1),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)
%set(gca,'fontsize',fgca, 'YScale','log')

subplot(nr,nc,2)
plot(t,zerolimit(y(:,2),1),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('Te1')
ymin = zerolimit(min(0, min(zerolimit(y(:,2),1)) - 1),1);
ymax = max(zerolimit(y(:,2),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)
%set(gca,'fontsize',fgca, 'YScale','log')

subplot(nr,nc,3)
plot(t,zerolimit(y(:,3),1),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('Te2')
ymin = zerolimit(min(0, min(zerolimit(y(:,3),1)) - 1),1);
ymax = max(zerolimit(y(:,3),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)
%set(gca,'fontsize',fgca, 'YScale','log')

subplot(nr,nc,4)
plot(t,zerolimit(y(:,4),1),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('Tx')
ymin = zerolimit(min(0, min(zerolimit(y(:,4),1)) - 1),1);
ymax = max(zerolimit(y(:,4),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)
%set(gca,'fontsize',fgca, 'YScale','log')

% B cells
figure(2)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
plot(t,y(:,5),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('B')
ylim([0.01,max(y(:,5))])
xlim(xminmax)
set(gca,'fontsize',fgca, 'YScale','log')


subplot(nr,nc,2)
plot(t,y(:,6),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('Ba')
ymin = 0;
ymax = max(max(y(:,6)),1e10) ;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca, 'YScale','log')

% Dose
figure(3)
clf;
nr = 1; nc = 2;
subplot(nr,nc,1)
plot(t,y(:,7),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('dose')
ymin = zerolimit(min(0, min(zerolimit(y(:,7),1)) - 1),1);
ymax = max(zerolimit(y(:,7),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)

subplot(nr,nc,2)
plot(t,y(:,8),'linewidth',lw,'color',c1)
grid on
xlabel('t')
ylabel('doseX')
ymin = zerolimit(min(0, min(zerolimit(y(:,8),1)) - 1),1);
ymax = max(zerolimit(y(:,8),1)) + 1;
ylim([ymin,ymax])
xlim(xminmax)
set(gca,'fontsize',fgca)
