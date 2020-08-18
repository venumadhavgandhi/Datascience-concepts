# implementing Apriori algorithm from mlxtend
# conda install -c conda-forge mlxtend
import pandas as pd
import numpy as np
from mlxtend.frequent_patterns import apriori,association_rules

groceries = []
f = open("E:\\Data_Science_Okv\\Datasets\\new\m15\\groceries.csv")
groceries = f.read()
# splitting the data into separate transactions using separator as "\n"
groceries = groceries.split("\n")
groceries_list = []
for i in groceries:
    groceries_list.append(i.split(","))

all_groceries_list = [i for item in groceries_list for i in item]
from collections import Counter,OrderedDict

item_frequencies = Counter(all_groceries_list)
# after sorting
item_frequencies = sorted(item_frequencies.items(),key = lambda x:x[1])
# Storing frequencies and items in separate variables 
frequencies = list(reversed([i[1] for i in item_frequencies]))
items = list(reversed([i[0] for i in item_frequencies]))
# barplot of top 10 
import matplotlib.pyplot as plt

plt.bar(height = frequencies[1:11],x = list(range(1,11)),color='rgbkymc');
plt.xticks(list(range(1,11),),items[1:11]);
plt.xlabel("items")
plt.ylabel("Count");
plt.xlabel("Items")

# Creating Data Frame for the transactions data 

groceries_series  = pd.DataFrame(pd.Series(groceries_list))
groceries_series = groceries_series.iloc[:9835,:] # removing the last empty transaction

groceries_series.columns = ["transactions"]

# creating a dummy columns for the each item in each transactions ... Using column names as item name
X = groceries_series['transactions'].str.join(sep='*').str.get_dummies(sep='*')
##
frequent_itemsets = apriori(X, min_support=0.002, max_len=2, use_colnames = True)
rules = association_rules(frequent_itemsets, metric="lift", min_threshold=1)
rules.head(20)
rules.sort_values('lift',ascending = False).head(10)

# Most Frequent item sets based on support 
frequent_itemsets.sort_values('support',ascending = False,inplace=True)
plt.bar(x = list(range(1,11)),height = frequent_itemsets.support[1:11],color='rgmyk');plt.xticks(list(range(1,11)),frequent_itemsets.itemsets[1:11])
plt.xlabel('item-sets');plt.ylabel('support')






