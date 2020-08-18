zoo <- read.csv(file.choose())
View(zoo)
##type is output feature
install.packages('caTools')  #for train and test data split
install.packages('dplyr')    #for Data Manipulation
install.packages('ggplot2')  #for Data Visualization
install.packages('class')    #KNN 
install.packages('caret')    #Confusion Matrix
install.packages('corrplot') #Correlation Plot
install.packages("pROC")
install.packages("mlbench")
install.packages("lattice")
##
library(caTools)
library(dplyr)
library(ggplot2)
library(caret)
library(class)
library(corrplot)
library(mlbench)
library(lattice)
library(pROC)
# table of diagnosis
table(zoo$type)
##
str(zoo)
###
zoo1 <- zoo[,2:18]
str(zoo1)
zoo_key <- zoo[, 1]
####conver them into factor
zoo1$hair <- as.factor(zoo1$hair)
zoo1$feathers <- as.factor(zoo1$feathers)
zoo1$eggs <- as.factor(zoo1$eggs)
zoo1$milk <- as.factor(zoo1$milk)
zoo1$airborne <- as.factor(zoo1$airborne)
zoo1$aquatic <- as.factor(zoo1$aquatic)
zoo1$predator <- as.factor(zoo1$predator)
zoo1$toothed <- as.factor(zoo1$toothed)
zoo1$backbone <- as.factor(zoo1$backbone)
zoo1$breathes <- as.factor(zoo1$breathes)
zoo1$venomous <- as.factor(zoo1$venomous)
zoo1$fins <- as.factor(zoo1$fins)
zoo1$legs <- as.factor(zoo1$legs)
zoo1$tail <- as.factor(zoo1$tail)
zoo1$domestic <- as.factor(zoo1$domestic)
zoo1$catsize <- as.factor(zoo1$catsize)
zoo1$type <- as.factor(zoo1$type)
#####
# Data partition
set.seed(123)
ind <- sample(2,nrow(zoo1), replace = T, prob = c(0.7,0.3))
train <- zoo1[ind==1,]
test <- zoo1[ind==2,]
# KNN Model 
trcontrol <- trainControl(method = "repeatedcv", number = 10,repeats = 3)
# classprobs are needed when u want to select ROC for optimal K Value
set.seed(222)
fit <- train(type ~., data = train, method = 'knn', tuneLength = 20,
             trControl = trcontrol, preProc = c("center","scale"))
###we will get data for accuracy for different k.
fit
#k   Accuracy   Kappa     
#5  0.8421825  0.77477121
#7  0.8401984  0.77224141
#9  0.8184524  0.74135120
#11  0.8232143  0.74565756
#13  0.8443651  0.77380421
#15  0.8443651  0.77313754
#17  0.8443651  0.77102454
#19  0.8396032  0.76329032
#21  0.8025794  0.69595293
#23  0.7611111  0.62793181
#25  0.7107540  0.52782072
#27  0.7118651  0.52864460
#29  0.6512302  0.42060064
#31  0.6040476  0.32840389
#33  0.5773413  0.25820566
#35  0.5541270  0.21881723
#37  0.5038095  0.10364036
#39  0.4771032  0.02333333
#41  0.4715476  0.00000000
#43  0.4715476  0.00000000
##visualization
plot(fit)
##k = 5 will be good value
set.seed(222)
fit <- train(type ~., data = train, method = 'knn', tuneLength = 5,
             trControl = trcontrol, preProc = c("center","scale"))
varImp(fit)
pred <- predict(fit, newdata = test )
confusionMatrix(pred, test$type)
###