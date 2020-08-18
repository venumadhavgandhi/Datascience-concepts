# Loading wines data#######
input <- read.csv(file.choose())
View(input)
#mydata <- input[,c(1,3:8)]
#View(mydata)
## the first column in mydata has type of wine --keep aside
data <- input[,-1]
attach(data)
View(data)
?princomp
pcaObj<-princomp(data, cor = TRUE, scores = TRUE, covmat = NULL)

str(pcaObj)
summary(pcaObj)
##Importance of components:
##  Comp.1    Comp.2    Comp.3    Comp.4     Comp.5     Comp.6     Comp.7
##Standard deviation     2.1692972 1.5801816 1.2025273 0.9586313 0.92370351 0.80103498 0.74231281
##Proportion of Variance 0.3619885 0.1920749 0.1112363 0.0706903 0.06563294 0.04935823 0.04238679
##Cumulative Proportion  0.3619885 0.5540634 0.6652997 0.7359900 0.80162293 0.85098116 0.89336795
##Comp.8     Comp.9    Comp.10    Comp.11    Comp.12     Comp.13
##Standard deviation     0.59033665 0.53747553 0.50090167 0.47517222 0.41081655 0.321524394
##Proportion of Variance 0.02680749 0.02222153 0.01930019 0.01736836 0.01298233 0.007952149
##Cumulative Proportion  0.92017544 0.94239698 0.96169717 0.97906553 0.99204785 1.000000000

loadings(pcaObj)

plot(pcaObj) # graph showing importance of principal components 

biplot(pcaObj)

plot(cumsum(pcaObj$sdev*pcaObj$sdev)*100/(sum(pcaObj$sdev*pcaObj$sdev)),type="b")
###
cumsum(pcaObj$sdev*pcaObj$sdev)*100/(sum(pcaObj$sdev*pcaObj$sdev))
#Comp.1    Comp.2    Comp.3    Comp.4    Comp.5    Comp.6    Comp.7    Comp.8    Comp.9 
#36.19885  55.40634  66.52997  73.59900  80.16229  85.09812  89.33680  92.01754  94.23970 
#Comp.10   Comp.11   Comp.12   Comp.13 
#96.16972  97.90655  99.20479 100.00000 
### Till 7th PCA - it is covering 90% of data
pcaObj$scores
pcaObj$scores[,1:3]

# Top 3 pca scores 
final<-cbind(input[,1],pcaObj$scores[,1:12])
View(final)
write.csv(final, file="PCA_CUT_data.csv")
getwd()
normalized_data <- final[,-1]
View(normalized_data)
#normalized_data <- scale(data)
d <- dist(normalized_data, method = "euclidean")
fit <- hclust(d, method="complete")
######Dendrogram##########
plot(fit, hang=-1)
#####Elbow Ploting#####
wss = (nrow(normalized_data)-1)*sum(apply(normalized_data, 2, var))		 # Determine number of clusters by scree-plot
for (i in 1:8) wss[i] = sum(kmeans(normalized_data, centers=i)$withinss)
plot(1:8, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")
####as per my analysis k = 3 will be better.
install.packages("kselection")
library(kselection)
k <- kselection(normalized_data, k_threshold = 0.9, max_centers=10)
k
###its is giving k =3
##### K menas ######
km <- kmeans(normalized_data,2)
str(km)
##$ tot.withinss: num 398
##$ betweenss   : num 133
km <- kmeans(normalized_data,3)
str(km)
###as per my analyis k =3 will be good.
### As per the standards betweenss should be less and tot.withinss should be more.
install.packages("animation")
library(animation)
km <- kmeans.ani(normalized_data, 2)
km$centers
#Comp.1     Comp.2     Comp.3
#[1,] -0.01266777  0.6968272  0.1365931
#[2,]  0.01909086 -1.0501481 -0.2058516
km <- kmeans.ani(normalized_data, 3)
km$centers
#Comp.1     Comp.2     Comp.3
#[1,]  1.01825082  0.4579227  0.3955366
#[2,]  0.02750377 -1.0146273 -0.5673448
#[3,] -1.22385451  0.6703832  0.2116878
####going k =3 
rect.hclust(fit,plot(fit,hang=-1),k=3,border="red")
groups <- cutree(fit, k=3)
table(groups)
#groups
#1   2   3 
#160  15   3 
membership<-as.matrix(groups)
final <- data.frame(membership,data)
write.csv(final, file="PCA_Cluster_data.csv")
getwd()