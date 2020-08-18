install.packages("readr")
library(reader)
install.packages("naniar")
library(naniar)
Transaction<-read.csv(file.choose(),header = FALSE)
View(Transaction)
###data has NA value, so i just replace NA with white spaces.
Transaction <- sapply(Transaction, as.character)
Transaction[is.na(Transaction)] <- " "
View(Transaction)
install.packages("arules")
# Used for building association rules i.e. apriori algorithm
library("arules") 
# Transaction is in transactions format
class(Transaction)
##summary of dataset
summary(Transaction) 
Transaction1 <- as.data.frame(Transaction)
class(Transaction1)
# for visualizing rules
install.packages("arueslViz")
library("arulesViz")
# making rules using apriori algorithm 
# Keep changing support and confidence values to obtain different rules
# Building rules using apriori algorithm
###confidence =0.6 and minlen =4 ###chaning the support
arules <- apriori(Transaction1, parameter = list(support=0.002,confidence=0.6,minlen=4))
arules
###set of 2891 rules
arules <- apriori(Transaction1, parameter = list(support=0.003,confidence=0.6,minlen=4))
arules
###set of 828 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.6,minlen=4))
arules
###set of 445 rules
arules <- apriori(Transaction1, parameter = list(support=0.005,confidence=0.6,minlen=4))
arules
###set of 295 rules
###support = 0.004  and minlen =4 ###chaning the confidence
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.6,minlen=4))
arules
###set of 455 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=4))
arules
###set of 421 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.8,minlen=4))
arules
###set of 398 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.9,minlen=4))
arules
###set of 377 rules
###support = 0.004 ,confidence = 70% and  ###chaning the minimum length
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=2))
arules
###set of 1144 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=3))
arules
###set of 869 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=4))
arules
###set of 421 rules
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=5))
arules
###set of 124 rules
###considdering support =0.004 and confidence 70% and minlength 4
arules <- apriori(Transaction1, parameter = list(support=0.004,confidence=0.7,minlen=4))
arules
###set of 421 rules
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
write(arules, file="a_Transaction.csv",sep=",")
getwd()

