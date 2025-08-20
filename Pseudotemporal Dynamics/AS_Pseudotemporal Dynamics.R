library(gtools)
library(gplots) 
library(RColorBrewer)

setwd("C:/Users/a/Desktop/data/EMT_data+code/data+code/Pseudotemporal Dynamics/Pseudotemporal Dynamics(10-10-50)")

## Pseudotemporal Dynamics of the selected genes

######################## RBP-AS  #####################################
#读取时间数据
T_smoothed<-read.csv("DPP.csv",header = F) 
T_smoothed<-as.numeric(unlist(T_smoothed))

#读取AS数据
AS_smoothed<-read.csv("AS_smooth.csv",header = F)
AS_smoothed<-as.matrix(as.data.frame(AS_smoothed))
rownames(AS_smoothed)<-AS_smoothed[,1]
AS_smoothed<-AS_smoothed[,-1]

RABGAP1L_2<-as.numeric(AS_smoothed['RABGAP1L_2',])
NA_11<-as.numeric(AS_smoothed['NA_11',])
CCDC50<-as.numeric(AS_smoothed['CCDC50',])
OSBPL8<-as.numeric(AS_smoothed['OSBPL8',])
FGFR1_4<-as.numeric(AS_smoothed['FGFR1_4',])
GIT2_1<-as.numeric(AS_smoothed['GIT2_1',])
NF1_2<-as.numeric(AS_smoothed['NF1_2',])
MBNL2<-as.numeric(AS_smoothed['MBNL2',])
EPB41_5<-as.numeric(AS_smoothed['EPB41_5',])



###RABGAP1L_2
## test for expression changes between E and M
WT1<-wilcox.test(RABGAP1L_2[1:138],RABGAP1L_2[139:290],alternative="two.sided", paired=F)  #双尾检验
Pvalue1<-WT1$p.value
# 格式化p值（保留三位小数）
formatted_p_values1 <- format(Pvalue1, scientific = TRUE, digits = 4)
title_text1 <- paste("RABGAP1L_2", "   p=", formatted_p_values1, sep="")
#可视化
plot(T_smoothed,RABGAP1L_2, type = "l", col = "#984EA3", lwd = 3, xlim=c(0,1), ylim=c(0.2,1),xlab="Pseudotemporal progression",ylab="Expression",main= title_text1)
par(new=T)
lines(rep(T_smoothed[138],length(seq(-1,1.5,0.2))),seq(-1,1.5,0.2),lty=1 , col = "#808A87", lwd = 2)


