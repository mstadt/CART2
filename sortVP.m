% Determine if VP CART cells diverge
% or go to 0
date_str = '11-Apr-2024';
cell_dose = 100e6;
notes = 'minpars'
sf = 1/2e6; % scaling factor

N = 1e3; % N_VP
ids_diverge = []; % save ids that diverge
ids_zero = [];  % save ids that go to 0
%ids_CR = [];
ids_PRCR = []; % save ids that may be PR or CR
ids_NR = []; % save ids that may be NR
ids_Bdec = []; % save ids that B decreases
ids_else = []; % extra ids
for ii = 1:N
    if mod(ii, 1000) == 0
        disp(ii)
    end
    fname = strcat('./VPsims/',...
                            date_str,...
                            '_VPnum-', num2str(ii),...
                            '_dose-', num2str(cell_dose),...
                            '_notes-', notes,...
                            '.mat');
    dat = load(fname);
    T = dat.y(:,1) + dat.y(:,2) + dat.y(:,3) + dat.y(:,4);
    B = dat.y(:,5); % tumor vals

    if T(end) > 0.1e25 % T cells diverge
        ids_diverge = [ids_diverge; ii];
%     elseif and(max(T)*sf < 1e2, T(end)*sf > 1e0)
%         ids_CR = [ids_CR; ii];
    elseif T(end) < 5e-20 % T cells = 0
        ids_zero = [ids_zero; ii];
    elseif and(max(T) > 10e6, B(end) < B(1)) % PR or CR
        ids_PRCR = [ids_PRCR; ii];
    elseif B(end) >= 9e9 % NR % NOTE: B(1) = 1e10;
        ids_NR = [ids_NR; ii];
    elseif B(end) < B(1)
        ids_Bdec = [ids_Bdec; ii];
    else 
        ids_else = [ids_else; ii];
    end

end

fprintf('length of ids_diverge: %i \n', length(ids_diverge))
%fprintf('percent ids_diverge: %0.3f \n', length(ids_diverge) / N * 100)
fprintf('length of ids_zero: %i \n', length(ids_zero))
%fprintf('percent ids_zero: %0.3f \n', length(ids_zero) / N * 100)
fprintf('length of ids_PRCR: %i \n', length(ids_PRCR))
fprintf('length of ids_NR: %i \n', length(ids_NR))
fprintf('length of ids_Bdec: %i \n', length(ids_Bdec))

fprintf('length of ids_else: %i \n', length(ids_else))