clear
load('DPP.mat');
X1=xlsread('TF_smooth.xlsx');
X = X1(((end-19):end),:);
Y1=xlsread('RBP_smooth.xlsx');
Y = Y1(((end-19):end),:);
Z=xlsread('CD44_smooth.xlsx');
%% TF-TF network in the epithelial-mesenchymal state
[Para_Post_pdf1,S1,AM1,S_new1]=ODE_BayesianLasso(X,DPP);
%% RBP-TF network in the epithelial-mesenchymal state
[Para_Post_pdf2,S2,AM2,S_new2]=ODE_BayesianLasso_new1(Y,X,DPP);
%% AS-RBP network in the epithelial-mesenchymal state
[Para_Post_pdf3,S3,AM3,S_new3]=ODE_BayesianLasso_new2(Z,Y,DPP);