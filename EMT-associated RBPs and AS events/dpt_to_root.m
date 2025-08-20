function dpt=dpt_to_root(M,s)
% Finds dpt distance of all cells to the root cell

%s root cell(s)
%dpt=dpt distance to s 
%M= accumulated transition matrix

n=size(M,1);
dpt=zeros(1,n);
  
for x=1:n
        D2=(M(s,:)-M(x,:)).^2;  
        dpt(x)=sqrt(sum(D2));
end


