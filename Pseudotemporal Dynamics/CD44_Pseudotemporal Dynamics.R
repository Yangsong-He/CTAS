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

CD44_1<-as.numeric(AS_smoothed['CD44_1',])
CD44_2<-as.numeric(AS_smoothed['CD44_2',])
CD44_3<-as.numeric(AS_smoothed['CD44_3',])
CD44_4<-as.numeric(AS_smoothed['CD44_4',])
CD44_5<-as.numeric(AS_smoothed['CD44_5',])
CD44_6<-as.numeric(AS_smoothed['CD44_6',])
CD44_7<-as.numeric(AS_smoothed['CD44_7',])
CD44_8<-as.numeric(AS_smoothed['CD44_8',])
CD44_9<-as.numeric(AS_smoothed['CD44_9',])


###CD44_1
## test for expression changes between E and M
WT1<-wilcox.test(CD44_1[1:138],CD44_1[139:290],alternative="two.sided", paired=F)  #双尾检验
Pvalue1<-WT1$p.value
# 格式化p值（保留三位小数）
formatted_p_values1 <- format(Pvalue1, scientific = TRUE, digits = 4)
title_text1 <- paste("CD44_1", "   p=", formatted_p_values1, sep="")
#可视化
plot(T_smoothed,CD44_1, type = "l", col = "#377EB8", lwd = 3, xlim=c(0,1), ylim=c(0.98,1),xlab="Pseudotemporal progression",ylab="Expression",main= title_text1)
par(new=T)
lines(rep(T_smoothed[138],length(seq(-1,1.5,0.2))),seq(-1,1.5,0.2),lty=1 , col = "#808A87", lwd = 2)


