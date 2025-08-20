close all
clear all
clc

tic 
global NoiseLevel
 
grid_noiselevel=0:5:30;
ind=1;
for NoiseLevel=grid_noiselevel  
    NoiseLevel
    for rep=1:100  %% repeat random simulation 100 times
        rep
    Synthetic_data;
    [X_stage,U_stage,V_stage]=Exponential_noise(NoiseLevel./100,V,U,X);
    [Data_smoothx,Data_smoothy,Data_smoothz,PD,DPP]=Pseudotime_Inference(V_stage,U_stage,X_stage);
    S_distance(ind,rep)=sqrt(sum((V_stage(end,:)/100-(PD'/max(PD'))).^2)/length(PD'));
    coeff_Spearman(ind,rep)=corr(V_stage(end,:)', PD , 'type' , 'Spearman');
    [Para_Post_pdf1,S1,AM1,S_new1]=ODE_BayesianLasso(Data_smoothx,DPP);
    [Para_Post_pdf2,S2,AM2,S_new2]=ODE_BayesianLasso_new1(Data_smoothy,Data_smoothx,DPP);
    [Para_Post_pdf3,S3,AM3,S_new3]=ODE_BayesianLasso_new2(Data_smoothz,Data_smoothy,DPP);
    
%% ROC calculation
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

    ROC_data=plot_roc(S_new, D~=0 ,1,1);
%% Evaluation Index 
    AUC_noise(ind,rep)=ROC_data.param.AROC;
    Accuracy_noise(ind,rep)=ROC_data.param.Accuracy;
    PPV_noise(ind,rep)=ROC_data.param.PPV;
    MCC_noise(ind,rep)=ROC_data.param.MCC;
    end
    ind=ind+1;
end
toc

figure,
errorbar(grid_noiselevel,mean(AUC_noise,2),std(AUC_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.3 0.8 0.5]);title('AUC for network inference'); axis([-1 31 0 1]); 
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(Accuracy_noise,2),std(Accuracy_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.3 0.8 0.5]); title('Accuracy for network inference'); axis([-1 31 0 1]);
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(PPV_noise,2),std(PPV_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.3 0.8 0.5]); title('PPV for network inference'); axis([-1 31 0 1]);
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(MCC_noise,2),std(MCC_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.3 0.8 0.5]); title('MCC for network inference'); axis([-1 31 0 1]); % axis([-1 31  0 max(mean(MCC_noise,2)+std(MCC_noise,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(S_distance,2),std(S_distance,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.1 0.3 1]);title('RMSE for progression inference'); axis([-1 31 0 0.5]); % axis([-1 31  0 max(mean(S_distance,2)+std(S_distance,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(coeff_Spearman,2),std(coeff_Spearman,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.1 0.3 1]);title('Spearman correlation for progression inference'); axis([-1 31 0 1]); % axis([-1 31  0 max(mean(S_distance,2)+std(S_distance,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);