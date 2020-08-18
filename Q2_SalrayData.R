### Q2 #Prepare a classification model using Naive Bayes  for salary data
#Import the raw_sms dataset 
install.packages("naivebayes")
install.packages("ggplot2")
install.packages("caret")
install.packages("e1071")
library(naivebayes)
library(ggplot2)
library(readr)
library(caret)
library(e1071)
####Traing dataset
train_sal <- read.csv(file.choose())
View(train_sal)
train_sal$educationno <- as.factor(train_sal$educationno)
class(train_sal)
###Testing dataset
test_sal <- read.csv(file.choose())
View(test_sal)
test_sal$educationno <- as.factor(test_sal$educationno)
class(test_sal)
##
#Visualization 
# Plot and ggplot 
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$age, fill = train_sal$Salary)) +
  geom_boxplot() +
  ggtitle("Box Plot")
##
plot(train_sal$workclass,train_sal$Salary)
##
plot(train_sal$education,train_sal$Salary)
##
plot(train_sal$maritalstatus,train_sal$Salary)
##
plot(train_sal$occupation,train_sal$Salary)
###
plot(train_sal$relationship,train_sal$Salary)
##
plot(train_sal$race,train_sal$Salary)
##
plot(train_sal$sex,train_sal$Salary)
##
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$capitalgain, fill = train_sal$Salary)) +
  geom_boxplot() +
  ggtitle("Box Plot")
##
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$capitalloss, fill = train_sal$Salary)) +
  geom_boxplot() +
  ggtitle("Box Plot")
##
ggplot(data=train_sal,aes(x=train_sal$Salary, y = train_sal$hoursperweek, fill = train_sal$Salary)) +
  geom_boxplot() +
  ggtitle("Box Plot")
##
plot(train_sal$native,train_sal$Salary)
###
ggplot(data=train_sal,aes(x = train_sal$age, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Age - Density Plot")
##
ggplot(data=train_sal,aes(x = train_sal$workclass, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Workclass Density Plot")
##
ggplot(data=train_sal,aes(x = train_sal$education, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
## run
ggtitle("education Density Plot")
#
ggplot(data=train_sal,aes(x = train_sal$educationno, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("educationno Density Plot")
##
ggplot(data=train_sal,aes(x = train_sal$maritalstatus, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("maritalstatus Density Plot")
##
ggplot(data=train_sal,aes(x = train_sal$occupation, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("occupation Density Plot")
ggplot(data=train_sal,aes(x = train_sal$sex, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("sex Density Plot")
ggplot(data=train_sal,aes(x = train_sal$relationship, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Relationship Density Plot")
ggplot(data=train_sal,aes(x = train_sal$race, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Race Density Plot")
ggplot(data=train_sal,aes(x = train_sal$capitalgain, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Capitalgain Density Plot")
ggplot(data=train_sal,aes(x = train_sal$capitalloss, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Capitalloss Density Plot")
ggplot(data=train_sal,aes(x = train_sal$hoursperweek, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
##
ggtitle("Hoursperweek Density Plot")
ggplot(data=train_sal,aes(x = train_sal$native, fill = train_sal$Salary)) +
  geom_density(alpha = 0.9, color = 'Violet')
###
ggtitle("native Density Plot")
# Naive Bayes Model 
Model <- naiveBayes(train_sal$Salary ~ ., data = train_sal)
Model
## predicting the model
Model_pred <- predict(Model,test_sal)
mean(Model_pred==test_sal$Salary)
##0.8187251
##

confusionMatrix(Model_pred,test_sal$Salary)
##
#          Reference
#Prediction  <=50K  >50K
#     <=50K  10549  1919
#     >50K     811  1781
#                                          
#               Accuracy : 0.8187          
#                 95% CI : (0.8125, 0.8248)
#    No Information Rate : 0.7543          
#    P-Value [Acc > NIR] : < 2.2e-16       
#                                          
#                  Kappa : 0.456           
#                                          
# Mcnemar's Test P-Value : < 2.2e-16       
#Sensitivity : 0.9286          
#Specificity : 0.4814          
#Pos Pred Value : 0.8461          
#Neg Pred Value : 0.6871          
#Prevalence : 0.7543          
#Detection Rate : 0.7005          
#Detection Prevalence : 0.8279          
#Balanced Accuracy : 0.7050          

##'Positive' Class :  <=50K   

###END 













