install.packages("readr")
library(reader)
Movies<-read.csv(file.choose())
View(Movies)
Mov <- Movies[ , c(1:5)]
View(Mov)
install.packages("arules")
# Used for building association rules i.e. apriori algorithm
library("arules") 
# Movies is in transactions format
class(Mov)
##summary of dataset
summary(Mov) 
# for visualizing rules
install.packages("arueslViz")
library("arulesViz")
# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules
# Building rules using apriori algorithm
###confidence =0.6 and minlen =2 ###chaning the support
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=2))
arules
###set of 358 rules
arules <- apriori(Mov, parameter = list(support=0.1,confidence=0.6,minlen=2))
arules
###set of 358 rules
arules <- apriori(Mov, parameter = list(support=0.2,confidence=0.6,minlen=2))
arules
###set of 78 rules
arules <- apriori(Mov, parameter = list(support=0.3,confidence=0.6,minlen=2))
arules
###set of 76 rules
###support = 0.002  and minlen =2 ###chaning the confidence
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.5,minlen=2))
arules
###set of 378 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=2))
arules
###set of 358 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.7,minlen=2))
arules
###set of 344 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.8,minlen=2))
arules
###set of 340 rules
###support = 0.002 ,confidence =0.6 and  ###chaning the minimum length
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=1))
arules
###set of 362 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=2))
arules
###set of 358 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=3))
arules
###set of 296 rules
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=4))
arules
###set of 151 rules.
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=5))
arules
### set of 33 rules.
##by above 358 rules with 60% confidence and 0.02% support with minimum 2 item is better one.
arules <- apriori(Mov, parameter = list(support=0.02,confidence=0.6,minlen=2))
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
write(arules, file="a_movies_rules.csv",sep=",")
getwd()

