import numpy as np
import pandas as pd
import matplotlib.pylab as plt
from sklearn.cluster	import	KMeans
from scipy.spatial.distance import cdist 
##
mydata = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\Insurance Dataset.csv")
####ther is na in dataset
print(mydata.isna().sum())
# Normalization function 
def norm_func(i):
    x = (i-i.min())	/	(i.max()	-	i.min())
    return (x)
###
mydata.head()
####
mydata.columns="Premiums","Age","Days","Claims","Income"
###
plt.boxplot(mydata.Claims)
plt.boxplot(mydata.Age)
plt.boxplot(mydata.Days)
plt.boxplot(mydata.Premiums)
plt.boxplot(mydata.Income)
##tehre will be outlier - 87th record
##delte it
mydata.drop(mydata.index[86])
###normalizze the data
df_norm = norm_func(mydata)
##
from scipy.cluster.hierarchy import linkage 
import scipy.cluster.hierarchy as sch # for creating dendrogram 

z = linkage(mydata, method="complete",metric="euclidean")

##Denfrogram
##plt.figure(figsize=(15, 5));plt.title('Hierarchical Clustering Dendrogram');plt.xlabel('Index');plt.ylabel('Distance')
sch.dendrogram(
    z,
    leaf_rotation=0.,  # rotates the x axis labels
    leaf_font_size=8.,  # font size for the x axis labels
)

##### Elbow curve
k = list(range(1,10))
k
TWSS = [] # variable for storing total within sum of squares for each kmeans 
for i in k:
    kmeans = KMeans(n_clusters = i)
    kmeans.fit(df_norm)
    WSS = [] # variable for storing within sum of squares for each cluster 
    for j in range(i):
        WSS.append(sum(cdist(df_norm.iloc[kmeans.labels_==j,:],kmeans.cluster_centers_[j].reshape(1,df_norm.shape[1]),"euclidean")))
    TWSS.append(sum(WSS))

plt.plot(k,TWSS, 'ro-');plt.xlabel("No_of_Clusters");plt.ylabel("total_within_SS");plt.xticks(k)
####
###KMEANS and Centers
kmeans = KMeans(n_clusters=2).fit(df_norm)
centroids = kmeans.cluster_centers_
print(centroids)

kmeans = KMeans(n_clusters=3).fit(df_norm)
centroids = kmeans.cluster_centers_
print(centroids)


###k = 2 will be good
for k in range (1, 11):
     kmeans_model = KMeans(n_clusters=k, random_state=1).fit(df_norm.iloc[:, :])
     labels = kmeans_model.labels_
     interia = kmeans_model.inertia_
     print ("k:", k, " cost:", interia)

####k = 2 will be good
from	sklearn.cluster	import	AgglomerativeClustering 
h_complete	=	AgglomerativeClustering(n_clusters=2,	linkage='complete',affinity = "euclidean").fit(df_norm) 

cluster_labels=pd.Series(h_complete.labels_)
mydata['clust']=cluster_labels # creating a  new column and assigning it to new column 
mydata = mydata.iloc[:,[5,0,1,2,3,4]]
mydata.head()
###
mydata.iloc[:,1:5].groupby(mydata.clust).mean()
##
##Write into CSV file
mydata.to_csv("Insurance_anlysis.csv",encoding="utf-8")
##
os.getcwd()
##