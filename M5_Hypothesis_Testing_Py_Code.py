###Question1
import numpy as np
import pandas as pd
import scipy 
from scipy import stats
import statsmodels.api as sm
cutlet=pd.read_csv("E:\Data_Science_Okv\Datasets/Cutlets.csv")
cutlet
cutlet.columns="Unit_A","Unit_B"
cutlet
cutlet = cutlet.iloc[0:35,0:2]
cutlet
##cutlet.dropna() 
cutlet = pd.DataFrame(cutlet)
print(stats.shapiro(cutlet.Unit_A))
## p value 0.3199819028377533
print(stats.shapiro(cutlet.Unit_B))
## pavlue  0.522498548030853
######## Variance test #########
scipy.stats.levene(cutlet.Unit_A, cutlet.Unit_B)
### pvalue=0.4176162212502553
######## 2 Sample T test ################
scipy.stats.ttest_ind(cutlet.Unit_A, cutlet.Unit_B)
#####pvalue=0.4722394724599501

###Questions 2
lab=pd.read_csv("E:\Data_Science_Okv\Datasets/LabTAT.csv")
lab
lab = lab.iloc[0:120,0:4]
lab
lab = pd.DataFrame(lab)
print(stats.shapiro(lab.lab1))
## p value 0.5506953597068787
print(stats.shapiro(lab.lab2))
## p value 0.8637524843215942
print(stats.shapiro(lab.lab3))
## p value  0.4205053448677063
print(stats.shapiro(lab.lab4))
## p value 0.6618951559066772
help(scipy.stats.bartlett)
######## Variance test #########
scipy.stats.levene(lab.lab1,lab.lab2)
####pvalue=0.06078228171776711
scipy.stats.levene(lab.lab2,lab.lab3)
####pvalue=pvalue=0.33220021420602397
scipy.stats.levene(lab.lab3,lab.lab4)
####pvalue=pvalue=0.15472618294425391
scipy.stats.levene(lab.lab4,lab.lab1)
 ######pvalue=0.22188001348277267
 ###P high H0 fly --all are hgaving equal variance
###oneway anov
from statsmodels.formula.api import ols
F, p = stats.f_oneway(lab['lab1'], lab['lab2'], lab['lab3'], lab['lab4'])
p
### 2.1156708949992414e-57  it is almost zero
F
###118.70421654401437
### p plow nulll go..

####Question 3:
buy=pd.read_csv("E:\Data_Science_Okv\Datasets/BuyerRatio.csv")
buy
buy1 = buy.iloc[0:2,1:5]
buy1
Chisquares_results=scipy.stats.chi2_contingency(buy1)
Chi_square=[['','Test Statistic','p-value'],['Sample Data',Chisquares_results[0],Chisquares_results[1]]]
print(Chi_square)
##[['', 'Test Statistic', 'p-value'], ['Sample Data', 1.595945538661058, 0.6603094907091882]]

### Question 4:
import pandas as pd
import scipy 
from scipy import stats
import statsmodels.api as sm
cof=pd.read_csv("E:\Data_Science_Okv\Datasets/CustomerOrderform.csv")
cof
cof1 = cof.iloc[0:300,0:4]
cof1
unique, counts1 = np.unique(cof1.Phillippines, return_counts=True)
unique, counts2 = np.unique(cof1.Indonesia, return_counts=True)
unique, counts3 = np.unique(cof1.Malta, return_counts=True)
unique, counts4 = np.unique(cof1.India, return_counts=True)
counts1
counts2
counts3
counts4
###
coff = np.array([counts1, counts2, counts3, counts4])
chi2_stat, p_val, dof, ex = stats.chi2_contingency(coff)
p_val
#####0.27710
###p high null fly --hence all are equal

###Question 5
fant=pd.read_csv("E:\Data_Science_Okv\Datasets/Fantaloons.csv")
fant
fant1 = fant.iloc[0:400,0:2]

Ntab1 = fant1.Weekdays.value_counts()
Ntab1
##Female    287
##Male      113
Ntab2 = fant1.Weekend.value_counts()
Ntab2
#Female    233
#Male      167
count = np.array([287,113])
nobs = np.array([233,167])
from statsmodels.stats.proportion import proportions_ztest
stats,pval = proportions_ztest(count, nobs)
pval
##p low null go-->
