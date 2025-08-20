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
%% EMT data CTC control
EMT_C = xlsread('AdjacentMatrix_E_M_1.xlsx');

[x,y]=find(EMT_C~=0);
D=[y x];
network = D;
N=length(EMT_C);
nodes = (1:N)';
constrained_nodes  = [1;5;6;7;8;9];
targets = [22;27;30;37;40;55;58;66;68];

z = network;
B = constrained_nodes;
C =targets;

[All_predict_driver,Control_capacity_drivers] = constrained_target_control( z,B,C);