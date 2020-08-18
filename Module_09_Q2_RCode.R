### 2  Loading Bank Dataset##

claimants <- read.csv(file.choose()) # Choose the claimants Data set
###Checking is there any NA's in the data
sum(is.na(claimants))
###sum is zero means no NA's.
View(claimants)
attach(claimants)
dim(claimants)
###Column names
colnames(claimants)
View(claimants)
# We can also include NA values but where ever it finds NA value
# probability values obtained using the glm will also be NA 
# So they can be either filled using imputation technique or
# exlclude those values 
# GLM function use sigmoid curve to produce desirable results 
# The output of sigmoid function lies in between 0-1
model <- glm(y~.,data=claimants,family = "binomial")
summary(model)
# To calculate the odds ratio manually we going r going to take exp of coef(model)
exp(coef(model))
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22640  on 45183  degrees of freedom
#AIC: 22696

##Checking backward feature engineering.
model1 <- glm(y~age+default+balance+housing+loan+duration+campaign+pdays+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +joblue.collar+joentrepreneur+johousemaid+jomanagement+joretired+joself.employed+joservices+jostudent+
                jotechnician+jounemployed,family = "binomial")
summary(model1)
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22640  on 45183  degrees of freedom
#AIC: 22696
##Removing - poutunknown , con_unknown, single, jounknown 
model2 <- glm(y~default+balance+housing+loan+duration+campaign+pdays+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +joblue.collar+joentrepreneur+johousemaid+jomanagement+joretired+joself.employed+joservices+jostudent+
                jotechnician+jounemployed,family = "binomial")
##Removing - age - no imapct on residual deviance
summary(model2)
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22640  on 45184  degrees of freedom
#AIC: 22694
##no imapct on residual deviance.
##Removing - pdays - no imapct on residual deviance
model3 <- glm(y~default+balance+housing+loan+duration+campaign+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +joblue.collar+joentrepreneur+johousemaid+jomanagement+joretired+joself.employed+joservices+jostudent+
                jotechnician+jounemployed,family = "binomial")
summary(model3)
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22640  on 45185  degrees of freedom
#AIC: 22692
##no imapct on residual deviance.
##Removing - joblue.collar and joentrepreneu
model4 <- glm(y~default+balance+housing+loan+duration+campaign+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +johousemaid+jomanagement+joretired+joself.employed+joservices+jostudent+
                jotechnician+jounemployed,family = "binomial")
summary(model4)

#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22641  on 45187  degrees of freedom
#AIC: 22689
## no imapct on residual deviance
##Removing - default 
model5 <- glm(y~balance+housing+loan+duration+campaign+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +johousemaid+jomanagement+joretired+joself.employed+joservices+jostudent+
                jotechnician+jounemployed,family = "binomial")
summary(model5)
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22642  on 45188  degrees of freedom
#AIC: 22688

## no imapct on residual deviance
##Removing - johousemaid , joself.employed and joservices - no imapct on residual deviance
model6 <- glm(y~balance+housing+loan+duration+campaign+previous+poutfailure+poutother+
                poutsuccess+con_cellular+con_telephone+divorced+married+joadmin.
              +jomanagement+joretired+jostudent+
                jotechnician+jounemployed,family = "binomial")
summary(model6)
#Null deviance: 32631  on 45210  degrees of freedom
#Residual deviance: 22648  on 45191  degrees of freedom
#AIC: 22688
exp(coef(model6))
# We are going to use NULL and Residual Deviance to compare the between different models
##model6 has less AIC value NULL and Residual deviance has no change.

prob <- predict(model6,claimants,type="response")
prob


# Confusion matrix and considering the threshold value as 0.7 , discuss cuttoff in the next part of codes.
pred_values <- NULL
yes_no <- NULL

pred_values <- ifelse(prob>0.7,1,0)
yes_no <- ifelse(prob>0.7,"yes","no")

# Creating new column to store the above values
claimants[,"prob"] <- prob
claimants[,"pred_values"] <- pred_values

claimants[,"yes_no"] <- yes_no

pred_values = as.factor(pred_values)
#View(pred_values)
claimants$y = as.factor(claimants$y)

install.packages("e1071")
library(e1071)
install.packages("caret")
library(caret)
###confusionMartrix will give the differnt data , ddepoit represents the 1.
confusion <- confusionMatrix(data = pred_values,reference = claimants$y,positive = "1")
confusion
#             Reference
#Prediction     0     1
#         0 39485  4339
#         1   437   950
#Accuracy : 0.8944          
#95% CI : (0.8915, 0.8972)
#No Information Rate : 0.883           
#P-Value [Acc > NIR] : 1.4e-14         

#Kappa : 0.248           

#Mcnemar's Test P-Value : < 2e-16         
#                                          
#            Sensitivity : 0.17962         
#            Specificity : 0.98905         
#         Pos Pred Value : 0.68493         
#         Neg Pred Value : 0.90099         
#             Prevalence : 0.11698         
#         Detection Rate : 0.02101         
#   Detection Prevalence : 0.03068         
#      Balanced Accuracy : 0.58434         
#                                          
#       'Positive' Class : 1   
# Creating empty vectors to store predicted classes based on threshold value
#### Another way caluclating using normal operations.

claimants["newclass"] <- ifelse(claimants["y"]==0 & claimants["pred_values"]==0, "TN", 
                            ifelse(claimants["y"]==0 & claimants["pred_values"]==1, "FP",
                                   ifelse(claimants["y"]==1 & claimants["pred_values"]==0, "FN", "TP")))

conf <- table(claimants["newclass"])
conf
###Calcualtions
##Accuracy = TP+TN/ Sum(all)
Accuracy  <- (conf["TP"]+ conf["TN"])/(conf["TP"]+ conf["TN"]+conf["FP"]+ conf["FN"])
names(Accuracy) = c("accuracy")
Accuracy
#Precision = TP/TP+FP
Precision  <- (conf["TP"])/( conf["TP"]+conf["FP"])
names(Precision) = c("precision")
Precision
#Specificity = TN/TN+FP
spec <- (conf["TN"])/( conf["TN"]+conf["FP"])
names(spec) = c("specificity")
spec
#Sencitivity = TP/TP+FN
sens <- (conf["TP"])/( conf["TP"]+conf["FN"])
names(sens) = c("sencitivity")
sens
###TPR = 1- Sencitivity
TPR = 1 - sens
names(TPR) = c("True Positive Rate")
TPR
###FPR = 1- Specificity
FPR = 1 - spec
names(FPR) = c("False Positive Rate")
FPR

# Calculate the below metrics
# precision | recall | True Positive Rate | False Positive Rate | Specificity | Sensitivity
# ROC Curve => used to evaluate the betterness of the logistic model
# more area under ROC curve better is the model 
# We will use ROC curve for any classification technique not only for logistic

library(ROCR)
rocrpred<-prediction(prob,claimants$y)
rocrperf<-performance(rocrpred,'tpr','fpr')

str(rocrperf)

plot(rocrperf,colorize=T,text.adj=c(-0.2,1.7))

# More area under the ROC Curve better is the logistic regression model obtained
## Getting cutt off or threshold value along with true positive and false positive rates in a data frame 

str(rocrperf)
rocr_cutoff <- data.frame(cut_off = rocrperf@alpha.values[[1]],fpr=rocrperf@x.values,tpr=rocrperf@y.values)
colnames(rocr_cutoff) <- c("cut_off","FPR","TPR")
View(rocr_cutoff)

library(dplyr)
rocr_cutoff$cut_off <- round(rocr_cutoff$cut_off,6)
# Sorting data frame with respect to tpr in decreasing order 
rocr_cutoff <- arrange(rocr_cutoff,desc(TPR))
View(rocr_cutoff)

### By looking the ROC curve and cuttoff data - 0.7 will be better cuttoff value.It is subjective to my understanding.
