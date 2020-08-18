import numpy as np
import pandas as pd
import matplotlib.pylab as plt
fromsklearn.cluster	import	KMeans
from scipy.spatial.distance import cdist 
import numpy as np

mydata = pd.read_excel("E:\\Data_Science_Okv\\Datasets\\new\\EastWestAirlines.xlsx",sheet_name='data')
# Normalization function 
def norm_func(i):
    x = (i-i.min())	/	(i.max()	-	i.min())
    return (x)

mydata.head()
# Normalized data frame (considering the numerical part of data)
df_norm = norm_func(mydata.iloc[:,1:])


df_norm.head()

type(df_norm)

from scipy.cluster.hierarchy import linkage 

import scipy.cluster.hierarchy as sch # for creating dendrogram 

#p = np.array(df_norm) # converting into numpy array format 
z = linkage(df_norm, method="complete",metric="euclidean")

##plt.figure(figsize=(15, 5));plt.title('Hierarchical Clustering Dendrogram');plt.xlabel('Index');plt.ylabel('Distance')
sch.dendrogram(
    z,
    leaf_rotation=0.,  # rotates the x axis labels
    leaf_font_size=8.,  # font size for the x axis labels
)
plt.show()

help(linkage)
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


# Now applying AgglomerativeClustering choosing 3 as clusters from the dendrogram
from	sklearn.cluster	import	AgglomerativeClustering 
h_complete	=	AgglomerativeClustering(n_clusters=3,	linkage='complete',affinity = "euclidean").fit(df_norm) 

cluster_labels=pd.Series(h_complete.labels_)
mydata['clust']=cluster_labels # creating a  new column and assigning it to new column 
mydata.head()
mydata = mydata.iloc[:,[12,0,1,2,3,4,5,6,7,8,9,10,11]]
mydata.head()

# getting aggregate mean of each cluster
mydata.iloc[:,2:].groupby(mydata.clust).mean()

# creating a csv file 
#mydata.to_csv("E:\\Data_Science_Okv\\Datasets\\new\\Airlines.csv",encoding="utf-8")

mydata.to_csv("Airlines.csv",encoding="utf-8")
import os

os.getcwd()
##os.chdir('e:\\classes')
##qu3stions 2
import numpy as np
import pandas as pd
import matplotlib.pylab as plt
fromsklearn.cluster	import	KMeans
from scipy.spatial.distance import cdist 
import numpy as np

mydata = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\crime_data.csv")
# Normalization function 
def norm_func(i):
    x = (i-i.min())	/	(i.max()	-	i.min())
    return (x)

mydata.head()
# Normalized data frame (considering the numerical part of data)
df_norm = norm_func(mydata.iloc[:,1:])


df_norm.head()

type(df_norm)

from scipy.cluster.hierarchy import linkage 

import scipy.cluster.hierarchy as sch # for creating dendrogram 

#p = np.array(df_norm) # converting into numpy array format 
z = linkage(df_norm, method="complete",metric="euclidean")

##plt.figure(figsize=(15, 5));plt.title('Hierarchical Clustering Dendrogram');plt.xlabel('Index');plt.ylabel('Distance')
sch.dendrogram(
    z,
    leaf_rotation=0.,  # rotates the x axis labels
    leaf_font_size=8.,  # font size for the x axis labels
)
plt.show()

help(linkage)
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


# Now applying AgglomerativeClustering choosing 3 as clusters from the dendrogram
from	sklearn.cluster	import	AgglomerativeClustering 
h_complete	=	AgglomerativeClustering(n_clusters=4,	linkage='complete',affinity = "euclidean").fit(df_norm) 

cluster_labels=pd.Series(h_complete.labels_)
mydata['clust']=cluster_labels # creating a  new column and assigning it to new column 
mydata.head()
mydata = mydata.iloc[:,[5,0,1,2,3,4]]
mydata.head()

# getting aggregate mean of each cluster
mydata.iloc[:,2:].groupby(mydata.clust).mean()

# creating a csv file 
##mydata.to_csv("E:\\Data_Science_Okv\\Datasets\\new\\crimeanals.csv",encoding="utf-8")

mydata.to_csv("Crime_analysis.csv",encoding="utf-8")
import os

os.getcwd()
##os.chdir('e:\\classes')