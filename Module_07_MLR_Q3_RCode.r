###Question 3 ###Consider only the below columns and prepare a prediction model for predicting Price.
install.packages("dummies")
library("dummies")
Computer_Data <- read.csv(file.choose())
View(Computer_Data)
attach(Computer_Data)
Tayot <- Computer_Data[,c('Price','Age_08_04','KM','HP','cc','Doors','Gears','Quarterly_Tax','Weight')]
str(Tayot)
View(Tayot)
attach(Tayot)
####
summary(Tayot)
###
install.packages("Hmisc")
library(Hmisc)
###ploting for correlation
pairs(Tayot)
###correlation
cor(Tayot)
##model linear
attach(Tayot)
###degree of freedome 
model.q3 <- lm(Price ~ Age_08_04+KM+HP+cc+Doors+Gears+Quarterly_Tax+Weight,data = Tayot)
summary(model.q3)
###
install.packages("car")
library(car)
####VIF on complete module
vif(model.q3) # variance inflation factor
avPlots(model.q3 , id.n=2, id.cex=0.7)
##removing door column
model2.q3 <- lm(Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight,data = Tayot)
summary(model2.q3)

###Remove the unwanted rows.influential observation
influence.measures(model2.q3)
influenceIndexPlot(model2.q3,id.n=3)
influencePlot(model2.q3,id.n=3)

####deleting the 81th record
attach(Tayot)
model3.q3 <- lm(Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight,data = Tayot[-c(81),])
summary(model3.q3)
###mode2.strtup is final model then evaluate the line assuptions
plot(model3.q3)
qqPlot(model3.q3, id.n=5)
