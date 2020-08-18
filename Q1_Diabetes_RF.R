################### Ada Boost ####################

install.packages("adabag")
library(adabag)#An R Package for Classification with Boosting and Bagging
#Boosting and bagging are two widely used ensemble methods for classification
library(caret)
#contains functions to streamline the model training process for complex regression and classification problems.

Diabetes <- read.csv("D:/360digiTMG/unsupervised/mod20 AdaBoost/Datasets (3)/Diabetes_RF.csv")
View(Diabetes)

sum(is.na(Diabetes))
# 0

head(Diabetes)

#Accuracy with single model
inTraininglocal<-createDataPartition(Diabetes$Class.variable,p=.75,list = F)
training<-Diabetes[inTraininglocal,]
testing<-Diabetes[-inTraininglocal,]

install.packages("C50")
library("C50")
model<-C5.0(training$Class.variable~.,data = training)
pred<-predict.C5.0(model,testing)
a<-table(testing$Class.variable,pred)

sum(diag(a))/sum(a)
#0.7239583

########Bagging#############
acc<-c()
for(i in 1:11)
{
  inTraininglocal<-createDataPartition(Diabetes$Class.variable,p=.85,list = F)
  training1<-Diabetes[inTraininglocal,]
  testing<-Diabetes[-inTraininglocal,]
  fittree <- C5.0(training1$Class.variable~., data=training1)
  pred<-predict.C5.0(fittree,testing)
  a<-table(testing$Class.variable,pred)
  acc<-c(acc,sum(diag(a))/sum(a))
}
summary(acc)

mean(acc)
# 0.743083

####################### Boosting#############

#Accuracy with single model with Boosting

inTraininglocal<-createDataPartition(Diabetes$Class.variable,p=.75,list = F)
training<-Diabetes[inTraininglocal,]
testing<-Diabetes[-inTraininglocal,]

model<-C5.0(training$Class.variable~.,data = training,trials=10)
pred<-predict.C5.0(model,testing)
a<-table(testing$Class.variable,pred)

sum(diag(a))/sum(a)
#0.7604167

######## Bagging and Boosting
acc<-c()
for(i in 1:11)
{
  
  inTraininglocal<-createDataPartition(Diabetes$Class.variable,p=.85,list = F)
  training1<-Diabetes[inTraininglocal,]
  testing<-Diabetes[-inTraininglocal,]
  
  fittree <- C5.0(training1$Class.variable~., data=training1,trials=10)
  pred<-predict.C5.0(fittree,testing)
  a<-table(testing$Class.variable,pred)

  acc<-c(acc,sum(diag(a))/sum(a))
  
}

summary(acc)
mean(acc)
#0.7628458

