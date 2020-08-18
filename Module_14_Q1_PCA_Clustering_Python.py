import pandas as pd 
import numpy as np
import matplotlib.pylab as plt
from sklearn.cluster	import	KMeans
from scipy.spatial.distance import cdist 
uni1 = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\wine.csv")
uni1.describe()
uni1.head()
##
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale 

# Considering only numerical data 
data= uni1.iloc[:,1:]
data.head(4)

# Normalizing the numerical data 
uni_normal = scale(data)
uni_normal
####PCA covertion
pca = PCA(n_components = 13)
pca_values = pca.fit_transform(uni_normal)
# The amount of variance that each PCA explains is 
var = pca.explained_variance_ratio_
var
####
pca.components_
pca.components_[0]
# Cumulative variance 
var1 = np.cumsum(np.round(var,decimals = 4)*100)
var1
# Variance plot for PCA components obtained 
plt.plot(var1,color="red")
# plot between PCA1 and PCA2 
x = pca_values[:,0]
y = pca_values[:,1]
pca_values
# z = pca_values[:2:3]
plt.scatter(x,y)
####
pcaxyz = pca_values[:,0:3]
pcaxyz = pd.DataFrame(pcaxyz)
pcaabc = pd.DataFrame(uni1["Type"])
Pcadata = pd.concat([pcaabc,pcaxyz],axis=1)
Pcadata.to_csv("PCA_Data_Py_anlysis.csv",encoding="utf-8")
###
def norm_func(i):
    x = (i-i.min())	/	(i.max()	-	i.min())
    return (x)

Pcadata.head()
data = pcaxyz
###
df_norm = norm_func(data)
##
from scipy.cluster.hierarchy import linkage 
import scipy.cluster.hierarchy as sch # for creating dendrogram 
#####
z = linkage(data, method="complete",metric="euclidean")
##Dendrogram
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
####k = 3 will be good
###KMEANS and Centers
kmeans = KMeans(n_clusters=2).fit(df_norm)
centroids = kmeans.cluster_centers_
print(centroids)

kmeans = KMeans(n_clusters=3).fit(df_norm)
centroids = kmeans.cluster_centers_
print(centroids)

###k = 3 will be good
for k in range (1, 11):
     kmeans_model = KMeans(n_clusters=k, random_state=1).fit(df_norm.iloc[:, :])
     labels = kmeans_model.labels_
     interia = kmeans_model.inertia_
     print ("k:", k, " cost:", interia)

####k = 3 will be good
##### H -Clusetering#################
from	sklearn.cluster	import	AgglomerativeClustering 
h_complete	=	AgglomerativeClustering(n_clusters=3,	linkage='complete',affinity = "euclidean").fit(df_norm) 
cluster_labels=pd.Series(h_complete.labels_)
Pcadata['clust']=cluster_labels # creating a  new column and assigning it to new column 
Pcadata = Pcadata.iloc[:,[4,0,1,2,3]]
Pcadata.head()
###
Pcadata.iloc[:,2:5].groupby(Pcadata.clust).mean()
##
##Write into CSV file
Pcadata.to_csv("PCA_Cluster_Py_anlysis.csv",encoding="utf-8")
##
##