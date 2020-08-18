# Load the Election data set  Quesiton 3
claimants1 <- read.csv(file.choose()) # Choose the election Data set
sum(is.na(claimants1))
View(claimants1)
##by looking the data, complete one observation has NA.'s omitting tham.
claimants <- na.omit(claimants1) 
sum(is.na(claimants))
dim(claimants)
View(claimants)
attach(claimants)
colnames(claimants)
# Removing the first column which is is an election id 
claimants2 <- claimants[,-1] 
attach(claimants2)
# GLM function use sigmoid curve to produce desirable results 
# The output of sigmoid function lies in between 0-1
model <- glm(Result~.,data=claimants2,family = "binomial")
summary(model)
# To calculate the odds ratio manually we going r going to take exp of coef(model)
exp(coef(model))
#Null deviance: 1.3460e+01  on 9  degrees of freedom
#Residual deviance: 6.5897e-10  on 6  degrees of freedom
#AIC: 8

# Confusion matrix table 

prob <- predict(model,claimants2,type="response")
prob
# We are going to use NULL and Residual Deviance to compare the between different models

# Confusion matrix and considering the threshold value as 0.9 
pred_values <- NULL
yes_no <- NULL

pred_values <- ifelse(prob>0.9,1,0)

yes_no <- ifelse(prob>0.9,"yes","no")

# Creating new column to store the above values
claimants[,"prob"] <- prob
claimants[,"pred_values"] <- pred_values

claimants[,"yes_no"] <- yes_no
attach(claimants)
pred_values = as.factor(pred_values)
#View(pred_values)
claimants$Result = as.factor(claimants$Result)
install.packages("e1071")
library(e1071)
install.packages("caret")
library(caret)
confusion <- confusionMatrix(data = pred_values,reference = claimants$Result,positive = "1")
confusion
####
#          Reference
#Prediction   0  1
#         0   4  0
#         1   0  6

#Accuracy : 1          
#95% CI : (0.6915, 1)
#No Information Rate : 0.6        
#P-Value [Acc > NIR] : 0.006047   

#Kappa : 1          

#Mcnemar's Test P-Value : NA         
                                     
#            Sensitivity : 1.0        
#            Specificity : 1.0        
#         Pos Pred Value : 1.0        
#         Neg Pred Value : 1.0        
#             Prevalence : 0.6        
#         Detection Rate : 0.6        
#   Detection Prevalence : 0.6        
#      Balanced Accuracy : 1.0        
                                     
#       'Positive' Class : 1   
View(claimants[,c(1,2,7,8)])
table(claimants$y,claimants$pred_values)

# Calculate the below metrics
# precision | recall | True Positive Rate | False Positive Rate | Specificity | Sensitivity
# from the above table - 59
# ROC Curve => used to evaluate the betterness of the logistic model
# more area under ROC curve better is the model 
# We will use ROC curve for any classification technique not only for logistic

library(ROCR)
rocrpred<-prediction(prob,claimants$Result)
rocrperf<-performance(rocrpred,'tpr','fpr')

str(rocrperf)

plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))

str(rocrperf)
rocr_cutoff <- data.frame(cut_off = rocrperf@alpha.values[[1]],fpr=rocrperf@x.values,tpr=rocrperf@y.values)
colnames(rocr_cutoff) <- c("cut_off","FPR","TPR")
View(rocr_cutoff)

library(dplyr)
rocr_cutoff$cut_off <- round(rocr_cutoff$cut_off,6)
# Sorting data frame with respect to tpr in decreasing order 
rocr_cutoff <- arrange(rocr_cutoff,desc(TPR))
View(rocr_cutoff)

##Taking .95 cuttoff value as per the above data.
