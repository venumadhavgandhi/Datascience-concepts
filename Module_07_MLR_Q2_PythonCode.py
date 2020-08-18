####QUESTION2 COMPUTER SALE
# Multilinear Regression
import pandas as pd
import numpy as np

# loading the data
Strt = pd.read_csv("E:/Data_Science_Okv/Datasets/new/Computer_Data.csv")
####pd.get.dummies(Strt.State)
Strt['cd_Yes'] =Strt.cd.map({'yes':1 ,'no':0})
Strt['cd_No'] =Strt.cd.map({'yes':0 ,'no':1})
Strt['multi_Yes'] =Strt.multi.map({'yes':1 ,'no':0})
Strt['multi_No'] =Strt.multi.map({'yes':0 ,'no':1})
Strt['premium_Yes'] =Strt.premium.map({'yes':1 ,'no':0})
Strt['premium_No'] =Strt.premium.map({'yes':0 ,'no':1})

Strt.drop('cd', axis=1, inplace=True)
Strt.drop('multi', axis=1, inplace=True)
Strt.drop('premium', axis=1, inplace=True)
Strt = Strt.iloc[:,1:]
Strt.head()
list(Strt.columns) 
Strt.describe()

# Scatter plot between the variables along with histograms
import seaborn as sns
sns.pairplot(Strt.iloc[:,:])                             
# Correlation matrix 
Strt.corr()
#
# preparing model considering all the variables 
import statsmodels.formula.api as smf # for regression model
##model             
ml1 = smf.ols('price ~ speed+hd+ram+screen+ads+trend+cd_Yes+multi_Yes+premium_Yes',data=Strt).fit() 
# regression model
# Summary
ml1.summary()
#  model
final_ml= smf.ols('price ~ speed+hd+ram+screen+ads+trend+cd_Yes+multi_Yes+premium_Yes',data=Strt).fit()
final_ml.summary()
###finding influential onservataion
infl = final_ml.get_influence()
infl.plot_influence()
infl.plot_index(y_var='cooks', threshold=2 * infl.cooks_distance[0].mean())
infl.plot_index(y_var='resid', threshold=1)
# final model
##we need to delete 49th and 50th record
Strt.drop(Strt.index[[1440,1700]])
final_ml= smf.ols('price ~ speed+hd+ram+screen+ads+trend+cd_Yes+multi_Yes+premium_Yes',data = Strt.drop(Strt.index[[1440,1700]])).fit()
final_ml.summary()
###
Startdat = Strt.drop(Strt.index[[1440,1700]])
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
errors = Startdat.price - final_pred
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
_ = ax.scatter(Startdat.price, errors)
###matched with R squared value with R code value
##Errors
#####overfitting or under fitting
### Splitting the data into train and test data 
from sklearn.model_selection import train_test_split
Strt_train,Strt_test  = train_test_split(Startdat,test_size = 0.3) # 30% test data

# preparing the model on train data 
model_train = smf.ols('price ~ speed+hd+ram+screen+ads+trend+cd_Yes+multi_Yes+premium_Yes',data=Strt_train).fit()

# train_data prediction
train_pred = model_train.predict(Strt_train)

# train residual values 
train_resid  = train_pred - Startdat.price

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) 

# prediction on test data set 
test_pred = model_train.predict(Strt_test)

# test residual values 
test_resid  = test_pred - Startdat.price

# RMSE value for test data 
