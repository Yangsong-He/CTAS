function [All_predict_driver,Control_capacity_drivers] = constrained_target_control( z,B,C )
%functionï¿½ï¿½predict the driver nodes using constraied target controllability
%   input: z,the structure of network
%          B,the constrained control nodes set
%          C,target control nodes
%  Output1: All_predict_driver:
%          each element denotes the result in each markov sampling;
%           For each cell elemnt, the first colunm is the name of predicted driver nodes; the second colunm is the consensus module
%           The third colunm is the controlled target nodes
%  Output2: Control_capacity_drivers
%           the first colunm is the name of predicted driver nodes; the
%           second colunm is the frequency of driver nodes in Markov
%           sampling

%****************************set parameters of CTC****************************************************************
%Users can assigned the value of parameters,num_max and c
num_max=100;%the number of samplings 
c=0;%random Markov samplings
no_change_num_max=num_max;
%*****************************main part***************************************

NM=1;
ind_max=1;
num_iter=1;
no_change_num=1;

%random markov chain sampling,In the linking and dynamic graph, sampling
%the maximum matchings
[ TK0,predict_driver0,omiga0,driver_module0,interesting_ind0] = Markov_chain_driver( z,B,C,NM );
predict_driver_gene_module=[];

B_fda=B;
if length(TK0)~=0
    

ind_max=1;num_iter=1;

while ind_max
    

  
  % Generate new Markov chain
  % Assume that the length of TK0 as the initial Markov chain is kï¿½ï¿½
  % Randomly choose a locateï¿½ï¿½replace the matched edges untill we generate the new markov chains
  % Noteï¿½ï¿½The right matched nodes is chosed from the targeted nodes in right 
  [ TK1,predict_driver1,omiga1,driver_module1 ] = New_Markov_chain_driver( z,B_fda,C,NM,TK0,interesting_ind0);
  
  %random accept the new state:c=0

  p=min(1,exp(-c*(omiga1-omiga0)));
  r=rand;
  if r<=p
 
       TK0=TK1; 
       predict_driver0=predict_driver1;
       omiga0=omiga1;
       driver_module0=driver_module1;
       
  end
  
  if r>p

       TK0=TK0; 
       predict_driver0=predict_driver0;
       omiga0=omiga0;
       driver_module0=driver_module0;

  end

   if num_iter>num_max
      ind_max=0;
   end
  
     All_TK{num_iter,1}=TK0;
     All_predict_driver{num_iter,1}=predict_driver0;
     All_omiga(num_iter,1)=omiga0;
     All_predict_driver{num_iter,1}=driver_module0;
  
    num_iter=num_iter+1
    
    
end

    

end



%%
%Obtain the information of Markov chain samplingï¿½ï¿½including the number of
%driver nodesï¿½ï¿½Impactand the corresponding consensus module
%Firstly obtain all the possible driver genes
[row_All_driver_module,~]=size(All_predict_driver);
poss_driver=[];
for i=1:row_All_driver_module
    
    intermid=cell2mat(All_predict_driver{i,1}(:,1));
    poss_driver=[poss_driver;intermid];
    
end

b=tabulate(poss_driver);
b(find(b(:,2)==0),:)=[];
f=b(:,2)./row_All_driver_module;
[c,d]=sort(f,'descend');

Control_capacity_drivers=[b(d,1) c];%Firstly obtain all the possible driver genes
%Then identify all the possible consensus module of the driver genes and
%its impact scores




end
