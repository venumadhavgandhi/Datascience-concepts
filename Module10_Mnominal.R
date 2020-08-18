# Multinomial Logit Model
# packages required
install.packages("mlogit")
require('mlogit')
install.packages("nnet")
require('nnet')
##load the dataset
pgm <- read.csv(file.choose())
#
View(pgm)
#
table(pgm$prog) # tabular representation of the Y categories
##academic  general vocation 
##105       45       50 
##data has in the form of catgeogical- convert them
attach(pgm)
pgm$fem <-ifelse(test=pgm$female == 'male',1,0)
pgm$mal <-ifelse(test=pgm$female == 'female',1,0)
###
pgm$ses_low <-ifelse(test=pgm$ses == 'low',1,0)
pgm$ses_mid <-ifelse(test=pgm$ses == 'middle',1,0)
pgm$ses_high <-ifelse(test=pgm$ses == 'high',1,0)
##
pgm$schtyp_public <-ifelse(test=pgm$schtyp == 'public',1,0)
pgm$schtyp_private <-ifelse(test=pgm$schtyp == 'private',1,0)
##
pgm$honors_enroll <-ifelse(test=pgm$honors == 'enrolled',1,0)
pgm$honors_notenroll <-ifelse(test=pgm$honors == 'not enrolled',1,0)
##
View(pgm)
##
attach(pgm)
##build the multi nominal model -
pgm.prog <- multinom(prog ~ pgm$fem+pgm$ses_low+pgm$ses_mid+pgm$schtyp_public+
           pgm$honors_enroll+pgm$read+pgm$write+pgm$math+pgm$science, data=pgm)
###
summary(pgm.prog)
#Choose the base line level for further processing.-general as selected for baseline
pgm$prog  <- relevel(pgm$prog, ref= "general")  # change the baseline level
#
##### Significance of Regression Coefficients###
z <- summary(pgm.prog)$coefficients / summary(pgm.prog)$standard.errors
p_value <- (1-pnorm(abs(z),0,1))*2
p_value
#(Intercept)   pgm$fem pgm$ses_low pgm$ses_mid pgm$schtyp_public pgm$honors_enroll
#general  0.1770892484 0.7657417  0.07593484  0.18455189        0.31124231         0.8878929
#vocation 0.0004505716 0.3900888  0.63908878  0.02643442        0.02822641         0.1005510
#pgm$read  pgm$write     pgm$math pgm$science
#general  0.07308977 0.34233927 0.0045596028 0.001139918
#vocation 0.05704661 0.01902905 0.0005523512 0.0465921
summary(pgm.prog)$coefficients
# odds ratio 
exp(coef(pgm.prog))
# predict probabilities
prob <- fitted(pgm.prog)
prob
# Find the accuracy of the model
class(prob)
prob <- data.frame(prob)
View(prob)
prob["pred_g"] <- NULL
# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}
pred_name <- apply(prob,1,get_names)
prob$pred_g <- pred_name
View(prob)
# Confusion matrix
table(pred_name,pgm$prog)
#pred_name  general academic vocation
#academic      22       86       17
#general       10       11        4
#vocation      13        8       29

# confusion matrix visualization
barplot(table(pred_name,pgm$prog),beside = T,col=c("red","lightgreen","blue"),legend=c("General","Vocational","Acedemic"),main = "Predicted(X-axis) - Legends(Actual)",ylab ="count")

# Accuracy 
mean(pred_name==pgm$prog) # 62.5 %
##another base line -vocation
pgm$prog  <- relevel(pgm$prog, ref= "vocation")  # change the baseline level

##### Significance of Regression Coefficients###
z <- summary(pgm.prog)$coefficients / summary(pgm.prog)$standard.errors
p_value <- (1-pnorm(abs(z),0,1))*2
p_value
summary(pgm.prog)$coefficients

# odds ratio 
exp(coef(pgm.prog))
# predict probabilities
prob <- fitted(pgm.prog)
prob
# Find the accuracy of the model
class(prob)
prob <- data.frame(prob)
View(prob)
prob["pred_v"] <- NULL

# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}

pred_name <- apply(prob,1,get_names)
#
prob$pred_v <- pred_name
View(prob)

# Confusion matrix
table(pred_name,pgm$prog)

#pred_name  vocation general academic
#academic       17      22       86
#general         4      10       11
#vocation       29      13        8

# confusion matrix visualization
barplot(table(pred_name,pgm$prog),beside = T,col=c("red","lightgreen","blue"),legend=c("General","Vocational","Acedemic"),main = "Predicted(X-axis) - Legends(Actual)",ylab ="count")

# Accuracy 
mean(pred_name==pgm$prog) # 62.5
##### select acaemic as baseline
pgm$prog  <- relevel(pgm$prog, ref= "academic")  # change the baseline level

##### Significance of Regression Coefficients###
z <- summary(pgm.prog)$coefficients / summary(pgm.prog)$standard.errors
p_value <- (1-pnorm(abs(z),0,1))*2
p_value
summary(pgm.prog)$coefficients

# odds ratio 
exp(coef(pgm.prog))


# predict probabilities
prob <- fitted(pgm.prog)
prob

# Find the accuracy of the model

class(prob)
prob <- data.frame(prob)
View(prob)
prob["pred_a"] <- NULL

# Custom function that returns the predicted value based on probability
get_names <- function(i){
  return (names(which.max(i)))
}

pred_name <- apply(prob,1,get_names)

prob$pred_a <- pred_name
View(prob)

# Confusion matrix
table(pred_name,pgm$prog)
#pred_name  academic vocation general
#academic       86       17      22
#general        11        4      10
#vocation        8       29      13

# confusion matrix visualization
barplot(table(pred_name,pgm$prog),beside = T,col=c("red","lightgreen","blue"),legend=c("General","Vocational","Acedemic"),main = "Predicted(X-axis) - Legends(Actual)",ylab ="count")

# Accuracy
mean(pred_name==pgm$prog) # 62.5 %

