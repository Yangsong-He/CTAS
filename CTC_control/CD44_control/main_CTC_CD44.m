clc,clear
%**************Input the information of network****
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
%% CD44 data CTC control
CD44 = xlsread('AdjacentMatrix_CD44(100-100-7).xlsx');
[x,y]=find(CD44~=0);
D=[y x];
network = D;
N=length(CD44);
nodes = (1:N)';
constrained_nodes  = nodes(81:100);
targets = nodes(end-6:end);

z = network;
B = constrained_nodes;
C =targets;

[All_predict_driver,Control_capacity_drivers] = constrained_target_control( z,B,C);