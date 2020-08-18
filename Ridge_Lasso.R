Cars <- read.csv(file.choose()) # loading the data 

attach(Cars)

# predicting the mileage of a vechile without ML
mpg1 <- mean(Cars$MPG)

# Error in Prediction
# AV - PV
err1 <- Cars$MPG - mean(Cars$MPG)
View(err1)

# RMSE
MSE1 <- mean(err1^2)
###########################

# Linear regression

m2 <- lm(MPG ~ HP)
summary(m2)
predMPG1 <- predict(m2, data=Cars)
MSE2 <- mean(m2$residuals)^2

# Accuracy is determined by R^2 for linear regression models
# R^2 = 52.57%

# Consider more variables to increase complexity
m3 <- lm(MPG ~ HP + VOL + SP + WT)
summary(m3)

# R^2 = 77.05%

predMPG2 <- predict(m3, data=Cars)
MSE3 <- mean(m3$residuals)^2


# Residual plot
plot(Cars$MPG, predMPG1)

barplot(sort(m3$coefficients), ylim=c(-0.5, 5))


# Regularization methods
#########################

# Converting the data into compatible format in which model accepts 
cars_x <- model.matrix(MPG~.-1,data=Cars)
cars_y <- Cars$MPG
install.packages("glmnet")
library(glmnet)

# Lambda is the hyperparameter to tune the ridge regression

# glmnet automatically selects the range of λ values
# setting lamda as 10^10 till 10^-2
lambda <- 10^seq(10, -2, length = 50)

# For ridge alpha = 0

# Note: glmnet() function standardizes the variables to get them on to same scale by default. 

ridge_reg <- glmnet(cars_x,cars_y,alpha=0,lambda=lambda)
summary(ridge_reg)

# ----------
# Below graph shows how the coefficients vary with change in lambda
# With increase in lambda the coefficients value converges to 0 
plot(ridge_reg,xvar="lambda",label=T)

# ridge regression coefficients, stored in a matrix 
dim(coef(ridge_reg))
plot(ridge_reg)

ridge_reg$lambda[1]  #Display 1st lambda value
coef(ridge_reg)[,1] # Display coefficients associated with 50th lambda value
sqrt(sum(coef(ridge_reg)[-1,1]^2)) # Calculate L2 norm

ridge_reg$lambda[50]
coef(ridge_reg)[,50] 
sqrt(sum(coef(ridge_reg)[-1,41]^2)) # Calculate L2 norm
# Larger L2 norm for smaller values of lamda

# ------------


#######
# Partitioning Data into training set and testing set

train <- Cars[1:60,]
test <- Cars[61:81,]

x_train <- model.matrix(MPG~.-1,data=train)
y_train <- train$MPG

x_test <- model.matrix(MPG~.-1,data=test)
y_test <- test$MPG

### Ridge Regression

ridge_mod = glmnet(x_train, y_train, alpha=0, lambda = lambda)
plot(ridge_mod) 

ridge_pred = predict(ridge_mod, s = -2, newx = x_test)
mean((ridge_pred - y_test)^2)

# Fit ridge regression model on training data
cv.out = cv.glmnet(x_train, y_train, alpha = 0) 

# Select lamda that minimizes training MSE
bestlam = cv.out$lambda.min  
bestlam

# Draw plot of training MSE as a function of lambda
plot(cv.out) 

# predicting on test data with best lambda
ridge_pred1 = predict(ridge_mod, s = bestlam, newx = x_test)
mean((ridge_pred1 - y_test)^2) # Calculate test MSE


###
# LASSO Regression

# Fit lasso model on training data
lasso_mod = glmnet(x_train,y_train, alpha = 1, lambda = lambda)

plot(lasso_mod)    # Draw plot of coefficients

cv.out = cv.glmnet(x_train, y_train, alpha = 1) # Fit lasso model on training data

plot(cv.out) # Draw plot of training MSE as a function of lambda

bestlam_lasso = cv.out$lambda.min # Select lamda that minimizes training MSE
bestlam_lasso
# Use best lambda to predict test data
lasso_pred = predict(lasso_mod, s = bestlam_lasso, newx = x_test)

mean((lasso_pred - y_test)^2) # Calculate test MSE

# Fit lasso model on full dataset
out = glmnet(cars_x, cars_y, alpha = 1, lambda = lambda) 

# Display coefficients using lambda chosen by CV
lasso_coef = predict(out, type = "coefficients", s = bestlam)[1:5,] 
lasso_coef

## The End
###########
###########


##############
     
# Using n fold cross validation to build ridge regression 
# it will consider (n-1) part of data as training data
# left over data as validation data 

ridge_reg_cv <- cv.glmnet(cars_x,cars_y,alpha=0,lambda=lambda,nfolds = 5)
plot(ridge_reg_cv)

# Getting the optimum value of lambda for which we are going to get best model 
opt_lambda <- ridge_reg_cv$lambda.min

# Getting the model parameter 
model_ridge <- ridge_reg_cv$glmnet.fit
# Predicting the values with model paramter and optimum value of 
# lambda 

cars_pred <- predict(model_ridge,s=opt_lambda,newx =cars_x)
SST <- sum(cars_y^2) # Total sum of squares 
SSE <- sum((cars_pred-cars_y)^2) # Sum of Squared errors 
R_Squared <- 1-SSE/SST # 0.98 
RMSE <- sqrt(mean((cars_pred-cars_y)^2))
resid_cars <- cars_pred-cars_y
# Residual Vs fitted values 
plot(cars_pred,resid_cars);abline(h=0,col="red")


### LASSO REGRESSION #############

# Applying Lasso regression 
# Lambda is the hyperparameter to tune the Lasso regression
lambda <- 10^seq(3,-2,by=-0.1) # set of values for lambda 
# for lasso we choose alpha = 1
lasso_reg <- glmnet(cars_x,cars_y,alpha=1,lambda=lambda)
summary(lasso_reg)
# Below graph shows how the coefficients varry with change in lambda
# With increase in lambda the coefficients value converges to 0 
plot(lasso_reg,xvar="lambda",label=T)

# Using n fold cross validation to build lasso regression 
# it will consider (n-1) part of data as training data
# left over data as validation data 
lasso_reg_cv <- cv.glmnet(cars_x,cars_y,alpha=1,lambda=lambda,nfolds = 5)
plot(lasso_reg_cv)
# Getting the optimum value of lambda for which we
# are going to get best model 
opt_lambda <- lasso_reg_cv$lambda.min
# Getting the model parameter 
model_lasso <- lasso_reg_cv$glmnet.fit
# Predicting the values with model paramter and optimum value of 
# lambda 

cars_pred <- predict(model_lasso,s=opt_lambda,newx =cars_x)
SST <- sum(cars_y^2) # Total sum of squares 
SSE <- sum((cars_pred-cars_y)^2) # Sum of Squared errors 
R_Squared <- 1-SSE/SST # 0.98 
RMSE <- sqrt(mean((cars_pred-cars_y)^2))
resid_cars <- cars_pred-cars_y
# Residual Vs fitted values 
plot(cars_pred,resid_cars);abline(h=0,col="red")
coef(model_lasso,s=opt_lambda)
# weight has been dropped out the same thing we have observed 
# in multiple linear regression 







###### ELASTIC REGRESSION ######### 

# Lambda is the hyperparameter to tune the elastic regression
lambda <- 10^seq(3,-2,by=-0.1) # set of values for lambda 
# for elastic we choose alpha = 0.5
elastic_reg <- glmnet(cars_x,cars_y,alpha=0.5,lambda=lambda)
summary(elastic_reg)
# Below graph shows how the coefficients varry with change in lambda
# With increase in lambda the coefficients value converges to 0 
plot(elastic_reg,xvar="lambda",label=T)

# Using n fold cross validation to build elastic regression 
# it will consider (n-1) part of data as training data
# left over data as validation data 
elastic_reg_cv <- cv.glmnet(cars_x,cars_y,alpha=1,lambda=lambda,nfolds = 5)
plot(elastic_reg_cv)
# Getting the optimum value of lambda for which we
# are going to get best model 
opt_lambda <- elastic_reg_cv$lambda.min
# Getting the model parameter 
model_elastic <- elastic_reg_cv$glmnet.fit
# Predicting the values with model paramter and optimum value of 
# lambda 

cars_pred <- predict(model_elastic,s=opt_lambda,newx =cars_x)
SST <- sum(cars_y^2) # Total sum of squares 
SSE <- sum((cars_pred-cars_y)^2) # Sum of Squared errors 
R_Squared <- 1-SSE/SST # 0.98 
RMSE <- sqrt(mean((cars_pred-cars_y)^2))
resid_cars <- cars_pred-cars_y
# Residual Vs fitted values 
plot(cars_pred,resid_cars);abline(h=0,col="red")
coef(model_elastic,s=opt_lambda)
# weight has been dropped out the same thing we have observed 
# in multiple linear regression 
