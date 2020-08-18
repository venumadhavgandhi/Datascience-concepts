install.packages("readr")
library(reader)
Books<-read.csv(file.choose())
View(Books)
install.packages("arules")
# Used for building association rules i.e. apriori algorithm
library("arules") 
# Books is in transactions format
class(Books)
##summary of dataset
summary(Books) 
# for visualizing rules
install.packages("arueslViz")
library("arulesViz")
# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules
# Building rules using apriori algorithm
##Data in the form of dummy so convert them into matrix.
###confidence =0.9 and minlen =4 ###chaning the support
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=4))
arules
###set of 301 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.03,confidence=0.6,minlen=4))
arules
###set of 150 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.04,confidence=0.6,minlen=4))
arules
###set of 101 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.05,confidence=0.6,minlen=4))
arules
###set of 61 rules
###support = 0.02  and minlen =4 ###chaning the confidence
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.5,minlen=4))
arules
###set of 455 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=4))
arules
###set of 301 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.7,minlen=4))
arules
###set of 203 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.8,minlen=4))
arules
###set of 170 rules
###support = 0.02 ,confidence = 60% and  ###chaning the minimum length
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=3))
arules
###set of 419 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=4))
arules
###set of 301 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=5))
arules
###set of 124 rules
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=6))
arules
###set of 19 rules 
###considdering support =0.02 and confidence 60% and minlength 4
arules <- apriori(as.matrix(Books), parameter = list(support=0.02,confidence=0.6,minlen=4))
arules
###set of 301 rules
# to view we use inspect
inspect(head(sort(arules,by="lift")))  
# Viewing rules based on lift value
# Overal quality 
head(quality(arules))
# Different Ways of Visualizing Rules
plot(arules,method="scatterplot")
windows()
plot(arules,method="grouped")
plot(arules,method = "graph") 
##writing same into csv format seperated by ","
write(arules, file="a_books.csv",sep=",")
getwd()

