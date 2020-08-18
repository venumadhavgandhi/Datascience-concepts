install.packages("arules")
data()
library("arules") # Used for building association rules i.e. apriori algorithm
data("Groceries") # loading the Groceries Data
?Groceries
inspect(Groceries[1:10]) # showing only top 10 transactions
class(Groceries) # Groceries is in transactions format

summary(Groceries) 

install.packages("arueslViz")
library("arulesViz") # for visualizing rules

# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules

# Building rules using apriori algorithm
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
inspect(head(sort(arules,by="lift"))) # to view we use inspect 

# Viewing rules based on lift value
#11124194 tsnpldsl
#1235
# Overal quality 
head(quality(arules))

# Different Ways of Visualizing Rules
plot(arules)
windows()
plot(arules,method="grouped")
plot(arules[1:20],method = "graph") # for good visualization try plotting only few rules


write(arules, file="a_rules.csv",sep=",")

getwd()

