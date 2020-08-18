################### Ada Boost ####################
install.packages("adabag")
library(adabag)#An R Package for Classification with Boosting and Bagging
#Boosting and bagging are two widely used ensemble methods for classification
library(caret)
#contains functions to streamline the model training process for complex regression and classification problems.

wbcd <- read.csv("D:/360digiTMG/unsupervised/mod20 AdaBoost/Datasets (3)/wbcd.csv")
View(wbcd)

sum(is.na(wbcd))
#0

#remove 1st column as it consists of id
wbcd <- wbcd[-1]

hist(wbcd)

head(wbcd)


#Accuracy with single model
inTraininglocal<-createDataPartition(wbcd$diagnosis,p=.75,list = F)
training<-wbcd[inTraininglocal,]
testing<-wbcd[-inTraininglocal,]

install.packages("C50")
library("C50")
model<-C5.0(training$diagnosis~.,data = training)
pred<-predict.C5.0(model,testing)
a<-table(testing$diagnosis,pred)

sum(diag(a))/sum(a)
#0.9507042

########Bagging#############
acc<-c()
for(i in 1:11)
{
  inTraininglocal<-createDataPartition(wbcd$diagnosis,p=.85,list = F)
  training1<-wbcd[inTraininglocal,]
  testing<-wbcd[-inTraininglocal,]
  fittree <- C5.0(training1$diagnosis~., data=training1)
  pred<-predict.C5.0(fittree,testing)
  a<-table(testing$diagnosis,pred)
  acc<-c(acc,sum(diag(a))/sum(a))
}
summary(acc)

mean(acc)
# 0.9329004

####################### Boosting#############

#Accuracy with single model with Boosting

inTraininglocal<-createDataPartition(wbcd$diagnosis,p=.75,list = F)
training<-wbcd[inTraininglocal,]
testing<-wbcd[-inTraininglocal,]

model<-C5.0(training$diagnosis~.,data = training,trials=10)
pred<-predict.C5.0(model,testing)
a<-table(testing$diagnosis,pred)

sum(diag(a))/sum(a)
#0.9366197

######## Bagging and Boosting
acc<-c()
for(i in 1:11)
{
  
  inTraininglocal<-createDataPartition(wbcd$diagnosis,p=.85,list = F)
  training1<-wbcd[inTraininglocal,]
  testing<-wbcd[-inTraininglocal,]
  
  fittree <- C5.0(training1$diagnosis~., data=training1,trials=10)
  pred<-predict.C5.0(fittree,testing)
  a<-table(testing$diagnosis,pred)
  
  acc<-c(acc,sum(diag(a))/sum(a))
  
}

summary(acc)
mean(acc)
#0.961039

