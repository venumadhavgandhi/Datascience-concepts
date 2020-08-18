install.packages("readr")
library(reader)
phone<-read.csv(file.choose())
View(phone)
sum(is.na(phone))
###there is NA values in the dataset
install.packages("arules")
# Used for building association rules i.e. apriori algorithm
library("arules") 
myphone <- phone[ , c(1:3)]
View(myphone)
# phone is in transactions format
class(myphone)
##summary of dataset
summary(myphone) 
# for visualizing rules
install.packages("arueslViz")
library("arulesViz")
# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules
# Building rules using apriori algorithm
###confidence =0.6 and minlen =2 ###chaning the support
arules <- apriori(myphone, parameter = list(support=0.08,confidence=0.6,minlen=2))
arules
###set of 34 rules
arules <- apriori(myphone, parameter = list(support=0.09,confidence=0.6,minlen=2))
arules
###set of 34 rules
arules <- apriori(myphone, parameter = list(support=0.1,confidence=0.6,minlen=2))
arules
###set of 14 rules 
arules <- apriori(myphone, parameter = list(support=0.2,confidence=0.6,minlen=2))
arules
###set of 4 rules
###support = 0.002  and minlen =2 ###chaning the confidence
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.5,minlen=2))
arules
###set of 45 rules
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
###set of 34 rules
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.7,minlen=2))
arules
###set of 31 rules
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.8,minlen=2))
arules
###set of 31 rules
###support = 0.002 ,confidence =0.7 and  ###chaning the minimum length
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.6,minlen=1))
arules
###set of 35 rules
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.6,minlen=2))
arules
###set of 34 rules
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.6,minlen=3))
arules

##by above 408 rules with 60% confidence and 0.002 support with minimum 2 item is better one.
arules <- apriori(myphone, parameter = list(support=0.002,confidence=0.6,minlen=2))
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
write(arules, file="a_rules_phone.csv",sep=",")
getwd()
