function dydt = mod_eqns(t,y,params)
% Model equations for Kirouac et al., 2023

%% set variable names
Tm = y(1); % T memory
Te1 = y(2); % T effector 1
Te2 = y(3); % T effector 2
Tx = y(4); % exhausted T cells
B = y(5); % CD19 B cells
Ba = y(6); % Bcell antigen
dose = y(7); % dose
doseX = y(8); % doseX

%% Check for diverging values
T = Tm + Te1 + Te2 + Tx; % total CART
if T > 1e30 % cut off for CART
    flag = 0;
elseif T < 1e-15
    if t > 100
        flag = 0;
    else
        flag = 1;
    end
else
    flag = 1;
end

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
dydt = zeros(length(y),1);

if flag
    % d(Tm)/dt
    dydt(1) = ((um*f_max*(1-HillEQ(Ba,km,B50))*zerolimit(Tm,1)) ...
                - (um*(1-f_max*(1-HillEQ(Ba,km,B50)))*zerolimit(Tm,1)) ...
                - (dm*zerolimit(Tm,1)) + (fractionTm*doseX)...
                + (rm*(1-HillEQ(Ba,kr,B50))*Te2));
    
    % d(Te1)/dt
    dydt(2) = (2*(um*(1-f_max*(1-HillEQ(Ba,km,B50)))*zerolimit(Tm,1))...
                - (ue*HillEQ(Ba,ke,B50)*zerolimit(Te1,1)) ...
                - (de1*zerolimit(Te1,1)) ...
                + (fractionTe1*doseX));
    
    % d(Te2)/dt
    dydt(3) = ((ue*HillEQ(Ba,ke,B50)*zerolimit(Te1,0)*2^N)...
                - (kex*HillEQ(Ba,kx,B50)*zerolimit(Te2,1)) ...
                - (de2*zerolimit(Te2,1)) + (fractionTe2*doseX)...
                - (rm*(1-HillEQ(Ba,kr,B50))*Te2));
    
    % d(Tx)/dt
    dydt(4) = ((kex*HillEQ(Ba,kx,B50)*zerolimit(Te2,1))...
                - (dx*zerolimit(Tx,1)) + (fractionTx*doseX));
    
    % d(B)/dt
    dydt(5) = ((uB*zerolimit(B,1)*(1-B/Bmax))...
                - (k_kill*B*HillEQ(zerolimit(Te2,1),kt,TK50)));
    
    % d(Ba)/dt
    dydt(6) = ((kb1*B) - (kb2*Ba));
    
    % d(dose)/dt
    dydt(7) = -(f_loss*dose) - (1*dose);
    
    % d(doseX)/dt
    dydt(8) = -(fractionTm*doseX) ...
                - (fractionTe1*doseX)...
                - (fractionTe2*doseX) ...
                - (fractionTx*doseX)...
                + (1*dose);
end


end