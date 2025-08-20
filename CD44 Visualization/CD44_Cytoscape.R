#设置工作空间
setwd("C:/Users/a/Desktop/data/EMT_data+code/data+code/Network Construct/CD44 Visualization")

## CD44 dataset
### CD44 whole network
AM_CD44 <- read.csv('CD44_Matrix.csv',header = F)
NodeID_CD44 <- read.csv('NodeID_CD44.csv',header = F)
NodeID_CD44 <- unique(unlist(NodeID_CD44))

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
C_CD44 <- Cytoscape_Reformat(AM_CD44,NodeID_CD44)
write.table(C_CD44, file="Cytoscape_CD44_Network.txt", quote=F, row.names=F, col.names=F, sep="\t")

