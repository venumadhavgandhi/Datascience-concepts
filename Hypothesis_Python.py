import pandas as pd
import scipy 
from scipy import stats
import statsmodels.api as sm

############2 sample T Test(Marketing Strategy) ##################
#############Normality test###############

promotion=pd.read_excel("E:\Data_Science_Okv\Datasets/Promotion.xlsx")
promotion

promotion.columns="Credit","Promotion.Type", "InterestRateWaiver","StandardPromotion"

prom = promotion.iloc[0:250,2:4]

##########Normality Test ############
print(stats.shapiro(prom.InterestRateWaiver))    #Shapiro Test
print(stats.shapiro(prom.StandardPromotion))
help(stats.shapiro)

######## Variance test #########
scipy.stats.levene(prom.InterestRateWaiver, prom.StandardPromotion)
help(scipy.stats.levene)
# p-value = 0.287 > 0.05 so p high null fly => Equal variances

######## 2 Sample T test ################
scipy.stats.ttest_ind(prom.InterestRateWaiver,prom.StandardPromotion)
help(scipy.stats.ttest_ind)



############# One - Way Anova###################
from statsmodels.formula.api import ols

cof=pd.read_excel("E:\Data_Science_Okv\Datasets/ContractRenewal_Data(unstacked).xlsx")
cof
cof.columns="SupplierA","SupplierB","SupplierC"

##########Normality Test ############

print(stats.shapiro(cof.SupplierA))    #Shapiro Test
print(stats.shapiro(cof.SupplierB))
print(stats.shapiro(cof.SupplierC))

############## Variance test #########
scipy.stats.levene(cof.SupplierA, cof.SupplierB)
scipy.stats.levene(cof.SupplierB, cof.SupplierC)
scipy.stats.levene(cof.SupplierC, cof.SupplierA)

############# One - Way Anova###################
mod = ols('SupplierA ~ SupplierB+SupplierC',data=cof).fit()

aov_table=sm.stats.anova_lm(mod, type=2)
help(sm.stats.anova_lm)

print(aov_table)

######## 2-proportion test ###########
import numpy as np

two_prop_test = pd.read_excel("E:\Data_Science_Okv\Datasets/JohnyTalkers.xlsx")
two_prop_test 
from statsmodels.stats.proportion import proportions_ztest

tab1 = two_prop_test.Adults.value_counts()
tab1
tab2 = two_prop_test.Children.value_counts()
tab2

count = np.array([58,152])
nobs = np.array([480,740])

stats,pval = proportions_ztest(count, nobs,alternative='two-sided') 
print(pval) # Pvalue- 0.000  
stats,pval = proportions_ztest(count, nobs,alternative='larger')
print(pval)  # Pvalue 0.999  


################Chi-Square Test ################

Bahaman=pd.read_excel("E:\Data_Science_Okv\Datasets/Bahaman.xlsx")
Bahaman

count=pd.crosstab(Bahaman["Defective"],Bahaman["Country"])
count
Chisquares_results=scipy.stats.chi2_contingency(count)

Chi_square=[['','Test Statistic','p-value'],['Sample Data',Chisquares_results[0],Chisquares_results[1]]]

print(Chi_square)