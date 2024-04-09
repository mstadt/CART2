% Analyze the parameters that have the largest PC1 coefficients
clear all;

% Get Kirouac2023 parameters
parsK2023 = load('./pars/pars_Kirouac2023.mat');
IC = load('./IC/ICbase_celldose-1e6.mat').IC;

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
lw = 4;

% Get example simulation for NR, CR, PR
pars_NR = parsK2023.pNR(:,1);
pars_PR = parsK2023.pPR(:,2);
pars_CR = parsK2023.pCR(:,5);

% Time span
t0 = 0;
tf = 365; % simulation time in days
tspan = [t0,tf];

options = odeset('RelTol',1e-4, 'AbsTol',1e-7); % ODE solver settings

% Run simulations
[tCR,yCR]=ode15s(@(t,y) mod_eqns(t,y,pars_CR),...
                            tspan, IC, options);
[tNR,yNR]=ode15s(@(t,y) mod_eqns(t,y,pars_NR),...
                            tspan, IC, options);
[tPR,yPR]=ode15s(@(t,y) mod_eqns(t,y,pars_PR),...
                            tspan, IC, options);
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
plot(tNR, T_NR*sf, 'linewidth',lw,'color',cNR)
plot(tCR, T_CR*sf, 'linewidth',lw,'color',cCR)
plot(tPR, T_PR*sf, 'linewidth',lw,'color',cPR)
legend('non-responder', 'complete responder', 'partial responder')

subplot(nr,nc,2)
plot(tNR, yNR(:,5)*sf, 'linewidth',lw,'color',cNR)
plot(tCR, yCR(:,5)*sf, 'linewidth',lw,'color',cCR)
plot(tPR, yPR(:,5)*sf, 'linewidth',lw,'color',cPR)
legend('non-responder', 'complete responder', 'partial responder')

