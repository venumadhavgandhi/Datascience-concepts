# Multinomial Logit Model
# packages required
install.packages("mlogit")
require('mlogit')
install.packages("nnet")
require('nnet')

#In built dataset
data()
data(Mode)
?Mode
head(Mode)
tail(Mode)
View(Mode)

table(Mode$choice) # tabular representation of the Y categories

?Mode # learn more about the dataset

Mode.choice <- multinom(choice ~ cost.car + cost.carpool + cost.bus + cost.rail + time.car + time.carpool + time.bus + time.rail, data=Mode)
summary(Mode.choice)

Mode$choice  <- relevel(Mode$choice, ref= "carpool")  # change the baseline level

##### Significance of Regression Coefficients###
z <- summary(Mode.choice)$coefficients / summary(Mode.choice)$standard.errors
p_value <- (1-pnorm(abs(z),0,1))*2

summary(Mode.choice)$coefficients
p_value

# odds ratio 
exp(coef(Mode.choice))

# predict probabilities
prob <- fitted(Mode.choice)
prob

# Find the accuracy of the model

class(prob)
prob <- data.frame(prob)
View(prob)
prob["pred"] <- NULL

# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}

pred_name <- apply(prob,1,get_names)
?apply
prob$pred <- pred_name
View(prob)

# Confusion matrix
table(pred_name,Mode$choice)

# confusion matrix visualization
barplot(table(pred_name,Mode$choice),beside = T,col=c("red","lightgreen","blue","orange"),legend=c("bus","car","carpool","rail"),main = "Predicted(X-axis) - Legends(Actual)",ylab ="count")


# Accuracy 
mean(pred_name==Mode$choice) # 69.31 %
