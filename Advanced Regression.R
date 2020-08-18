
numclaims <- read.table("E:/Data_Science_Okv/Datasets/new/numclaims.txt", header = T)

attach(numclaims)
summary(numclaims)

#vehins <- lm(numclaims ~ numveh + age, data = numclaims)

#summary(vehins)

vehins1 <- glm(numclaims ~ numveh + age, family = "poisson", data = numclaims)

summary(vehins1)

vehins2 <- glm(numclaims ~ age, family = "poisson", data = numclaims)

summary(vehins2)

# Ho: Model fits the data adequately
# Ha: Model does not fit the data adequately

with(vehins1, cbind(res.deviance = deviance, df = df.residual, 
                    p = pchisq(deviance, df.residual, lower.tail=FALSE)))

#=============================================
  # Poisson Model with Offset 
#=============================================
canins <-  read.table("E:/Data_Science_Okv/Datasets/new/canautoins.txt", header = T)


attach(canins)

str(canins)

Merit <- as.factor(Merit) # coerce or convert integer to factor

Class <- as.factor(Class) 
str(canins)
#
#
#
#
#
#




canins2 <-  data.frame (canins, Merit, Class)  # data frame can handle both numerical & non-numerical



# Y = X1 + X2 + X3

str(canins2)

caninsglm <-  glm (Claims ~ Merit.1 + Class.1 + Premium + Cost, offset = log(Insured), family = "poisson", data = canins2)

summary (caninsglm)


#====================================================
 # Negative binomial regression # Variance > Mean
#====================================================
  
ornstein <- read.table("E:/Data_Science_Okv/Datasets/new/ornsteindata.txt", header = T)

ornstein2 <- ornstein [, -1] # [rows, columns]

require(ggplot2)


require(foreign)

require(MASS)  # Install & load MASS package to execute glm.nb function

ornnbglm <- glm.nb(intrlcks ~., data = ornstein2) # mean Not Equal to variance

summary(ornnbglm)
#======================================================
  
#  Excessive Zeros
#======================================================
install.packages("pscl")
??pscl
library(pscl)
?bioChemists
data("bioChemists")
View(bioChemists)

zinegbio <- zeroinfl(art~., bioChemists, dist="negbin", link = "logit")

summary(zinegbio)


hurdlenegbio <- hurdle(art ~., data = bioChemists, dist = "negbin", zero = "negbin")

summary(hurdlenegbio)




