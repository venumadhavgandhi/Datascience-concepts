import pandas as pd
import numpy as np
from mlxtend.frequent_patterns import apriori, association_rules
import matplotlib.pyplot as plt
##
df = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\m15\\transactions_retail1.csv") 
## Print top 5 rows 
df.head(5)
###if still missing NA then it will  delete that line.
df1 = df.dropna()
df1
###83510 ---RECORDS GOT DECREASED.
##REPLACE NAN VALUES WITH WHITE SPACES
###Data cleaning : replacing NAN with spaces.
df1 = df.replace(np.NAN, '', regex=True)
df1
###557040 SAME NUMBER OF RECORDS
df1_list = []
###
for i in df1:
    df1_list.append(i.split(","))
#
for i in range(0,557040):
    df1_list.append([str(df1.values[i,j]) for j in range (0,6)])
df1_list
#   
all_df1_list = [i for item in df1_list for i in item]
from collections import Counter,OrderedDict
item_frequencies = Counter(all_df1_list)
item_frequencies = sorted(item_frequencies.items(),key = lambda x:x[1])
##item_frequencies
items = list(reversed([i[0] for i in item_frequencies]))

# Creating Data Frame for the transactions data 
df1_series  = pd.DataFrame(pd.Series(df1_list))
df1_series = df1_series.iloc[:557040,:] 
##df1_series = df1_series.iloc[:500,:] # removing the last empty transaction
#Due to heavy data, if you get memory error then decrease the size of the file then execute.
df1_series.columns = ["transactions"]
# creating a dummy columns for the each item in each transactions ... Using column names as item name
X = df1_series['transactions'].str.join(sep='*').str.get_dummies(sep='*')
X = df1_series['transactions'].str.get_dummies(sep=',')
##
frequent_itemsets = apriori(X, min_support=0.002, max_len=2, use_colnames = True)
rules = association_rules(frequent_itemsets, metric="lift", min_threshold=0.7)
rules.head(20)
rules.sort_values('lift',ascending = False).head(10)
# Most Frequent item sets based on support 
frequent_itemsets.sort_values('support',ascending = False,inplace=True)
plt.bar(x = list(range(1,11)),height = frequent_itemsets.support[1:11],color='rgmyk');plt.xticks(list(range(1,11)),frequent_itemsets.itemsets[1:11])
plt.xlabel('item-sets');plt.ylabel('support')

