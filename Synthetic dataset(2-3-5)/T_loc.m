function [P,phi0]=T_loc(data,k,W)
tic
n1=size(data,1);
d2=pdist(data,'euclidean').^2;
d2=squareform(d2);

[idnn_s,dists]=knnsearch(data,data,'K',k);
sigma=dists(:,k);

S2=bsxfun(@plus,sigma.^2,sigma.^2');  
Sw=S2./W;
S=exp(-d2./Sw);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D1=sum(S,2);

D=bsxfun(@times,reshape(D1,1,n1),reshape(D1,n1,1)).^1;

H=S./D;
H(d2==0)=0; 

E=diag(sum(H,2));
P=E^(-0.5)*H*E^(-0.5);
[V,O]=eig(P);
phi0=V(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('%.04f', toc/60);
    

    
