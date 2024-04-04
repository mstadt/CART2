function y = zerolimit(x, flag)
    if flag == 1
        y = max(0, x); % Sets negative values to zero
    else
        y = x; % Does not change the value
    end
end