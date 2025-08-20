function [Data_smoothx,Data_smoothy,Data_smoothz,PD,DPP]=Pseudotime_Inference(X,Y,Z)
R=size(X);
datax=X(1:R(1)-2,:)';
R1=size(Y);
datay=Y(1:R1(1)-2,:)';
R2=size(Z);
dataz=Z(1:R2(1)-2,:)';

grade=X(R(1)-1,:);
W=zeros(length(grade),length(grade));
for i=1:length(grade)
    for j=1:length(grade)
    W(i,j)=1+abs(grade(i)-grade(j));
    end
end
k=3;
[P,phi0]=T_loc(datax,k,W);
Q=dpt_input(P,phi0);

Ind_max=find(grade==max(grade));
rn=Ind_max(randperm(numel(Ind_max),1));
drn=dpt_to_root(Q,rn);
[~,rr_123]=sort(drn,'descend');
    for i=1:length(rr_123)
        if grade(rr_123(i))==min(grade)
           s=rr_123(i);
           break
        end
    end 
PD=dpt_to_root(Q,s)';
[valT,indT]=sort(PD);

smoothL=10^(floor(log10(R(2)))-1);
g=1;
g_smooth=ksmooth(datax(indT,g),smoothL);
Data_smoothx=zeros(size(g_smooth,1),size(datax,2));
for i=1:size(datax,2)
Data_smoothx(:,i)=ksmooth(datax(indT,i),smoothL);
end
Data_smoothx=Data_smoothx';
DPP=[smoothL/2+1:size(X,2)-smoothL/2]/size(X,2); 
Data_smoothx=reshape(Data_smoothx,size(datax,2),length(DPP));

Data_smoothy=zeros(size(g_smooth,1),size(datay,2));
for i=1:size(datay,2)
Data_smoothy(:,i)=ksmooth(datay(indT,i),smoothL);
end
Data_smoothy=Data_smoothy';
Data_smoothy=reshape(Data_smoothy,size(datay,2),length(DPP));

Data_smoothz=zeros(size(g_smooth,1),size(dataz,2));
for i=1:size(dataz,2)
Data_smoothz(:,i)=ksmooth(dataz(indT,i),smoothL);
end
Data_smoothz=Data_smoothz';
Data_smoothz=reshape(Data_smoothz,size(dataz,2),length(DPP));

figure,
hold on, plot(DPP,Data_smoothx(1,:),'-','color','r','LineWidth',6)
hold on, plot(DPP,Data_smoothx(2,:),'-','color','b','LineWidth',6)
set(gca,'FontSize',15);
set(gca,'xtick',[0:0.2:1]);
xlabel('Inferred pseudo-progression','FontSize',20);
ylabel('TF expression','FontSize',20);
title('Recovered TF','FontSize',20,'FontWeight', 'bold');
Leg=legend('TF1','TF2','Location','NorthEastOutside','Box','off');


figure,
hold on, plot(DPP,Data_smoothy(1,:),'-','color',[1 0.5 0.5],'LineWidth',6)
hold on, plot(DPP,Data_smoothy(2,:),'-','color',[0.3 0.5 0.8],'LineWidth',6)
hold on, plot(DPP,Data_smoothy(3,:),'-','color',[0.8 0.3 0.5],'LineWidth',6)
set(gca,'FontSize',15);
set(gca,'xtick',[0:0.2:1]);
xlabel('Inferred pseudo-progression','FontSize',20);
ylabel('RBP expression','FontSize',20);
title('Recovered RBP','FontSize',20,'FontWeight', 'bold');
Leg=legend('RBP1','RBP2','RBP3','Location','NorthEastOutside','Box','off');

figure,
hold on, plot(DPP,Data_smoothz(1,:),'-','color',[0.5 0.6 0.5],'LineWidth',6)
hold on, plot(DPP,Data_smoothz(2,:),'-','color',[0.8 0.5 1],'LineWidth',6)
hold on, plot(DPP,Data_smoothz(3,:),'-','color',[0.8 0.3 0.5],'LineWidth',6)
hold on, plot(DPP,Data_smoothz(4,:),'-','color',[0.8 0.8 0.5],'LineWidth',6)
hold on, plot(DPP,Data_smoothz(5,:),'-','color',[0.5 1 0.8],'LineWidth',6)
set(gca,'FontSize',15);
set(gca,'xtick',[0:0.2:1]);
xlabel('Inferred pseudo-progression','FontSize',20);
ylabel('AS expression','FontSize',20);
title('Recovered AS','FontSize',20,'FontWeight', 'bold');
Leg=legend('AS1','AS2','AS3','AS4','AS5','Location','NorthEastOutside','Box','off');


[RHO,PVAL]=corr(X(end,:)',PD,'type','Spearman');
figure,
scatter(X(end,:)/max(X(end,:)),PD/max(PD),40,PD/max(PD),'fill')
set(gca,'FontSize',15)
xlabel('Real progression','FontSize',20);
ylabel('Inferred pseudo-progression','FontSize',20);
colorbar;
hold on, plot(0:0.01:1,0:0.01:1,'-.','Color',[0.5,0.5,0.5]);
title(['rho = ',num2str(RHO)],'FontWeight', 'bold');

