# Hypothesis Testing

# Load the Dataset
library(readxl)

# 2 sample t Test

######## Promotion.xlsx data ##########

Promotion<-read_excel(file.choose())
attach(Promotion)
colnames(Promotion)<-c("Credit","Promotion.Type","InterestRateWaiver","StandardPromotion")

# Changing column names
View(Promotion)
attach(Promotion)

#############Normality test###############

shapiro.test(InterestRateWaiver)
# p-value = 0.2246 >0.05 so p high null fly => It follows normal distribution

shapiro.test(StandardPromotion)
# p-value = 0.1916 >0.05 so p high null fly => It follows normal distribution

#############Variance test###############

var.test(InterestRateWaiver,StandardPromotion)#variance test
# p-value = 0.653 > 0.05 so p high null fly => Equal variances

############2 sample t Test ###############

t.test(InterestRateWaiver,StandardPromotion,alternative = "two.sided",conf.level = 0.95)#two sample T.Test
# alternative = "two.sided" means we are checking for equal and unequal
# means
# null Hypothesis -> Equal means
# Alternate Hypothesis -> Unequal Hypothesis
# p-value = 0.02523 < 0.05 accept alternate Hypothesis 
# unequal means

?t.test
t.test(InterestRateWaiver,StandardPromotion,alternative = "greater",var.equal = T)

# alternative = "greater means true difference is greater than 0
# Null Hypothesis -> (InterestRateWaiver-StandardPromotion) < 0
# Alternative Hypothesis -> (StandardPromotion - InterestRateWaiver) > 0
# p-value = 0.01211 < 0.05 => p low null go => accept alternate hypothesis
# InterestRateWaiver better promotion than StandardPromotion


#############Anova (Contract_Renewal Data )##########
CRD <- read_excel(file.choose())
View(CRD)
attach(CRD)

# Normality test
shapiro.test(`Supplier A`)
shapiro.test(`Supplier B`)
shapiro.test(`Supplier C`)

# Variance test
var.test(`Supplier A`,`Supplier B`)
var.test(`Supplier B`,`Supplier C`)
var.test(`Supplier C`,`Supplier A`)

Stacked_Data <- stack(CRD)
?stack
View(Stacked_Data)

attach(Stacked_Data)
colnames(Stacked_Data)

Anova_results <- aov(values~ind, data = Stacked_Data)
summary(Anova_results)
?aov
# p-value = 0.104 > 0.05 accept null hypothesis
# 3 suppliers transaction times are equal

###################Proportional T Test(JohnyTalkers data)##########
Johnytalkers<-read_excel(file.choose())   # JohnyTalkers.xlsx
View(Johnytalkers) 
attach(Johnytalkers)
table1 <- table(Adults)
table1
table2 <- table(Children)
table2
?prop.test
prop.test(x=c(58,152),n=c(480,740),conf.level = 0.95,alternative = "two.sided")
# two. sided -> means checking for equal proportions of Adults and children under purchased
# p-value = 6.261e-05 < 0.05 accept alternate hypothesis i.e.
# Unequal proportions 

prop.test(x=c(58,152),n=c(480,740),conf.level = 0.95,alternative = "greater")
# Ha -> Proportions of Adults > Proportions of Children
# Ho -> Proportions of Children > Proportions of Adults
# p-value = 0.999 > 0.05 accept null hypothesis 
# so proportion of Children > proportion of children 
# Do not launch the ice cream shop


#########Chi Square(Bahaman Research)#################

Bahaman<-read_excel(file.choose()) # Bahaman.xlsx
View(Bahaman)
attach(Bahaman)
table(Country,Defective)

chisq.test(table(Country,Defective))

# p-value = 0.6315 > 0.05  => Accept null hypothesis
# => All countries have equal proportions 

# All Proportions all equal 
# Customer order form 
# Unstacked data 

cof<-read_excel(file.choose()) # customer_order(unstacked).xlsx
View(cof) # countries are in their own columns; so we need to stack the data 
stacked_cof<-stack(cof)
attach(stacked_cof)
View(stacked_cof)
table(stacked_cof$ind,stacked_cof$values)
chisq.test(table(stacked_cof$ind,stacked_cof$values))
