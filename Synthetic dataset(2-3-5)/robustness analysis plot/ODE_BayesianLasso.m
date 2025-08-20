function [Para_Post_pdf,S,AM,S_new]=ODE_BayesianLasso(Data_ordered,TimeSampled)
% Input:
% Data_ordered -- smoothed pseudo-progression TF expression data
% TimeSampled -- Time points associate with pseudo-progression gene expression data
% Output:
% Para_Post_pdf -- posterior distribution over the coefficients in the Equation(3)
% S --  a matrix saving the presence probability. 
% AM -- Adjacent matrix of the inferred network i.e., (g_pq) for the regulatory coefficient from TF q to TF p. 
%% data
Time=TimeSampled;
x = Data_ordered;  % original data 
Time=(Time-min(Time))/(max(Time)-min(Time)); % standardize
y=diff((x)')./diff(Time)';  % derivative term approximation
y=y';
x=x(:,1:end-1);
%% Calculate Post_pdf for each TF's parameters
Para_Post_pdf=cell(size(x,1));
for ind_gene=1:size(x,1)    
y_output=y(ind_gene,:);
x_input=[x',ones(size(x,2),1)].*x(ind_gene,:)';
x_input(:,ind_gene)=[];    
%% Bayesian Lasso
p=size(x,1);
PriorMdl = bayeslm(p,'ModelType','lasso','Intercept',false);  
ismissing = any(isnan(x),2);
n = sum(~ismissing); 
rng(3); % For reproducibility
Y_train=y_output;
X_train=x_input;
   
[EstMdl,Summary] = estimate(PriorMdl,X_train,Y_train,'Display',false);  
Para_Post_pdf{ind_gene}=EstMdl;  
end
%%  Calculate Confidence Interval
    alpha=0.01:0.01:1;
    CI_alpha=zeros(size(x,1),length(alpha),size(x,1)+1,2);
for i=1:size(x,1)
    Para_Post_pdf_each=Para_Post_pdf{i};
Summary = summarize(Para_Post_pdf_each);
Summary = Summary.MarginalDistributions;
    alpha=0.01:0.01:1;
    ind_alpha=1;
 for k_alpha=alpha
    MUCI = CI_Sun_Normal(Summary,k_alpha);  
    CI_alpha(i,ind_alpha,:,:)=MUCI;
    ind_alpha=ind_alpha+1;
 end
    size(CI_alpha);
end

S=ones(size(x,1),size(x,1));  
for i=1:size(x,1) 
    for k=length(alpha):-1:1
        CI_genei_alpha=reshape(CI_alpha(i,k,:,:),size(x,1)+1,2);
        for j=1:size(x,1)
             if CI_genei_alpha(j,1)<=0 & CI_genei_alpha(j,2)>=0                  
                 S(i,j)=min(S(i,j),1-alpha(k));  
             end        
       end

   end
end
%% Reform probability matrix for interation coefficients
   for i=1:size(Data_ordered,1)
        S_new(i,i)=0;
        S_new(i,setdiff(1:size(Data_ordered,1),i))=S(i,1:end-1);
   end
   S=S_new;  
 %% Output for TF network visualization
clear Act_Inh Act_Inh_strength
for i=1:size(S,1)
Summary = summarize(Para_Post_pdf{i});  
Summary = Summary.MarginalDistributions;
Act_Inh(i,:) = Summary.Mean(1:end-2);
Act_Inh_strength(i,i)=0;
Act_Inh_strength(i,setdiff(1:size(S,1),i))=Act_Inh(i,:);
end
% Adjacent matrix
AM=Act_Inh_strength.*(S>0.95);