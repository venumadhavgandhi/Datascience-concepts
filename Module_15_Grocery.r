install.packages("readr")
library(reader)
Groceries<-read.csv(file.choose())
View(Groceries)
install.packages("arules")
# Used for building association rules i.e. apriori algorithm
library("arules") 
# Groceries is in transactions format
class(Groceries)
##summary of dataset
summary(Groceries) 
# for visualizing rules
install.packages("arueslViz")
library("arulesViz")
# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules
# Building rules using apriori algorithm
###confidence =0.6 and minlen =2 ###chaning the support
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
###set of 408 rules
arules <- apriori(Groceries, parameter = list(support=0.003,confidence=0.6,minlen=2))
arules
###set of 265 rules
arules <- apriori(Groceries, parameter = list(support=0.004,confidence=0.6,minlen=2))
arules
###set of 180 rules
arules <- apriori(Groceries, parameter = list(support=0.005,confidence=0.6,minlen=2))
arules
###set of 148 rules
###support = 0.002  and minlen =2 ###chaning the confidence
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.5,minlen=2))
arules
###set of 476 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
###set of 408 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.7,minlen=2))
arules
###set of 353 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.8,minlen=2))
arules
###set of 311 rules
###support = 0.002 ,confidence =0.6 and  ###chaning the minimum length
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
###set of 408 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=3))
arules
###set of 297 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=4))
arules
###set of 70 rules
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=5))
arules
###set of 0 rules.
##by above 408 rules with 60% confidence and 2% support with minimum 2 item is better one.
arules <- apriori(Groceries, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
# to view we use inspect
inspect(head(sort(arules,by="lift")))  
# Viewing rules based on lift value
# Overal quality 
head(quality(arules))
# Different Ways of Visualizing Rules
plot(arules,method="scatterplot")
windows()
plot(arules,method="grouped")
# for good visualization try plotting only few rules
plot(arules[1:20],method = "graph") 
##writing same into csv format seperated by ","
write(arules, file="a_rules.csv",sep=",")
getwd()

