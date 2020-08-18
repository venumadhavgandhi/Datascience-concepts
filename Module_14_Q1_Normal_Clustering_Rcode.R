mydata <- read.csv(file.choose())
data <- mydata[,-1]
View(data)
####While doing EDA we can to know there are few outliers /influential observations are there
####Normalized the data###
normalized_data <- scale(data)
attach(normalized_data)
View(normalized_data)
d <- dist(normalized_data, method = "euclidean")
fit <- hclust(d, method="complete")
######Dendrogram##########
plot(fit, hang=-1)
##### finding  the best k vlaue by using different options
#####Elbow Ploting#####
wss = (nrow(normalized_data)-1)*sum(apply(normalized_data, 2, var))		 # Determine number of clusters by scree-plot
for (i in 1:8) wss[i] = sum(kmeans(normalized_data, centers=i)$withinss)
plot(1:8, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")
####as per my analysis k = 2 will be better.
#### k-selection technique
install.packages("kselection")
library(kselection)
k <- kselection(normalized_data, k_threshold = 0.9, max_centers=10)
k
####it is showing k is 2####
##### K menas ######
km <- kmeans(normalized_data,2)
str(km)
##$ tot.withinss: num 1649
##$ betweenss   : num 652
km <- kmeans(normalized_data,3)
str(km)
##$ tot.withinss: num 1271
##$ betweenss   : num 1030
### In the cluster 3 , there will no big different in tot.withinss and betweenss.
## Cluster 2 will be good.
### As per the standards betweenss should be less and tot.withinss should be more.
install.packages("animation")
library(animation)
km <- kmeans.ani(normalized_data, 2)
km$centers
#Alcohol      Malic         Ash Alcalinity   Magnesium    Phenols Flavanoids
#[1,] -0.14198337  0.5516984  0.11691415  0.4586877 -0.13968818 -0.9297307 -1.0085898
#[2,]  0.09421326 -0.3660803 -0.07757855 -0.3043629  0.09269029  0.6169241  0.6692512
#Nonflavanoids Proanthocyanins      Color        Hue   Dilution    Proline
##[1,]     0.7354270      -0.7225798  0.4174139 -0.7285240 -1.0194476 -0.4846682
#[2,]    -0.4879936       0.4794688 -0.2769756  0.4834131  0.6764559  0.3216023
km <- kmeans.ani(normalized_data, 3)
km$centers
#Alcohol      Malic        Ash Alcalinity   Magnesium    Phenols  Flavanoids Nonflavanoids
##[1,]  0.7289366 -0.3582601  0.2787311 -0.5692103  0.59912090  0.8675344  0.92820762    -0.6073383
#[2,] -0.9347364 -0.3260554 -0.4976119  0.1550979 -0.60753138 -0.1584157 -0.02881868     0.0913746
#[3,]  0.1860184  0.9024258  0.2485092  0.5820616 -0.05049296 -0.9857762 -1.23271740     0.7148253
#Proanthocyanins      Color        Hue   Dilution    Proline
#[1,]      0.60784783  0.1066664  0.4989383  0.7481093  1.0235725
#[2,]     -0.06610251 -0.8943035  0.3996867  0.2173020 -0.8066057
#[3,]     -0.74749896  0.9857177 -1.1879477 -1.2978785 -0.3789756
###Hence it is satisfying in the Cluster 3.
rect.hclust(fit,plot(fit,hang=-1),k=3,border="red")
groups <- cutree(fit, k=3)
table(groups)
#1  2  3 
#69 58 51 
membership<-as.matrix(groups)
final <- data.frame(membership,mydata)
write.csv(final, file="Normal_Cluster.csv")
getwd()


