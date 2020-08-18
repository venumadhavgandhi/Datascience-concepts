###Question#1 Airlines analyis
install.packages("plyr")
library(plyr)
install.packages("animation")
library(animation)
install.packages("kselection")
library(kselection)
install.packages("doParallel")
library(doParallel)
install.packages("cluster")
library(cluster)
library(readxl)
####Read the xls sheet =2
mydata <- read_excel("E:/Data_Science_Okv/Datasets/new/EastWestAirlines.xlsx", sheet = 2)
View(mydata)
attach(mydata)
normalized_data <- scale(mydata[,2:12])
View(normalized_data)
d <- dist(normalized_data, method = "euclidean")
fit <- hclust(d, method="complete")
####DENDROGRAM
plot(fit, hang=-1)
###takinhg 3 as cluster- explained in the next code
rect.hclust(fit,plot(fit,hang=-1),k=3,border="red")
groups <- cutree(fit, k=3)
membership<-as.matrix(groups)
final <- data.frame(membership,mydata)
write.csv(final, file="airlines.csv")
getwd()

### k slection 
install.packages("kselection")
library(kselection)
k <- kselection(mydata[,-1], parallel = TRUE, k_threshold = 0.9, max_centers=10)
k

####Elbow Plot
wss = (nrow(normalized_data)-1)*sum(apply(normalized_data, 2, var))		 # Determine number of clusters by scree-plot
for (i in 1:8) wss[i] = sum(kmeans(normalized_data, centers=i)$withinss)
plot(1:8, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")
###taking k =3 as subjective
#### k-means for different k's 
km <- kmeans(normalized_data,3)
str(km)
km <- kmeans(normalized_data,3)
str(km)
#### k = 3 us good - no drastical change after 3
km <- kmeans(normalized_data,4)
str(km)
km <- kmeans(normalized_data,5)
str(km)
###look the clust polt
xcl <- clara(normalized_data, 3, sample = 200)
clusplot(xcl)
###
###BY LOOKING ALL TAKING 3 AS BEST K FOR AIRLINES PROBLEM IS OPINION

###QUESTION 2 CRIME ANALYSIS
mydata <- read.csv("E:/Data_Science_Okv/Datasets/new/crime_data.csv")
View(mydata)
attach(mydata)
###scaling data
data <- mydata[,2:5]
str(data)
normalized_data <- scale(mydata[,2:5])
View(normalized_data)
d <- dist(normalized_data, method = "euclidean") 
#####used complete linkage function
fit <- hclust(d, method="complete")
###Dendrogram 
#plot(fit) 
plot(fit, hang=-1)
###TAKING 4 AS  VALUE, DISCUSSED IN BELOW
rect.hclust(fit,plot(fit,hang=-1),k=4,border="red")
#####
groups <- cutree(fit, k=4) 
table(groups)
g1 = aggregate(data,list(groups),median)
data.frame(Cluster=g1[,1],Freq=as.vector(table(groups)),g1[,-1])
membership<-as.matrix(groups)
final <- data.frame(membership,mydata)
write.csv(final, file="crime.csv")
getwd()
####finding k value using k means clustering##
registerDoParallel(cores=4)
text(normalized_data, rownames(normalized_data))
install.packages("kselection")
library(kselection)
k <- kselection(data, parallel = TRUE, k_threshold = 0.9, max_centers=5)
k
## k means clueting giving is 2
###Elbow Curve
wss = (nrow(normalized_data)-1)*sum(apply(normalized_data, 2, var))		 # Determine number of clusters by scree-plot 
for (i in 1:8) wss[i] = sum(kmeans(normalized_data, centers=i)$withinss)
plot(1:8, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")   # Look for an "elbow" in the scree plot #
title(sub = "K-Means Clustering Scree-Plot")
###by lloking elbow curve k = 4 will be good : sujective
km <- kmeans(normalized_data,2)
str(km)
km <- kmeans(normalized_data,3)
str(km)
km <- kmeans(normalized_data,4)
str(km)
km <- kmeans(normalized_data,5)
str(km)
###K MEANS SELCTION IS TELLING 4 AS GOOD K AVLUE, IT SUBJECTIVE.BECAUSE THERE WILL BE NO BIG DIFFERENCE IN THE tot.withinss AND betweenss. 
###Check thru animation
km <- kmeans.ani(data,4)
####CLARA
install.packages("cluster")
library(cluster)
xcl <- clara(normalized_data, 4, sample = 200)
clusplot(xcl)
#Partitioning around medoids
xpm <- pam(normalized_data, 4)
clusplot(xpm)
### AS PER MY ANAYLASIS K =4 IS GOOD



