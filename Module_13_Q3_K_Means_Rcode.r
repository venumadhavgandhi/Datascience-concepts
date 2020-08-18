mydata <- read.csv("E:/Data_Science_Okv/Datasets/new/crime_data.csv")
View(mydata)
###deleting the 87th record which is influing a lot in the clustering.
data <-  mydata[,2:5]
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
### $ tot.withinss: num 103
### $ betweenss   : num 93.1
### $ size        : int [1:2] 20 30

km <- kmeans(normalized_data,3)
str(km)
### $ tot.withinss: num 81.6
### $ betweenss   : num 114
### $ size        : int [1:3] 21 45 33

### In the cluster 3 -betweenss is more than the  tot.withinss. I think 2 will be good.
### As per the standards betweenss should be less and tot.withinss should be more.
install.packages("animation")
library(animation)
km <- kmeans.ani(normalized_data, 2)
km$centers
##Murder    Assault   UrbanPop       Rape
##[1,]  1.004934  1.0138274  0.1975853  0.8469650
##[2,] -0.669956 -0.6758849 -0.1317235 -0.5646433
km <- kmeans.ani(normalized_data, 3)
km$centers
##Murder    Assault   UrbanPop       Rape
##[1,]  1.3114424  0.9001666 -0.8586592  0.2931524
##[2,] -0.7229267 -0.7273679 -0.1606737 -0.5890976
##[3,]  0.6491513  0.9434464  0.9405229  1.0658739
### ther will be lappsing in the centers.
###Hence it is satisfying in the Cluster 2.
rect.hclust(fit,plot(fit,hang=-1),k=2,border="red")
groups <- cutree(fit, k=2)
table(groups)
membership<-as.matrix(groups)
final <- data.frame(membership,mydata)
write.csv(final, file="criminal_records.csv")
getwd()


