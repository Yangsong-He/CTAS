%% Exponential noise
function [V_stage,U_stage,X_stage]=Exponential_noise(NoiseLevel,V,U,X)
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

figure,
hold on, plot(X_stage_new(1,:),'o','color',[0.5 0.6 0.5],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.5 0.6 0.5])
hold on, plot(X_stage_new(2,:),'o','color',[0.8 0.5 1],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.8 0.5 1])
hold on, plot(X_stage_new(3,:),'o','color',[0.8 0.3 0.5],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.8 0.3 0.5])
hold on, plot(X_stage_new(4,:),'o','color',[0.8 0.8 0.5],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.8 0.8 0.5])
hold on, plot(X_stage_new(5,:),'o','color',[0.5 1 0.8],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.5 1 0.8])
hold on, plot(1:50,zeros(1,50)+min(min(X_stage(1:3,:)))-1,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)+min(min(X_stage(1:3,:)))-1,'-','color',[0.4 0.4 0.4],'LineWidth',8);
hold on, plot(1:50,zeros(1,50)-2,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)-2,'-','color',[0.4 0.4 0.4],'LineWidth',8);
set(gca,'FontSize',15)
xlabel('Randomized sample ID','FontSize',20);
ylabel('AS expression','FontSize',20)
set(gca,'xtick',[22.5:50:100]);
set(gca,'xticklabel',{'S1','S2'});
Leg=legend('AS1','AS2','AS3','AS4','AS5','Location','NorthEastOutside') 
set(Leg,'Box','off')
axis([0 100 -1 8])


figure,
hold on, plot(U_stage_new(1,:),'o','color',[1 0.5 0.5],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[1 0.5 0.5])
hold on, plot(U_stage_new(2,:),'o','color',[0.3 0.5 0.8],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.3 0.5 0.8])
hold on, plot(U_stage_new(3,:),'o','color',[0.8 0.3 0.5],'LineWidth',6,'MarkerSize',4,'MarkerFaceColor',[0.8 0.3 0.5])
hold on, plot(1:50,zeros(1,50)+min(min(U_stage(1:3,:)))-1,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)+min(min(U_stage(1:3,:)))-1,'-','color',[0.4 0.4 0.4],'LineWidth',8);
hold on, plot(1:50,zeros(1,50)-2,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)-2,'-','color',[0.4 0.4 0.4],'LineWidth',8);
set(gca,'FontSize',15)
xlabel('Randomized sample ID','FontSize',20);
ylabel('RBP expression','FontSize',20)
set(gca,'xtick',[22.5:50:100]);
set(gca,'xticklabel',{'S1','S2'});
Leg=legend('RBP1','RBP2','RBP3','Location','NorthEastOutside') 
set(Leg,'Box','off')
axis([0 100 -1 8])


figure,
hold on, plot(V_stage_new(1,:),'o','color','r','LineWidth',6,'MarkerSize',4,'MarkerFaceColor','r')
hold on, plot(V_stage_new(2,:),'o','color','b','LineWidth',6,'MarkerSize',4,'MarkerFaceColor','b')
hold on, plot(1:50,zeros(1,50)+min(min(V_stage(1:3,:)))-1,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)+min(min(V_stage(1:3,:)))-1,'-','color',[0.4 0.4 0.4],'LineWidth',8);
hold on, plot(1:50,zeros(1,50)-2,'-','color',[0.75 0.75 0.75],'LineWidth',8);
hold on, plot(51:100,zeros(1,50)-2,'-','color',[0.4 0.4 0.4],'LineWidth',8);
set(gca,'FontSize',15)
xlabel('Randomized sample ID','FontSize',20);
ylabel('TF expression','FontSize',20)
set(gca,'xtick',[22.5:50:100]);
set(gca,'xticklabel',{'S1','S2'});
Leg=legend('TF1','TF2','Location','NorthEastOutside') 
set(Leg,'Box','off')
axis([0 100 -1 8])

