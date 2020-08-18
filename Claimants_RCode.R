# Load the Dataset
#claimants1 <- read.csv(file.choose()) # Choose the claimants Data set
install.packages('AER')
library('AER')
##affairs <- data("Affairs")
affairs <- read.csv(file.choose())
View(affairs)
affairs1 <- affairs
summary(affairs1)
### X is identity varaible not required.
## changing the naffairs data into FACTOR DATA
affairs1$naffairs[affairs1$naffairs > 0] <- 1
affairs1$naffairs[affairs1$naffairs == 0] <- 0
View(affairs1)
attach(affairs1)
##Checking for NA
sum(is.na(affairs1))
#no NA's
affairs1 <- affairs1[,-1] 
attach(affairs1)
##by looking the data, complete one observation has NA.SO omitting that.
#claimants <- na.omit(claimants) # Omitting NA values from the Data 
# na.omit => will omit the rows which has atleast 1 NA value
#claimants <- na.omit(claimants1) 
#sum(is.na(claimants))
dim(affairs1)
# We can have mean/median imputation as well
#claimants1 <- claimants
#claimants1[is.na(claimants1)]<-mean(claimants$[!is.na(claimants)])
# summary(claimants1)
# claimants1[is.na(claimants1)]<-median(claimants[!is.na(claimants)])
#sum(is.na(claimants1))
#claimants <- claimants1
#View(claimants)
#attach(claimants)

colnames(affairs1)
#View(claimants)
#claimants2 <- claimants[,-1] # Removing the first column which is is an election id 
#attach(claimants2)
# Preparing a linear regression 
#mod_lm <- lm(y~.,data=claimants)
#pred1 <- predict(mod_lm,claimants)
##pred1
#plot(claimants$CLMINSUR,pred1)
# We can no way use the linear regression technique to classify the data
#plot(pred1)


# We can also include NA values but where ever it finds NA value
# probability values obtained using the glm will also be NA 
# So they can be either filled using imputation technique or
# exlclude those values 


# GLM function use sigmoid curve to produce desirable results 
# The output of sigmoid function lies in between 0-1
model <- glm(naffairs~.,data=affairs1,family = "binomial")
summary(model)
# To calculate the odds ratio manually we going r going to take exp of coef(model)
exp(coef(model))

##Null deviance: 675.38  on 600  degrees of freedom
##Residual deviance: 602.21  on 586  degrees of freedom
##AIC: 632.21

## There are few NA in the columns and few columns has above 0.05 P value.
##Remove vryhap vryrel  yrsmarr6  - n-1 varaibles consider

model1 <- glm(naffairs~kids+vryunhap+unhap+avgmarr+hapavg+antirel+notrel+slghtrel+smerel+
                yrsmarr1+yrsmarr2+yrsmarr3+yrsmarr4+yrsmarr5,data=affairs1,family = "binomial")
                
summary(model1)

##Null deviance: 675.38  on 600  degrees of freedom
##Residual deviance: 602.21  on 586  degrees of freedom
##AIC: 632.21
## Removing kids notrel
model2 <- glm(naffairs~vryunhap+unhap+avgmarr+hapavg+antirel+slghtrel+smerel+
                yrsmarr1+yrsmarr2+yrsmarr3+yrsmarr4+yrsmarr5,data=affairs1,family = "binomial")

summary(model2)

#Null deviance: 675.38  on 600  degrees of freedom
#Residual deviance: 603.82  on 588  degrees of freedom
#AIC: 629.82

##Removing the yrsmarr3 ,yrsmarr4,yrsmarr5 
model3 <- glm(naffairs~vryunhap+unhap+avgmarr+hapavg+antirel+slghtrel+smerel+
                yrsmarr1+yrsmarr2,data=affairs1,family = "binomial")

summary(model3)

##Null deviance: 675.38  on 600  degrees of freedom
##Residual deviance: 604.95  on 591  degrees of freedom
##AIC: 624.95
##No Change in NULL deviance and very slight chagne in the Residula deviance
##AIC got decreased
# Confusion matrix table 

prob <- predict(model,affairs1,type="response")
prob
# We are going to use NULL and Residual Deviance to compare the between different models

# Confusion matrix and considering the threshold value as 0.5 
pred_values <- NULL
yes_no <- NULL
##Going with standard cuttoff 0.5
pred_values <- ifelse(prob>0.5,1,0)

yes_no <- ifelse(prob>0.5,"yes","no")

# Creating new column to store the above values
affairs[,"prob"] <- prob
affairs[,"pred_values"] <- pred_values
affairs[,"yes_no"] <- yes_no
attach(affairs)
pred_values = as.factor(pred_values)
affairs1$naffairs = as.factor(affairs1$naffairs)
install.packages("e1071")
library(e1071)
install.packages("caret")
library(caret)
confusion <- confusionMatrix(data = pred_values,reference = affairs1$naffairs,positive = "1")
confusion

#           Reference
#Prediction   0   1
#          0 429 118
#          1  22  32

#Accuracy : 0.7671          
#95% CI : (0.7312, 0.8003)
#No Information Rate : 0.7504          
#P-Value [Acc > NIR] : 0.1857          

#Kappa : 0.2092          

#Mcnemar's Test P-Value : 9.83e-16        
                                          
#            Sensitivity : 0.21333         
#            Specificity : 0.95122         
#         Pos Pred Value : 0.59259         
#         Neg Pred Value : 0.78428         
#             Prevalence : 0.24958         
#         Detection Rate : 0.05324         
#   Detection Prevalence : 0.08985         
#      Balanced Accuracy : 0.58228         
                                          
#       'Positive' Class : 1 

####
View(affairs[,c(1,2,20,21,22)])

claimants <- affairs1

claimants["newclass"] <- ifelse(claimants["naffairs"]==0 & affairs["pred_values"]==0, "TN", 
                            ifelse(claimants["naffairs"]==0 & affairs["pred_values"]==1, "FP",
                                   ifelse(claimants["naffairs"]==1 & affairs["pred_values"]==0, "FN", "TP")))

conf.val <- table(claimants["newclass"])
conf <- conf.val
#conf <- as.vector(table(claimants["newclass"]))
names(conf) <- c("FN", "FP", "TN", "TP")
conf
###
###Calcualtions
##Accuracy = TP+TN/ Sum(all)
Accuracy  <- (conf["TP"]+ conf["TN"])/(conf["TP"]+ conf["TN"]+conf["FP"]+ conf["FN"])
names(Accuracy) = c("accuracy")
Accuracy
#confusion<-table(prob>0.5,claimants$y)
#Accuracy<-sum(diag(confusion)/sum(confusion))
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

#names(cal) <- c("Accuracy", "Precision", "Specificity", "Sencitivity","TPR","FPR")

# Creating empty vectors to store predicted classes based on threshold value
#pred_values <- NULL
#yes_no <- NULL

#pred_values <- ifelse(prob>0.7,1,0)
#yes_no <- ifelse(prob>0.7,"yes","no")

# Creating new column to store the above values
#claimants[,"prob"] <- prob
#claimants[,"pred_values"] <- pred_values
#claimants[,"yes_no"] <- yes_no

#View(claimants[,c(1,2,7,8)])

#table(claimants$y,claimants$pred_values)
# Calculate the below metrics
# precision | recall | True Positive Rate | False Positive Rate | Specificity | Sensitivity
# from the above table - 59
# ROC Curve => used to evaluate the betterness of the logistic model
# more area under ROC curve better is the model 
# We will use ROC curve for any classification technique not only for logistic
library(ROCR)
rocrpred<-prediction(prob,affairs1$naffairs)
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

##Better cuttoff will be 0.5 as per graph, it is subjective.
