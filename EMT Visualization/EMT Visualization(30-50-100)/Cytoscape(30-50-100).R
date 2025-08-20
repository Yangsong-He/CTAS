#设置工作空间
setwd("C:/Users/a/Desktop/data/EMT_data+code/data+code/Network Construct/EMT Visualization/EMT Visualization(30-50-100)")

## EMT dataset
### E_M whole network
AM_E_M <- read.csv('Matrix(30-50-100).csv',header = F)
NodeID_EMT <- read.csv('NodeID(30-50-100).csv',header = F)
NodeID_EMT <- unique(unlist(NodeID_EMT))

#定义函数
Cytoscape_Reformat <- function(AM, NodeID) {
  # AM - 邻接矩阵
  # NodeID - 邻接矩阵中基因的ID或符号
  
  # 初始化矩阵C来存储边信息
  # 边的数量是AM中非零元素的数量
  num_edges <- sum(AM != 0)
  C <- matrix(NA, nrow = num_edges, ncol = 3)
  
  row <- 1  # 初始化矩阵C的行计数器
  
  # 迭代邻接矩阵中的每个元素
  for (i in seq_along(NodeID)) {
    for (j in seq_along(NodeID)) {
      if (AM[j, i] != 0) {  # 注意是AM[j, i]，不是AM[i, j]
        C[row, 1] <- NodeID[i]  # 源节点
        C[row, 3] <- NodeID[j]  # 目标节点
        C[row, 2] <- AM[j, i]   # 边的权重
        row <- row + 1
      }
    }
  }
  
  return(C)
}

#调用函数
C_E_M <- Cytoscape_Reformat(AM_E_M,NodeID_EMT)
write.table(C_E_M, file="Cytoscape_Network(30-50-100).txt", quote=F, row.names=F, col.names=F, sep="\t")

### Network analysis
####### Calculating hub score
install.packages("igraph") 
install.packages("gtools") 
install.packages("gplots") 
library(igraph)
library(gtools) 
library(gplots) 
### E_M
Net_E_M<-as.data.frame(cbind(as.character(C_E_M[,1]),as.character(C_E_M[,3]),C_E_M[,2]))  # Input data for R analysis, data.frame
net<-graph_from_data_frame(Net_E_M, directed = T, vertices = NULL) 
AM<-as_adjacency_matrix(net)

AM<-AM_E_M[V(net),V(net)]
AM<-abs(AM)
dim(AM)
EG1<-eigen(AM*t(AM))
which(EG1$values==max(EG1$values))
hs<-EG1$vectors[,1]
names(hs)<-rownames(as.matrix(V(net)))
sort(hs,decreasing = T)




