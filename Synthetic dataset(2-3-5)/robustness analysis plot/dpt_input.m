function M=dpt_input(P,phi0)
n = size(P,1);
M = pinv(eye(n)-P+phi0*phi0')-eye(n);
