function M = dpt_input(T, phi0)
n = size(T,1);
M = pinv(eye(n)-T+phi0*phi0')-eye(n);
