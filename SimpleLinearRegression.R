wcat <- read.csv("E:/Data_Science_Okv/Datasets/wc-at.csv")
attach(wcat)

summary(wcat)

plot(Waist, AT) # scatter plot
cor(Waist, AT) # correlation coefficient
  
model <- lm(AT ~ Waist) # linear regression
model
summary(model) # output and evaluating

predict(model)
model$residuals

confint(model,level=0.99)
predict(model, interval = "confidence")

rmse <- sqrt(mean(model$residuals^2))
rmse


  # Log model
plot(log(Waist), AT)
cor(log(Waist), AT)
model2 <- lm(AT ~ log(Waist)) # log transformation
summary(model2)

rmse2 <- sqrt(mean(model2$residuals^2))
rmse2


# Exp model
plot(Waist, log(AT))
cor(Waist, log(AT))
model3 <- lm(log(AT) ~ Waist) # exponential tranformation
summary(model3)
model3$residuals

log_at <- predict(model3,interval="confidence")
log_at
at <- exp(log_at)
at

err <- AT-at
err

rmse3 <- sqrt(mean(err^2))
rmse3


# Polynomial transformation
model4 <- lm(log(AT) ~ Waist + I(Waist * Waist))
summary(model4)

confint(model4,level=0.95)

log_res <- predict(model4,interval="confidence")
atpoly <- exp(log_res)
atpoly
err_poly <- AT - atpoly
err_poly

rmse4 <- sqrt(mean(err_poly^2))
rmse4

