%% Exponential noise
function [X_stage,U_stage,V_stage]=Exponential_noise(NoiseLevel,V,U,X)
rng('shuffle') 
E_Noise1=exprnd(NoiseLevel,size(V));
V_noise=V.*(1.+E_Noise1);
E_Noise2=exprnd(NoiseLevel,size(U));
U_noise=U.*(1.+E_Noise2);
E_Noise3=exprnd(NoiseLevel,size(X));
X_noise=X.*(1.+E_Noise3);

Stage=[ones(1,50),ones(1,50)*2];
X_stage=[X_noise;Stage;1:100];
U_stage=[U_noise;Stage;1:100];
V_stage=[V_noise;Stage;1:100];
rand_index=randperm(100);
X_stage=X_stage(:,rand_index);
U_stage=U_stage(:,rand_index);
V_stage=V_stage(:,rand_index);

Stage1x=find(X_stage(size(X_stage,1)-1,:)==1);
Stage2x=find(X_stage(size(X_stage,1)-1,:)==2);
Stage_newx=[Stage1x,Stage2x];
X_stage_new=X_stage(:,Stage_newx);

Stage1u=find(U_stage(size(U_stage,1)-1,:)==1);
Stage2u=find(U_stage(size(U_stage,1)-1,:)==2);
Stage_newu=[Stage1u,Stage2u];
U_stage_new=U_stage(:,Stage_newu);

Stage1v=find(V_stage(size(V_stage,1)-1,:)==1);
Stage2v=find(V_stage(size(V_stage,1)-1,:)==2);
Stage_newv=[Stage1v,Stage2v];
V_stage_new=V_stage(:,Stage_newv);