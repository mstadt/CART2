% Determine if VP CART cells diverge
% or go to 0
date_str = '09-Apr-2024';
cell_dose = 100e6;

N = 1e4; % N_VP
ids_diverge = []; % save ids that diverge
ids_zero = [];  % save ids that go to 0

for ii = 1:N
    fname = strcat('./VPsims/',...
                            date_str,...
                            '_VPnum-', num2str(ii),...
                            '_dose-', num2str(cell_dose),...
                            '.mat');
    dat = load(fname);
    T = dat.y(:,1) + dat.y(:,2) + dat.y(:,3) + dat.y(:,4);

    if T(end) > 0.1e30
        ids_diverge = [ids_diverge; ii];
    elseif T(end) < 5e-20
        ids_zero = [ids_zero; ii];
    end

end

fprintf('length of ids_diverge: %i \n', length(ids_diverge))
fprintf('percent ids_diverge: %0.3f \n', length(ids_diverge) / N * 100)
fprintf('length of ids_zero: %i \n', length(ids_zero))
fprintf('percent ids_zero: %0.3f \n', length(ids_zero) / N * 100)