mydata <- read.csv("E:/Data_Science_Okv/Datasets/new/Insurance Dataset.csv")
View(mydata)
####While doing EDA we can to know there are few outliers /influential observations are there
boxplot(mydata$Claims.made)
boxplot(mydata$Income)
boxplot(mydata$Premiums.Paid)
boxplot(mydata$Age)
boxplot(mydata$Days.to.Renew)
###deleting the 87th record which is influing a lot in the clustering.
data <-  mydata[-87,]
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
####it is showing k is10 2####
##### K menas ######
km <- kmeans(normalized_data,2)
str(km)
##$ tot.withinss: num 307
##$ betweenss   : num 183
##$ size        : int [1:2] 74 25
km <- kmeans(normalized_data,3)
str(km)
##$ tot.withinss: num 249
##$ betweenss   : num 241
##$ size        : int [1:3] 61 18 20

### In the cluster 3 , there will no big different in tot.withinss and betweenss.
## Cluster 2 will be good.
### As per the standards betweenss should be less and tot.withinss should be more.
install.packages("animation")
library(animation)
km <- kmeans.ani(normalized_data, 2)
km$centers
##Premiums.Paid        Age Days.to.Renew Claims.made     Income
##45     0.9644689  0.6604451     0.3354210   0.7881081  0.8962270
##16    -0.6008167 -0.4114248    -0.2089508  -0.4909526 -0.5583054
km <- kmeans.ani(normalized_data, 3)
km$centers
##  Premiums.Paid        Age Days.to.Renew Claims.made     Income
##98     0.9396305  0.5547923    -0.4291240  0.09470076  1.0112466
##36     1.2717162  0.7300369     1.6791853  2.76108668  1.0110976
##49    -0.6035970 -0.3536979    -0.0159498 -0.40056477 -0.6034667
###Hence it is satisfying in the Cluster 2.
rect.hclust(fit,plot(fit,hang=-1),k=2,border="red")
groups <- cutree(fit, k=2)
table(groups)
membership<-as.matrix(groups)
final <- data.frame(membership,mydata)
write.csv(final, file="insurance.csv")
getwd()


