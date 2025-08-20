clear;
%% generated a set of synthetic cross-sectional expression data
Synthetic_data;
%% noise
NoiseLevel=input('Noise Level=');
[V_stage,U_stage,X_stage]=Exponential_noise(NoiseLevel,V,U,X);
%% pseudotime analysis
[Data_smoothx,Data_smoothy,Data_smoothz,PD,DPP]=Pseudotime_Inference(V_stage,U_stage,X_stage);
%% Bayesian Lasso method to estimate parameters
[Para_Post_pdf1,S1,AM1,S_new1]=ODE_BayesianLasso(Data_smoothx,DPP);
[Para_Post_pdf2,S2,AM2,S_new2]=ODE_BayesianLasso_new1(Data_smoothy,Data_smoothx,DPP);
[Para_Post_pdf3,S3,AM3,S_new3]=ODE_BayesianLasso_new2(Data_smoothz,Data_smoothy,DPP);
%% Accuracy of the dynamical systems inference evaluated using the AUC of ROC
S_new1=reshape(S_new1,1,size(S_new1,1)*size(S_new1,2));
S_new2=reshape(S_new2,1,size(S_new2,1)*size(S_new2,2));
S_new3=reshape(S_new3,1,size(S_new3,1)*size(S_new3,2));
S_new=[S_new1,S_new2,S_new3];
A=reshape(A,1,size(A,1)*size(A,2));
B=reshape(B,1,size(B,1)*size(B,2));
C=reshape(C,1,size(C,1)*size(C,2));
E=reshape(E,1,size(E,1)*size(E,2));
G=reshape(G,1,size(G,1)*size(G,2));
D=[G,C,E,A,B];
figure,
   ROC_data=plot_roc(S_new, D~=0,1,1);
