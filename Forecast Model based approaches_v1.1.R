library(readr)
Walmart <- read.csv(file.choose()) # read the Walmart data
View(Walmart) # Seasonality 12 months
 
# Pre Processing

# So creating 12 dummy variables 
X <- data.frame(outer(rep(month.abb,length = 159), month.abb,"==") + 0 )# Creating dummies for 12 months
colnames(X) <- month.abb # Assigning month names 
View(X)
WalmartFootfalls <- cbind(Walmart,X)
View(WalmartFootfalls)
colnames(WalmartFootfalls)

# input t
WalmartFootfalls["t"] <- c(1:159)
View(WalmartFootfalls)

WalmartFootfalls["log_footfalls"] <- log(WalmartFootfalls["Footfalls"])
WalmartFootfalls["t_square"] <- WalmartFootfalls["t"]*WalmartFootfalls["t"]
View(WalmartFootfalls)
## Preprocesing completed

attach(WalmartFootfalls)
# partitioning
train <- WalmartFootfalls[1:147,]
test <- WalmartFootfalls[148:159,]

########################### LINEAR MODEL #############################

linear_model <- lm(Footfalls ~ t, data = train)
summary(linear_model)
linear_pred <- data.frame(predict(linear_model, interval='predict', newdata =test))
rmse_linear <- sqrt(mean((test$Footfalls-linear_pred$fit)^2, na.rm = T))
rmse_linear

######################### Exponential #################################

expo_model <- lm(log_footfalls ~ t, data = train)
summary(expo_model)
expo_pred <- data.frame(predict(expo_model, interval='predict', newdata = test))
rmse_expo <- sqrt(mean((test$Footfalls-exp(expo_pred$fit))^2, na.rm = T))
rmse_expo

######################### Quadratic ####################################

Quad_model <- lm(Footfalls ~ t + t_square, data = train)
summary(Quad_model)
Quad_pred <- data.frame(predict(Quad_model, interval='predict', newdata=test))
rmse_Quad <- sqrt(mean((test$Footfalls-Quad_pred$fit)^2, na.rm=T))
rmse_Quad

######################### Additive Seasonality #########################

sea_add_model <- lm(Footfalls ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = train)
summary(sea_add_model)
sea_add_pred <- data.frame(predict(sea_add_model, newdata=test, interval = 'predict'))
rmse_sea_add <- sqrt(mean((test$Footfalls-sea_add_pred$fit)^2, na.rm = T))
rmse_sea_add

######################## Additive Seasonality with Quadratic #################

Add_sea_Quad_model <- lm(Footfalls ~ t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = train)
summary(Add_sea_Quad_model)
Add_sea_Quad_pred <- data.frame(predict(Add_sea_Quad_model, interval='predict', newdata=test))
rmse_Add_sea_Quad <- sqrt(mean((test$Footfalls - Add_sea_Quad_pred$fit)^2, na.rm=T))
rmse_Add_sea_Quad

######################## Multiplicative Seasonality #########################

multi_sea_model <- lm(log_footfalls ~ Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = train)
summary(multi_sea_model)
multi_sea_pred <- data.frame(predict(multi_sea_model, newdata=test, interval='predict'))
rmse_multi_sea <- sqrt(mean((test$Footfalls-exp(multi_sea_pred$fit))^2, na.rm = T))
rmse_multi_sea

# Preparing table on model and it's RMSE values 

table_rmse <- data.frame(c("rmse_linear","rmse_expo","rmse_Quad","rmse_sea_add","rmse_Add_sea_Quad","rmse_multi_sea"),c(rmse_linear,rmse_expo,rmse_Quad,rmse_sea_add,rmse_Add_sea_Quad,rmse_multi_sea))
colnames(table_rmse) <- c("model","RMSE")
View(table_rmse)

# Additive seasonality with Quadratic has least RMSE value

write.csv(WalmartFootfalls, file="WalmartFootfalls.csv", row.names = F)

############### Combining Training & test data to build Additive seasonality using Quadratic Trend ############

Add_sea_Quad_model_final <- lm(Footfalls ~ t+t_square+Jan+Feb+Mar+Apr+May+Jun+Jul+Aug+Sep+Oct+Nov, data = WalmartFootfalls)
summary(Add_sea_Quad_model_final)


####################### Predicting new data #############################
library(xlsx)
test_data <- read.xlsx(file.choose(),1)
View(test_data)
pred_new <- predict(Add_sea_Quad_model_final, newdata = test_data, interval = 'predict')
pred_new <- as.data.frame(pred_new)



plot(Add_sea_Quad_model_final)
acf(Add_sea_Quad_model_final$residuals, lag.max = 10) # take all residual value of the model built & plot ACF plot

A <- arima(Add_sea_Quad_model_final$residuals, order = c(1,0,0))
A$residuals

ARerrors <- A$residuals

acf(ARerrors, lag.max = 10)

# predicting next 12 months errors using arima( order =c(1,0,0))

library(forecast)
errors_12 <- forecast(A, h = 12)

View(errors_12)

future_errors <- data.frame(errors_12)
class(future_errors)
future_errors <- future_errors$Point.Forecast

# predicted values for new data + future error values 

predicted_new_values <- pred_new + future_errors

write.csv(predicted_new_values, file = "predicted_new_values.csv", row.names = F)
getwd()
