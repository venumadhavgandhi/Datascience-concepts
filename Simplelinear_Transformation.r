### Question :1 Calories_consumed-> predict weight gained using calories consumed
calories_consumed <- read.csv(file.choose())
attach(calories_consumed)
colnames(calories_consumed)<-c("Weight","Calories") 
###scatter plot visualization
plot(Calories,Weight)
### correlation parameter r ranges from -1 to +1
attach(calories_consumed)
cor(Calories,Weight)
### [1] 0.946991
### Relationship is stron so build the linear model
model1 <- lm(Weight ~ Calories)
###R-squared:  0.8968
summary(model1)
##predicting the point of time value and erro
predict(model1)
model1$residuals
## find the co-efficient parameters with 95% confidence.
confint(model1,level=0.95)
###                   2.5 %       97.5 %
###(Intercept) -845.4266546 -406.0780569
###Calories       0.3305064    0.5098069
##predicting the model with 95% confidence.
predict(model1, interval = "confidence")
##errorRMSE
rmse1 <- sqrt(mean(model1$residuals^2))
rmse1
###[1] 103.3025
#####Exponential
#####(Calories,log(Weight))
plot(Calories,log(Weight))
cor(Calories,log(Weight))
model2 <- lm(log(Weight) ~ Calories)
summary(model2)
####R-squared:  0.8776
predict(model2)
model2$residuals
confint(model2,level=0.95)
log_at <- predict(model2,interval="confidence")
log_at
Wt <- exp(log_at)
err <- Weight - Wt
rmse2 <- sqrt(mean(err^2))
rmse2
###[1] 215.6436
#####(Weight ~ log(Calories))
### log transformation
plot(log(Calories),Weight)
cor(log(Calories),Weight)
##0.89
model3 <- lm(Weight ~ log(Calories))
summary(model3)
###R-squared:  0.8077,
predict(model3)
model3$residuals
confint(model3,level=0.95)
predict(model3,interval="confidence")
rmse3 <- sqrt(mean(model3$residuals^2))
rmse3
##141.00

###Polynomial
plot(Calories + I(Calories * Calories),log(Weight))
cor(Calories + I(Calories * Calories),log(Weight))
model4 <- lm(log(Weight) ~ Calories  + I(Calories  * Calories ))
summary(model4)
confint(model4,level=0.95)
log_res <- predict(model4,interval="confidence")
atpoly <- exp(log_res)
err_poly <- Weight - atpoly
rmse4 <- sqrt(mean(err_poly^2))

###Question 2: Delivery_time -> Predict delivery time using sorting time 

Prdtime <- read.csv(file.choose())
View(Prdtime)
colnames(Prdtime) <- c("Dtime","Stime")
attach(Prdtime)
plot(Stime,Dtime)
cor(Stime,Dtime)
###[1] 0.8259973
model1 <- lm(Dtime ~ Stime)
summary(model1)
### Multiple R-squared:  0.6823,	Adjusted R-squared:  0.6655 
##F-statistic:  40.8 on 1 and 19 DF,  p-value: 3.983e-06
predict(model1)
confint(model1,level=0.95)
##               2.5 %    97.5 %
## (Intercept) 2.979134 10.186334
## Stime       1.108673  2.189367
predict(model1, interval = "confidence")
rmse1 <- sqrt(mean(model1$residuals^2))
rmse1
##[1] 2.79165
##Exoponential Transformation
#####(Stime,log(Dtime))
plot(Stime,log(Dtime))
cor(Stime,log(Dtime))
##84%
model2 <- lm(log(Dtime) ~ Stime)
summary(model2)
####Multiple R-squared:  0.71 
predict(model2)
model2$residuals
confint(model2,level=0.95)
log_at <- predict(model2,interval="confidence")
log_at
Wt <- exp(log_at)
err <- Dtime - Wt
rmse2 <- sqrt(mean(err^2))
rmse2
###[1] 3.3771
### log transformation
plot(log(Stime),Dtime)
cor(log(Stime),Dtime)
##0.833
model3 <- lm(Dtime ~ log(Stime))
summary(model3)
##Multiple R-squared:  0.6954,	Adjusted R-squared:  0.6794
predict(model3)
model3$residuals
confint(model3,level=0.95)
predict(model3,interval="confidence")
rmse3 <- sqrt(mean(model3$residuals^2))
rmse3
##2.744
###Polynomial
plot(Stime + I(Stime * Stime),log(Dtime))
cor(Stime + I(Stime * Stime),log(Dtime))
79.3
model4 <- lm(log(Dtime) ~ Stime  + I(Stime  * Stime ))
summary(model4)
##76%
confint(model4,level=0.95)
log_res <- predict(model4,interval="confidence")
atpoly <- exp(log_res)
err_poly <- Dtime - atpoly
rmse4 <- sqrt(mean(err_poly^2))
rmse4
##3.326
###Quwstion 3 Emp_data -> Build a prediction model for Churn_out_rate.
empd <- read.csv(file.choose())
View(Empd)
colnames(Empd) <- c("S_Hike","C_rate")
attach(Empd)
plot(C_rate,S_Hike)
cor(C_rate,S_Hike)
##[1] 0.911
model1 <- lm(S_Hike ~ C_rate)
summary(model1)
### Multiple R-squared:  0.8312,	Adjusted R-squared:  0.8101 
predict(model1)
confint(model1,level=0.95)
##               2.5 %    97.5 %
## ((Intercept) 2064.19292      2506.537671
### C_rate       -11.19332   -5.178839
predict(model1, interval = "confidence")
rmse1 <- sqrt(mean(model1$residuals^2))
rmse1
##[1] 35.89
##Exoponential Transformation
#####(C_rate,log(S_Hike))
plot(C_rate,log(S_Hike))
cor(C_rate,log(S_Hike))
##92%
model2 <- lm(log(S_Hike) ~ C_rate)
summary(model2)
####Multiple R-squared:  0.8486
predict(model2)
model2$residuals
confint(model2,level=0.95)
log_at <- predict(model2,interval="confidence")
log_at
Wt <- exp(log_at)
err <- S_Hike - Wt
rmse2 <- sqrt(mean(err^2))
rmse2
###[1] 46.21
### log transformation
plot(log(C_rate),S_Hike)	
cor(log(C_rate),S_Hike)
##0.9346
model3 <- lm(S_Hike ~ log(C_rate))
summary(model3)
##Multiple R-squared:  0.8735
predict(model3)
model3$residuals
confint(model3,level=0.95)
predict(model3,interval="confidence")
rmse3 <- sqrt(mean(model3$residuals^2))
rmse3
##31.06
###Polynomial
plot(C_rate + I(C_rate * C_rate),log(S_Hike))
cor(C_rate + I(C_rate * C_rate),log(S_Hike))
##89.6
model4 <- lm(log(S_Hike) ~ C_rate  + I(C_rate  * C_rate ))
summary(model4)
## 0.9786
confint(model4,level=0.95)
log_res <- predict(model4,interval="confidence")
atpoly <- exp(log_res)
err_poly <- S_Hike - atpoly
rmse4 <- sqrt(mean(err_poly^2))
rmse4
##20.53

###Question 4 : slaray hikes
Hikes <- read.csv(file.choose())
attach(Hikes)
colnames(Hikes)<-c("Exprnc","Salry")
attach(Hikes)
###scatter plot visualization
plot(Exprnc,Salry)
### correlation parameter r ranges from -1 to +1
attach(Hikes)
cor(Exprnc,Salry)
### 0.9782416
### Relationship is stron so build the linear model
model1 <- lm(Salry ~ Exprnc)
###R-squared:   0.957
summary(model1)
##predicting the point of time value and erro
predict(model1)
model1$residuals
## find the co-efficient parameters with 95% confidence.
confint(model1,level=0.95)
###2.5 %   97.5 %
###  (Intercept) 21136.061 30448.34
##Exprnc         8674.119 10225.81
predict(model1, interval = "confidence")
##errorRMSE
rmse1 <- sqrt(mean(model1$residuals^2))
rmse1
###[1] 5592.044
#####Exponential
#####(Exprnc,log(Salry))
plot(Exprnc,log(Salry))
cor(Exprnc,log(Salry))
##0.9653844
model2 <- lm(log(Salry) ~ Exprnc)
summary(model2)
####R-squared:  0.932
predict(model2)
model2$residuals
confint(model2,level=0.95)
log_at <- predict(model2,interval="confidence")
log_at
Wt <- exp(log_at)
err <- Salry - Wt
rmse2 <- sqrt(mean(err^2))
rmse2
###[1] 8177.02
#####(Salry ~ log(Exprnc))
### log transformation
plot(log(Exprnc),Salry)
cor(log(Exprnc),Salry)
##0.9240611
model3 <- lm(Salry ~ log(Exprnc))
summary(model3)
###R-squared:  0.8539,
predict(model3)
model3$residuals
confint(model3,level=0.95)
predict(model3,interval="confidence")
rmse3 <- sqrt(mean(model3$residuals^2))
rmse3
##10302.89

###Polynomial
plot(Exprnc + I(Exprnc * Exprnc),log(Salry))
cor(Exprnc + I(Exprnc * Exprnc),log(Salry))
##] 0.9211302
model4 <- lm(log(Salry) ~ Exprnc  + I(Exprnc  * Exprnc ))
summary(model4)
##R-squared 0.9486
confint(model4,level=0.95)
log_res <- predict(model4,interval="confidence")
atpoly <- exp(log_res)
err_poly <- Salry - atpoly
rmse4 <- sqrt(mean(err_poly^2))
rmse4
###6676.884



