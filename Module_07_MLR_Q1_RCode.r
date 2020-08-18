###Question 1 - Start up
install.packages("dummies")
library("dummies")
Strt <- read.csv(file.choose())
View(Strt)
attach(Strt)
###dummying the state column######
Strtup <- dummy.data.frame(Strt, names=c("State"), sep="_")
View(Strtup)
####chageing  the names according to my operation.
colnames(Strtup) <- c("Spend","Admin","Market","Cali","Florida","Newyork","Profit")
attach(Strtup)
View(Strtup)
####
summary(Strtup)
###
install.packages("Hmisc")
library(Hmisc)
###ploting for correlation
pairs(Strtup)
###correlation
cor(Strtup)
##model linear
attach(Strtup)
### Ther are 3 states - as Degree of freedome is 2  so newyork not mentioned.
model.strtup <- lm(Profit~Spend+Admin+Market+Cali+Florida)
summary(model.strtup)
##### checking the VIF
model.A <- lm(Profit~Admin)
summary(model.A)
model.M <- lm(Profit~Market)
summary(model.M)
model.AM <- lm(Profit~Admin+Market)
summary(model.A)
####
install.packages("car")
library(car)
####VIF on complete module
vif(model.strtup) # variance inflation factor
avPlots(model.strtup , id.n=2, id.cex=0.7)
##
attach(Strtup)
model1.strtup <- lm(Profit~Spend+Market)
summary(model1.strtup)

###Remove the unwanted rows.influential observation
influence.measures(model.strtup)
influenceIndexPlot(model.strtup,id.n=3)
influencePlot(model.strtup,id.n=3)

####deleting the 49th 50th record
attach(Strtup)
model2.strtup <- lm(Profit~Spend+Market, data = Strtup[-c(50,49),])
summary(model2.strtup)
###mode2.strtup is final model then evaluate the line assuptions
plot(model2.strtup)
qqPlot(model2.strtup, id.n=5)
##