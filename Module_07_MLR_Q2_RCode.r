###Question 2 computer analysis
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
