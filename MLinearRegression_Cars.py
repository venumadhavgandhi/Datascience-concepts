# Multilinear Regression
import pandas as pd
import numpy as np

# loading the data
Strt = pd.read_csv("E:/Data_Science_Okv/Datasets/new/50_Startups.csv")
####pd.get.dummies(Strt.State)
Strt['State_Cali'] =Strt.State.map({'California':1 ,'Florida':0,'New York':0})
Strt['State_Florida'] =Strt.State.map({'California':0 ,'Florida':1,'New York':0})
Strt['State_Newyork'] =Strt.State.map({'California':0 ,'Florida':0,'New York':1})
Strt.drop('State', axis=1, inplace=True)
Strt.head()
list(Strt.columns) 
Strt.describe()

# Scatter plot between the variables along with histograms
import seaborn as sns
sns.pairplot(Strt.iloc[:,:])
                             
# Correlation matrix 
Strt.corr()

###Rename the columns
Strt.rename(columns = {'R&D Spend':'Spend','Administration':'Admin','Marketing Spend':'Market'},
            inplace = True)

# preparing model considering all the variables 
import statsmodels.formula.api as smf # for regression model
##model         
ml1 = smf.ols('Profit~Spend+Admin+Market+State_Cali+State_Florida',data=Strt).fit() 
# regression model
# Summary
ml1.summary()
# calculating VIF's values of independent variables
rsq_sp = smf.ols('Spend~Admin+Market',data=Strt).fit().rsquared  
vif_sp = 1/(1-rsq_sp) 
##
rsq_mt = smf.ols('Market~Spend+Admin',data=Strt).fit().rsquared  
vif_mt = 1/(1-rsq_mt)
##
rsq_ad = smf.ols('Admin~Spend+Market',data=Strt).fit().rsquared  
vif_ad = 1/(1-rsq_ad) 
##
# Storing vif values in a data frame
d1 = {'Variables':['Spend','Market','Admin'],'VIF':[vif_sp,vif_mt,vif_ad]}
Vif_frame = pd.DataFrame(d1)  
Vif_frame
# As weight is having higher VIF value, we are not going to include this prediction model
#
#  model
final_ml= smf.ols('Profit~Spend+Market',data = Strt).fit()
final_ml.summary()
###finding influential onservataion
infl = final_ml.get_influence()
infl.plot_influence()
infl.plot_index(y_var='cooks', threshold=2 * infl.cooks_distance[0].mean())
infl.plot_index(y_var='resid', threshold=1)
# final model
##we need to delete 49th and 50th record
Strt.drop(Strt.index[[48,49]])
final_ml= smf.ols('Profit~Spend+Market',data = Strt.drop(Strt.index[[48,49]])).fit()
final_ml.summary()
###matched with R squared value with R code value
##Errors
### Splitting the data into train and test data 
from sklearn.model_selection import train_test_split
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data

# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()

# train_data prediction
train_pred = model_train.predict(S)

# train residual values 
train_resid  = train_pred - Strt_train.Profit

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) 

# prediction on test data set 
test_pred = model_train.predict(Strt_test)

# test residual values 
test_resid  = test_pred - Strt_test.Profit

# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) 

# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(Strt_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.Profitmpo
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.MPG
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
# prediction on test data set 
test_pred = model_train.predict(cars_test)
train_resid  = train_pred - Strt_train.Profit
Strt_train,Strt_test  = train_test_split(Strt,test_size = 0.3) # 30% test data
# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()
# train_data prediction
train_pred = model_train.predict(Strt_train)
# train residual values 
train_resid  = train_pred - Strt_train.Profit
# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) # 4.04 
test_pred = model_train.predict(Strt_test)
test_resid  = test_pred - Strt_test.MPG
test_resid  = test_pred - Strt_test.Profit
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) # 3.16
test_rmse
test_pred
import matplotlib.pyplot as plt
import scipy as sp
import scipy as sp
import seaborn as sns
import statsmodels.api as sm
import statsmodels.tsa.api as smt
import warnings
from google.colab import drive
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from statsmodels.stats.outliers_influence import variance_inflation_factor

warnings.filterwarnings("ignore")
X_with_constant = sm.add_constant(Strt_test)
model = sm.OLS(Strt_test, X_with_constant)
results = model.fit()
results.params
results = model.fit()
results.params

sns.distplot(train_resid)
fig, ax = plt.subplots(figsize=(6,2.5))
_, (__, ___, r) = sp.stats.probplot(train_resid, plot=ax, fit=True)