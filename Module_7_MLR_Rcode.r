###Question 1
install.packages("dummies")
library("dummies")
Strt <- read.csv(file.choose())
View(Strt)
attach(Strt)
###dummying the state column
Strtup <- dummy.data.frame(Strt, names=c("State"), sep="_")
View(Strtup)
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
###degree of freedome -so newyork not mentioned.
model.strtup <- lm(Profit~Spend+Admin+Market+Cali+Florida)
summary(model.strtup)
#####
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
###Question 2
install.packages("dummies")
library("dummies")
Computer_Data <- read.csv(file.choose())
View(Computer_Data)
attach(Computer_Data)
Computer_Data$cd_Yes <-ifelse(test=Computer_Data$cd == 'yes',1,0)
Computer_Data$cd_Yes <- as.factor(Computer_Data$cd_Yes) 
Computer_Data$multi_Yes <-ifelse(test=Computer_Data$multi == 'yes',1,0)
Computer_Data$multi_Yes <- as.factor(Computer_Data$multi_Yes) 
Computer_Data$premium_Yes <-ifelse(test=Computer_Data$premium == 'yes',1,0) 
Computer_Data$premium_Yes <- as.factor(Computer_Data$premium_Yes) 
#####
Computer_Data$cd_No <-ifelse(test=Computer_Data$cd == 'no',1,0)
Computer_Data$cd_No <- as.factor(Computer_Data$cd_No) 
Computer_Data$multi_No <-ifelse(test=Computer_Data$multi == 'no',1,0)
Computer_Data$multi_No <- as.factor(Computer_Data$multi_No) 
Computer_Data$premium_No <-ifelse(test=Computer_Data$premium == 'no',1,0) 
Computer_Data$premium_No <- as.factor(Computer_Data$premium_No)
###dummying 
View(Computer_Data)
attach(Computer_Data)
Cmpprce <- Computer_Data[,-1]
Cmpprce <- Cmpprce[,-(6:8)]
str(Cmpprce)
View(Cmpprce)
attach(Cmpprce)
####
summary(Cmpprce)
###
install.packages("Hmisc")
library(Hmisc)
###ploting for correlation
pairs(Cmpprce)
###correlation
cor(Cmpprce)
##model linear
attach(Cmpprce)
####regression
model.start <- lm(price~speed+hd+ram+screen+cd_Yes+multi_Yes+premium_Yes+ads+trend)
summary(model.start)
###
install.packages("car")
library(car)
####VIF on complete module
vif(model.start) # variance inflation factor
avPlots(model.start , id.n=2, id.cex=0.7)
##
###Remove the unwanted rows.influential observation
influence.measures(model.start)
influenceIndexPlot(model.start,id.n=3)
influencePlot(model.start,id.n=3)

####deleting the 1441,1701 record
attach(Cmpprce)
model1.start <- lm(price~speed+hd+ram+screen+cd_Yes+multi_Yes+premium_Yes+ads+trend, data = Cmpprce[-c(1441,1701),])
summary(model1.start)
###mode2.strtup is final model then evaluate the line assuptions
plot(model1.start)
qqPlot(model1.start, id.n=5)

###Question 3
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
