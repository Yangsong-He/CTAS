A=xlsread('Coefficient Matrix_A.xlsx');
B=xlsread('Coefficient Matrix_B.xlsx');
C=xlsread('Coefficient Matrix_C.xlsx');
E=xlsread('Coefficient Matrix_E.xlsx');
G=xlsread('Coefficient Matrix_G.xlsx');
D1=xlsread('Coefficient degradation_1.xlsx');
D2=xlsread('Coefficient degradation_2.xlsx');
D3=xlsread('Coefficient degradation_3.xlsx');

% TF synthetic data
TimeLength=100;
V0=ones(1,size(G,1));
V=zeros(size(G,1),TimeLength);
V(:,1)=V0;
h=0.01;
for tt=1:TimeLength-1
       for i=1:size(G,1)
             f=0;
            for j=1:size(G,1)
            f=f+G(i,j)*V(j,tt)*V(i,tt);
            end
             V(i,tt+1)=V(i,tt)+(f-D3(i)*V(i,tt))*h;
        end
end

% RBP synthetic data
U0=ones(1,size(C,1));
U=zeros(size(C,1),TimeLength);
U(:,1)=U0;
for tt=1:TimeLength-1
       for i=1:size(C,1)
          U(i,tt+1)=U(i,tt)+(C(i,1)*U(i,tt)*U(1,tt)+C(i,2)*U(i,tt)*U(2,tt)+C(i,3)*U(i,tt)*U(3,tt)+...
              E(i,1)*U(i,tt)*V(1,tt)+E(i,2)*U(i,tt)*V(2,tt)-D2(i)*U(i,tt))*h;
       end
end

% AS synthetic data
X0=ones(1,size(A,1));
X=zeros(size(A,1),TimeLength);
X(:,1)=X0;
for tt=1:TimeLength-1
       for i=1:size(A,1)
          X(i,tt+1)=X(i,tt)+(A(i,1)*X(i,tt)*X(1,tt)+A(i,2)*X(i,tt)*X(2,tt)+A(i,3)*X(i,tt)*X(3,tt)+A(i,4)*X(i,tt)*X(4,tt)+A(i,5)*X(i,tt)*X(5,tt)+...
              B(i,1)*X(i,tt)*U(1,tt)+B(i,2)*X(i,tt)*U(2,tt)+B(i,3)*X(i,tt)*U(3,tt)-D1(i)*X(i,tt))*h;
       end
end
          
figure,
hold on, plot(h:h:1,X(1,:),'-','color',[0.5 0.6 0.5],'LineWidth',6)
hold on, plot(h:h:1,X(2,:),'-','color',[0.8 0.5 1],'LineWidth',6)
hold on, plot(h:h:1,X(3,:),'-','color',[0.8 0.3 0.5],'LineWidth',6)
hold on, plot(h:h:1,X(4,:),'-','color',[0.8 0.8 0.5],'LineWidth',6)
hold on, plot(h:h:1,X(5,:),'-','color',[0.5 1 0.8],'LineWidth',6)

set(gca,'FontSize',15)
xlabel('True progression','FontSize',20);
ylabel('AS expression','FontSize',20)
legendlabel=legend('AS1','AS2','AS3','AS4','AS5','Location','NorthEastoutside','Box','off');
title('Simulated AS','FontSize',20,'FontWeight', 'bold');

figure,
hold on, plot(h:h:1,U(1,:),'-','color',[1 0.5 0.5],'LineWidth',6)
hold on, plot(h:h:1,U(2,:),'-','color',[0.3 0.5 0.8],'LineWidth',6)
hold on, plot(h:h:1,U(3,:),'-','color',[0.8 0.3 0.5],'LineWidth',6)
set(gca,'FontSize',15);
set(gca,'xtick',[0:0.2:1]);
xlabel('True progression','FontSize',20);
ylabel('RBP expression','FontSize',20)
legendlabel=legend('RBP1','RBP2','RBP3','Location','NorthEastoutside','Box','off');
title('Simulated RBP','FontSize',20,'FontWeight', 'bold');

figure,
hold on, plot(h:h:1,V(1,:),'-','color','r','LineWidth',6)
hold on, plot(h:h:1,V(2,:),'-','color','b','LineWidth',6)
set(gca,'FontSize',15);
set(gca,'xtick',[0:0.2:1]);
xlabel('True progression','FontSize',20);
ylabel('TF expression','FontSize',20)
legendlabel=legend('TF1','TF2','Location','NorthEastoutside','Box','off');
title('Simulated TF','FontSize',20,'FontWeight', 'bold');