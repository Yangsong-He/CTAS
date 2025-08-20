 
function CI=CI_Sun_Normal(Summary,sig_level)
alpha=sig_level/2;
SEM = Summary.Std;     
ts = tinv([alpha  1-alpha],1e4-1);      
CI = Summary.Mean + ts.*SEM;                      % Confidence Intervals
CI = CI(1:size(CI,1),:);

