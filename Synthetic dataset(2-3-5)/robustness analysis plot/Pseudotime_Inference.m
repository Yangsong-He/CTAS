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