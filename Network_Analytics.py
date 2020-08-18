import pandas as pd 
import numpy as np
import networkx as nx 
import matplotlib.pyplot as plt

## Eigen-Vector Centrality
## Importing routes.dat file
data = pd.read_table("D:\\Data Science\\python_codes\\Network Analytics\\routes.dat",sep=",")
G = nx.path_graph(4)
G = nx.Graph()
FG = nx.from_pandas_edgelist(data, source='Source Airport', target='Destination Airport', edge_attr=True,)
FG.nodes()
FG.edges()
nx.draw_networkx(FG, with_labels=True)
G = nx.path_graph(4)
centrality = nx.eigenvector_centrality(FG) # Eigen vector centrality

pos=nx.spring_layout(FG, k=0.15)
nx.draw_networkx(FG,pos,node_size=25, node_color='blue')
plt.show()
print(['{} {:0.2f}'.format(node, centrality[node]) for node in centrality])

## Betweeness Centrality 
## importing rotues.dat file
G = pd.read_table("D:\\Data Science\\python_codes\\Network Analytics\\routes.dat",sep=",")

G = G.iloc[:,1:10]

g = nx.Graph()

g = nx.from_pandas_edgelist(G,source='Source Airport',target='Destination Airport')

print(nx.info(g))

b=nx.betweenness_centrality(g) # Betweeness_Centrality

print(b) 

plt.figure(figsize=(20, 20))

pos=nx.spring_layout(g, k=0.15)

nx.draw_networkx(g,pos,node_size=25, node_color='blue')

plt.show()

# Closeness Centrality 
## importing rotues.dat file
G = pd.read_table("D:\\Data Science\\python_codes\\Network Analytics\\routes.dat",sep=",")
g = nx.Graph() 

g = nx.from_pandas_edgelist(data,source = "Source Airport",target = "Destination Airport")

print(nx.info(g))

plt.figure(figsize = (20,20))
pos=nx.spring_layout(g, k=0.15)
nx.draw_networkx(g,pos,node_size=25, node_color='Green')
plt.show()
g=nx.erdos_renyi_graph(10,0.4) 

# Average clustering

cc=nx.average_clustering(g) 

# closeness centrality

closeness = nx.closeness_centrality(g)

# cluster coefficient

cluster_coeff = nx.clustering(g)

# Degree Centrality
## importing rotues.dat file
G = pd.read_table("D:\\Data Science\\python_codes\\Network Analytics\\routes.dat",sep=",")
G = G.iloc[:,1:10]

g = nx.Graph()

g = nx.from_pandas_edgelist(G,source='Source Airport',target='Destination Airport')

print(nx.info(g))

b=nx.degree_centrality(g)  # Degree Centrality

print(b) 

pos=nx.spring_layout(g, k=0.15)

nx.draw_networkx(g,pos,node_size=25, node_color='blue')
