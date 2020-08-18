glass <- read.csv(file.choose())
View(glass)
##type is output feature
install.packages('caTools')  #for train and test data split
install.packages('dplyr')    #for Data Manipulation
install.packages('ggplot2')  #for Data Visualization
install.packages('class')    #KNN 
install.packages('caret')    #Confusion Matrix
install.packages('corrplot') #Correlation Plot
##
library(caTools)
library(dplyr)
library(ggplot2)
library(caret)
library(class)
library(corrplot)

# table of diagnosis
table(glass$Type)
##
str(glass)
# recode diagnosis as a factor
glass$Type <- factor(glass$Type)
##Normalize the data
standard.features <- scale(glass[,1:9])
##add the glass type
data <- cbind(standard.features,glass[10])
##check for any NAs'
anyNA(data)
##few data 
head(data)
###separate the traing ans test data
set.seed(101)
sample <- sample.split(data$Type,SplitRatio = 0.70)
train <- subset(data,sample==TRUE)
test <- subset(data,sample==FALSE)
##apply KNN
predicted.type <- knn(train[1:9],test[1:9],train$Type,k=1)
#Error in prediction
error <- mean(predicted.type!=test$Type)
#Confusion Matrix
confusionMatrix(predicted.type,test$Type)
####
predicted.type <- NULL
error.rate <- NULL

for (i in 1:10) {
  predicted.type <- knn(train[1:9],test[1:9],train$Type,k=i)
  error.rate[i] <- mean(predicted.type!=test$Type)
  
}

knn.error <- as.data.frame(cbind(k=1:10,error.type =error.rate))
####
ggplot(knn.error,aes(k,error.type))+ 
  geom_point()+ 
  geom_line() + 
  scale_x_continuous(breaks=1:10)+ 
  theme_bw() +
  xlab("Value of K") +
  ylab('Error')
###final model
by looking the plot k =3 will be good value.
predicted.type <- knn(train[1:9],test[1:9],train$Type,k=3)
#Error in prediction
error <- mean(predicted.type!=test$Type)
#Confusion Matrix
confusionMatrix(predicted.type,test$Type)
###