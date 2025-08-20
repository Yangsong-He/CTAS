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
EMT_C = xlsread('AdjacentMatrix_E_M_2.xlsx');

[x2,y2]=find(EMT_C~=0);
D2=[y2 x2];
network2 = D2;
N2=length(EMT_C);
nodes2 = (1:N2)';
constrained_nodes2  = nodes2(1:30);
targets2 = [86;91;93;98;101;106;109;111;114;118;119;121;128;129;134;141;151;152;154;157;159;162;164;175;176;177;178];

z2 = network2;
B2 = constrained_nodes2;
C2 =targets2;

[All_predict_driver2,Control_capacity_drivers2] = constrained_target_control( z2,B2,C2 );