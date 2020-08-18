import pandas as pd
import numpy as np
from mlxtend.frequent_patterns import apriori, association_rules
import matplotlib.pyplot as plt
##df = pd.read_csv('https://gist.githubusercontent.com/Harsh-Git-Hub/2979ec48043928ad9033d8469928e751/raw/72de943e040b8bd0d087624b154d41b2ba9d9b60/retail_dataset.csv', sep=',')
df = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\m15\\book.csv") 
df
## Print top 5 rows 
df.head(5)
ohe_df = pd.DataFrame(df)
freq_items = apriori(ohe_df, min_support=0.02, use_colnames=True, max_len=4, verbose=1)
freq_items.head(10)
#
rules = association_rules(freq_items, metric="confidence", min_threshold=0.6)
rules.head()
#
rules = association_rules(freq_items, metric="lift", min_threshold=0.6)
rules.head()
##best rules
rules.sort_values("lift",ascending = False).head(10)
##filtering rules 
rules[ (rules['lift'] >= 1.5) &
       (rules['confidence'] >= 0.8) ]

##suppport vs confidence
plt.scatter(rules['support'], rules['confidence'], alpha=0.5)
plt.xlabel('support')
plt.ylabel('confidence')
plt.title('Support vs Confidence')
plt.show()
###plotting in the bars
freq_items.sort_values('support',ascending = False,inplace=True)
plt.bar(x = list(range(1,11)),height = freq_items.support[1:11],color='rgmyk');plt.xticks(list(range(1,11)),freq_items.itemsets[1:11])
plt.xlabel('item-sets');plt.ylabel('support')
##Support vs Lift
plt.scatter(rules['support'], rules['lift'], alpha=0.5)
plt.xlabel('support')
plt.ylabel('lift')
plt.title('Support vs Lift')
plt.show()
####