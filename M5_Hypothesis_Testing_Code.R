### Question 1  : Cutelt :
cutlet<-read.csv(file.choose())
attach(cutlet)
View(cutlet)
###Normality Test
shapiro.test(Unit.A)
#####	Shapiro-Wilk normality test
#####  data:  Unit.A
##### W = 0.96495, p-value = 0.32
shapiro.test(Unit.B)
#####  Shapiro-Wilk normality test
#####  data:  Unit.B
#####  W = 0.97273, p-value = 0.5225
####Variance Test:
var.test(Unit.A,Unit.B)
######	F test to compare two variances
#### data:  Unit.A and Unit.B
### F = 0.70536, num df = 34, denom df = 34, p-value = 0.3136
### alternative hypothesis: true ratio of variances is not equal to 1
### 95 percent confidence interval:
###  0.3560436 1.3974120
#### sample estimates:
### ratio of variances 
####         0.7053649

####2 Sample t – test:
t.test(Unit.A,Unit.B,alternative = "two.sided",conf.level = 0.95)
###	Welch Two Sample t-test
## data:  Unit.A and Unit.B
### t = 0.72287, df = 66.029, p-value = 0.4723
### alternative hypothesis: true difference in means is not equal to 0
### 95 percent confidence interval:
###  -0.09654633  0.20613490
### sample estimates:
### mean of x mean of y 
###  7.019091  6.964297 
####Questions 2 : A hospital wants to determine whether there is any difference in the average 
####Turn around Time (TAT) of reports of the laboratories on their preferred list 
lab <-read.csv(file.choose())
attach(lab)
View(lab)
shapiro.test(lab1)
##	Shapiro-Wilk normality test
## data:  lab1
## W = 0.99018, p-value = 0.5508
shapiro.test(lab2)
##	Shapiro-Wilk normality test
## data:  lab2
## W = 0.99363, p-value = 0.8637
shapiro.test(lab3)
##	Shapiro-Wilk normality test
##data:  lab3
## W = 0.98863, p-value = 0.4205
shapiro.test(lab4)
##	Shapiro-Wilk normality test
## data:  lab4
## W = 0.99138, p-value = 0.6619
#### Variance Test:
##
lab_group <- c(rep('lab1',120),rep('lab2',120),rep('lab3',120),rep('lab4',120))
trntime <- c(lab$lab1,lab$lab2,lab$lab3,lab$lab4)
lab_tim <- data.frame(lab_group,trntime)
plot(trntime~lab_group,data=lab_tim)
bartlett.test(trntime ~ lab_group,data=lab_tim)
#Bartlett test of homogeneity of variances
#data:  trntime by lab_group
#Bartlett's K-squared = 6.0995, df = 3, p-value = 0.1069
###One-way ANOV test:
##> Stacked_Data <- stack(lab)
##> Stacked_Data
##> attach(Stacked_Data)
##> colnames(Stacked_Data)
###[1] "values" "ind"  
Anova_results <- aov(trntime~lab_group, data = lab_tim)
summary(Anova_results)
##              Df Sum Sq Mean Sq F value Pr(>F)    
## ind           3  79979   26660   118.7 <2e-16 ***
## Residuals   476 106905     225                   
## Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
####Questions 3 : Sales of products in four different regions is tabulated for males and females
buy <-read.csv(file.choose())
View(buy)
Stacked_Data <- stack(buy[,2:5])
Stacked_Data
chisq.test(Stacked_Data$ind,Stacked_Data$values)
###Pearson's Chi-squared test
###data:  Stacked_Data$ind and Stacked_Data$values
###X-squared = 24, df = 21, p-value = 0.2931

#### Questions 4 : TeleCall uses 4 centers around the globe to process customer order forms. They audit a certain % of the customer order forms
cof <-read.csv(file.choose())
View(cof)
cof1 <- cof[1:300,1:4]
##remove unwanted data
##convert them into vector
cof1$Phillippines <- as.vector(cof1$Phillippines)
cof1$Indonesia <- as.vector(cof1$Indonesia)
cof1$Malta <- as.vector(cof1$Malta)
cof1$India <- as.vector(cof1$India)
####stacking the data
stacked_cof<-stack(cof1)
attach(stacked_cof)
View(stacked_cof)
table(stacked_cof$ind,stacked_cof$values)              
##               Defective Error Free
##   Phillippines        29        271
##   Indonesia           33        267
##   Malta               31        269
##  India               20        280
chisq.test(table(stacked_cof$ind,stacked_cof$values))
##	Pearson's Chi-squared test
## data:  table(stacked_cof$ind, stacked_cof$values)
## X-squared = 3.859, df = 3, p-value = 0.2771

#### Questions 5 Fantaloons Sales managers commented that % of males versus females walking in to the store differ based on day of the week
fant <-read.csv(file.choose())
View(fant)
###removing the unwanted data
fant <- fant[1:400,1:2]
attach(fant)
###converting into vector format else we will get the no vector error
fant$Weekdays <- as.vector(fant$Weekdays)
fant$Weekend <- as.vector(fant$Weekend)
stack_fant <- stack(fant)
View(stack_fant)
table(stack_fant$values,stack_fant$ind)
prop.test(table(stack_fant$ind,stack_fant$values),conf.level = 0.95)
##
##	2-sample test for equality of proportions with continuity correction
##
## data:  table(stack_fant$ind, stack_fant$values)
## X-squared = 15.434, df = 1, p-value = 8.543e-05
## hypothesis: two.sided
##95 percent confidence interval:
## 0.06706189 0.20293811
##sample estimates:
##prop 1 prop 2 
##0.7175 0.58


