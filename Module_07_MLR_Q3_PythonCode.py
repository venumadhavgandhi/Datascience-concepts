###Questions 3 : Toyota Corolla test case
# Multilinear Regression
import pandas as pd
import numpy as np

# loading the data
Strt = pd.read_csv("E:/Data_Science_Okv/Datasets/new/ToyotaCorolla.csv",encoding='latin1')

Strt = Strt.iloc[:,2:19]
Strt.drop(['Mfg_Month','Mfg_Year','Fuel_Type', 'Met_Color','Color','Automatic','Cylinders','Mfr_Guarantee'], axis=1, inplace=True)
Strt.head()
list(Strt.columns) 
Strt.describe()

# Scatter plot between the variables along with histograms
import seaborn as sns
sns.pairplot(Strt.iloc[:,:])                             
# Correlation matrix 
Strt.corr()
# preparing model considering all the variables 
import statsmodels.formula.api as smf # for regression model
##model             
ml1 = smf.ols('Price ~ Age_08_04+KM+HP+cc+Doors+Gears+Quarterly_Tax+Weight',data=Strt).fit() 
# regression model
# Summary
ml1.summary()
# calculating VIF's values of independent variables
rsq_sp = smf.ols('Age_08_04~KM+HP+cc+Doors+Gears+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_sp = 1/(1-rsq_sp) 
##
rsq_mt = smf.ols('KM~Age_08_04+HP+cc+Doors+Gears+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_mt = 1/(1-rsq_mt)
##
rsq_ad = smf.ols('HP~Age_08_04+KM+cc+Doors+Gears+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_ad = 1/(1-rsq_ad) 
##
rsq_sp1 = smf.ols('cc~Age_08_04+KM+HP+Doors+Gears+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_sp1 = 1/(1-rsq_sp1) 
rsq_sp2 = smf.ols('Doors~Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_sp2 = 1/(1-rsq_sp2) 
rsq_sp3 = smf.ols('Gears~Doors+Age_08_04+KM+HP+cc+Quarterly_Tax+Weight',data=Strt).fit().rsquared  
vif_sp3 = 1/(1-rsq_sp3) 
rsq_sp4 = smf.ols('Quarterly_Tax~Gears+Doors+Age_08_04+KM+HP+cc+Weight',data=Strt).fit().rsquared  
vif_sp4 = 1/(1-rsq_sp4) 
rsq_sp5 = smf.ols('Weight~Quarterly_Tax+Gears+Doors+Age_08_04+KM+HP+cc',data=Strt).fit().rsquared  
vif_sp5 = 1/(1-rsq_sp5) 
# Storing vif values in a data frame
d1 = {'Variables':['Age','KM','HP','CC','DOORS','GEARS','QTAX','WEIGHT'],'VIF':[vif_sp,vif_mt,vif_ad,vif_sp1,vif_sp2,vif_sp3,vif_sp4,vif_sp5]}
Vif_frame = pd.DataFrame(d1)  
Vif_frame
# As weight is having higher VIF value, we are not going to include this prediction model
#
#  model
final_ml= smf.ols('Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight',data=Strt).fit()
final_ml.summary()
###finding influential onservataion
infl = final_ml.get_influence()
infl.plot_influence()
infl.plot_index(y_var='cooks', threshold=2 * infl.cooks_distance[0].mean())
infl.plot_index(y_var='resid', threshold=1)
# final model
##we need to delete 49th and 50th record
Strt.drop(Strt.index[[80]])
final_ml= smf.ols('Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight',data = Strt.drop(Strt.index[[80]])).fit()
final_ml.summary()
###
Startdat = Strt.drop(Strt.index[[80]])
#####LINE assumptions checking
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor
warnings.filterwarnings("ignore")
######
final_pred = final_ml.predict(Startdat)
errors = Startdat.Price - final_pred
###no collinearity probelm its verified in the middle of the program usging VIF 
####MEAN OF THE ERROR IS ZEROS
np.mean(errors)
###ploting linear erros are normally distributed and linearly distributed
sns.distplot(errors)
fig, ax = plt.subplots(figsize=(6,2.5))
_, (__, ___, r) = sp.stats.probplot(errors, plot=ax, fit=True)
###No autocorrelation of residuals
acf = smt.graphics.plot_acf(errors, lags=40 , alpha=0.05)
acf.show()
##Homoscedasticity problem 
fig, ax = plt.subplots(figsize=(6,2.5))
_ = ax.scatter(Startdat.Price, errors)
###matched with R squared value with R code value
##Errors
#####overfitting or under fitting
### Splitting the data into train and test data 
from sklearn.model_selection import train_test_split
Strt_train,Strt_test  = train_test_split(Startdat,test_size = 0.3) # 30% test data

# preparing the model on train data 
model_train = smf.ols('Price ~ Age_08_04+KM+HP+cc+Gears+Quarterly_Tax+Weight',data=Strt_train).fit()

# train_data prediction
train_pred = model_train.predict(Strt_train)

# train residual values 
train_resid  = train_pred - Startdat.Price

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) 

# prediction on test data set 
test_pred = model_train.predict(Strt_test)

# test residual values 
test_resid  = test_pred - Startdat.Price

# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) 