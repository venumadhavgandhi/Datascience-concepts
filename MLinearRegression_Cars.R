Cars <- read.csv(file.choose())
attach(Cars)

# Exploratory data analysis:
# 1. Measures of central tendency
# 2. Measures of dispersion
# 3. Third moment business decision
# 4. Fourth moment business decision
# 5. Probability distributions of variables 
# 6. Graphical representations (Histogram, Box plot, Dot plot, Stem & Leaf plot, Bar plot, etc.)

summary(Cars)
install.packages("Hmisc")
library(Hmisc)

# 7. Find the correlation between Output (MPG) & inputs (HP, VOL, SP, WT) - SCATTER DIAGRAM
pairs(Cars)

# 8. Correlation coefficient Matrix - Strength & Direction of correlation
cor(Cars)
##Check the paritial correaltion

# The Linear Model of interest
model.car <- lm(MPG~VOL+HP+SP+WT)
summary(model.car)
####Remove the unwanted rows.influential observation
influence.measures(model.car)
influenceIndexPlot(model.car,id.n=3)
influencePlot(model.car,id.n=3)

####deleting the 77th record
model.car1 <- lm(MPG ~ VOL+HP+SP+WT, data = Cars[-77,])
summary(model.car1)

library(car)
## which one is more dependent
vif(model.car) # variance inflation factor
avPlots(model.car , id.n=2, id.cex=0.7)
###building model
model2 <- lm(MPG~VOL+HP+SP)
summary(model2)
####line assumptions
###evalation of line command
plot(model.car)
qqPlot(model.car, id.n=5)
###Partitioning
n=nrow(Cars)
n1=n*0.7
n2=n-n1
train=sample(1:n,n1)
test=Cars[-train,]
#####train the model on test data
pred=predict(model2,newdat=test)
actual=test$MPG
####error 
error=actual-pred
###rmse

test.rmse=sqrt(mean(error**2))
test.rmse
###rmse for train
train.rmse = sqrt(mean(model2$residuals**2))
train.rmse
