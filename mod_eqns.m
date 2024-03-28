function dydt = mod_eqns(t,y,params)
% Model equations for Kirouac et al., 2023
%% set variable names
Tx = y(1); % exhausted T cells
T = y(2);% total T cells
B = y(3); % CD19 B cells
Ba = y(4); % Bcell antigen
Tm = y(5); % T memory
Te1 = y(6); % T effector 1
Te2 = y(7); % T effector 2 (expanded)


% PK
%dose = y(8); % dose infused
%doseX = y(9); % remanant dose
%% set parameters
B50 = params(1); % Ba driving toggle switch
uB = params(2); % Bcell proliferation rate
k_kill = params(3); % rate of Tcell mediated Bcell killing
f_loss = params(4); % fraction of dose lost
TK50 = params(5); % Tcell conc EC50 driving Bcell killing
kt = params(6); % Hill exponent driving Bcell killing
kb1 = params(7); % Bcell antigen generation rate
kb2 = params(8); % Bcell antigen clearance rate
um = params(9); % T memory proliferation rate
km = params(10); % Hill coefficient self-renewal
f_max = params(11); % T memory max self-renewal
ke = params(12); % Hill coefficient proliferation control
ue = params(13); % T effectors proliferation rate
N = params(14); % division within Te2 compartment
kex = params(15); % T exhaustion rate
dm = params(16); % T memory death rate
de1 = params(17); % T effector 1 death rate
de2 = params(18); % T effector 2 death raate
dx = params(19); % T exhausted death rate
Bmax = params(20); % max tumor size
kx = params(21); % Hill coefficient exhaustion control
rm = params(22); % Tm regeration rate from Te2
kr = params(23); % Hill coefficient Tm regeneration
fractionTm = params(24); % fraction Tm
fractionTe1 = params(25); % fraction Te1
fractionTe2 = params(26); % fraction Te2
fractionTx = params(27); % fraction Tx


%% ODES
dydt = zeros(length(y));
% TODO: write the functions
end