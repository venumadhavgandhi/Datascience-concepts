# Multilinear Regression
import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt

# loading the data
housing = pd.read_csv("E:\\Bokey\\Excelr Data\\Python Codes\\all_py\\Ridge and Lasso Regression\\housing.csv")

# to get top 6 rows
housing.head(6) # to get top n rows use cars.head(10)

# Correlation matrix 
housing.corr()

# there isn't much high correlation among the independent variables
# Chance of having multicollinearity problem is less
 
# Scatter plot between the variables along with histograms
import seaborn as sns
sns.pairplot(housing)

# columns names
housing.columns
housing.shape
# Basic EDA
plt.scatter(x=np.arange(506),y=housing.CRIM)
plt.scatter(x=housing.CRIM,y=housing.MEDV,c="b");plt.xlabel("CRIM");plt.ylabel("MEDV")
plt.hist(housing.CRIM) # complete right skewed 
plt.hist(housing.MEDV) # close to normal distribution

# Statistical measurements
housing.describe()
pd.tools.plotting.scatter_matrix(housing) #; -> also used for plotting all in one graph

# Checking whether we have any missing values or not 
housing.isnull().sum() # there are no missing values 

housing.head(4)

# Boxplots of all the columns
housing.boxplot()

# Histograms of all the columns 
housing.hist()

# preparing model considering all the variables using sklearn library
from sklearn.linear_model import LinearRegression
         
# Preparing model                  
LR1 = LinearRegression()
LR1.fit(housing.iloc[:,:13],housing.MEDV)
# Getting coefficients of variables               
LR1.coef_
LR1.intercept_

# Adjusted R-Squared value
LR1.score(housing.iloc[:,:13],housing.MEDV) # 0.74064
pred1 = LR1.predict(housing.iloc[:,:13])

# Rmse value
np.sqrt(np.mean((pred1-housing.MEDV)**2)) # 4.6791

# Residuals Vs Fitted Values
plt.scatter(x=pred1,y=(pred1-housing.MEDV));plt.xlabel("Fitted");plt.ylabel("Residuals");plt.hlines(y=0,xmin=0,xmax=60)
# Checking normal distribution 
plt.hist(pred1-housing.MEDV)

# Predicted Vs MEDV
plt.scatter(x=pred1,y=housing.MEDV);plt.xlabel("Predicted");plt.ylabel("Actual")
plt.bar(height = pd.Series(LR1.coef_),left = housing.columns[:13])

# When we look at the weights assigned to each independent columns we see that there is high magnitude assigned for NOX
# But there is high correlation is existing between output and RM variable 
np.corrcoef(housing.NOX,housing.MEDV) # -0.427
np.corrcoef(housing.RM,housing.MEDV) # 0.695

### Let us split our entire data set into training and testing data sets
from sklearn.model_selection import train_test_split
train,test = train_test_split(housing,test_size=0.2)

### Preparing Ridge regression model for getting better weights on independent variables 
from sklearn.linear_model import Ridge

RM1 = Ridge(alpha = 0.4,normalize=True)
RM1.fit(train.iloc[:,:13],train.MEDV)
# Coefficient values for all the independent variables
RM1.coef_
RM1.intercept_
plt.bar(height = pd.Series(RM1.coef_),left=pd.Series(housing.columns[:13]))
RM1.alpha # 0.05
pred_RM1 = RM1.predict(train.iloc[:,:13])
# Adjusted R-Squared value 
RM1.score(train.iloc[:,:13],train.MEDV) # 0.7342
# RMSE
np.sqrt(np.mean((pred_RM1-train.MEDV)**2)) # 4.8227


### Running a Ridge Regressor of set of alpha values and observing how the R-Squared, train_rmse and test_rmse are changing with change in alpha values
train_rmse = []
test_rmse = []
R_sqrd = []
alphas = np.arange(0,100,0.05)
for i in alphas:
    RM = Ridge(alpha = i,normalize=True)
    RM.fit(train.iloc[:,:13],train.MEDV)
    R_sqrd.append(RM.score(train.iloc[:,:13],train.MEDV))
    train_rmse.append(np.sqrt(np.mean((RM.predict(train.iloc[:,:13]) - train.MEDV)**2)))
    test_rmse.append(np.sqrt(np.mean((RM.predict(test.iloc[:,:13]) - test.MEDV)**2)))
    
    
#### Plotting train_rmse,test_rmse,R_Squared values with respect to alpha values


# Alpha vs R_Squared values
plt.scatter(x=alphas,y=R_sqrd);plt.xlabel("alpha");plt.ylabel("R_Squared")

# Alpha vs train rmse
plt.scatter(x=alphas,y=train_rmse);plt.xlabel("alpha");plt.ylabel("train_rmse")

# Alpha vs test rmse
plt.scatter(x=alphas,y=test_rmse);plt.xlabel("alpha");plt.ylabel("test_rmse")
plt.legend(("alpha Vs R_Squared","alpha Vs train_rmse","alpha Vs test_rmse"))

# We got minimum R_Squared value at small alpha values 


# Let us prepare Lasso Regression on data set
from sklearn.linear_model import Lasso
LassoM1 = Lasso(alpha = 0.01,normalize=True)
LassoM1.fit(train.iloc[:,:13],train.MEDV)
# Coefficient values for all the independent variables
LassoM1.coef_
LassoM1.intercept_
plt.bar(height = pd.Series(LassoM1.coef_),left=pd.Series(housing.columns[:13]))
LassoM1.alpha # 0.05
pred_LassoM1 = LassoM1.predict(train.iloc[:,:13])
# Adjusted R-Squared value 
LassoM1.score(train.iloc[:,:13],train.MEDV) # 0.12
# RMSE
np.sqrt(np.mean((pred_LassoM1-train.MEDV)**2)) # 4.951


### Running a LASSO Regressor of set of alpha values and observing how the R-Squared, train_rmse and test_rmse are changing with change in alpha values
train_rmse = []
test_rmse = []
R_sqrd = []
alphas = np.arange(0,30,0.05)
for i in alphas:
    LRM = Lasso(alpha = i,normalize=True,max_iter=500)
    LRM.fit(train.iloc[:,:13],train.MEDV)
    R_sqrd.append(LRM.score(train.iloc[:,:13],train.MEDV))
    train_rmse.append(np.sqrt(np.mean((LRM.predict(train.iloc[:,:13]) - train.MEDV)**2)))
    test_rmse.append(np.sqrt(np.mean((LRM.predict(test.iloc[:,:13]) - test.MEDV)**2)))
    
    
#### Plotting train_rmse,test_rmse,R_Squared values with respect to alpha values

# Alpha vs R_Squared values
plt.scatter(x=alphas,y=R_sqrd);plt.xlabel("alpha");plt.ylabel("R_Squared")

# Alpha vs train rmse
plt.scatter(x=alphas,y=train_rmse);plt.xlabel("alpha");plt.ylabel("train_rmse")

# Alpha vs test rmse
plt.scatter(x=alphas,y=test_rmse);plt.xlabel("alpha");plt.ylabel("test_rmse")
plt.legend(("alpha Vs R_Squared","alpha Vs train_rmse","alpha Vs test_rmse"))

# We got minimum R_Squared value at small alpha values 
# from this we can say applying the simple linear regression technique is giving better results than Ridge and Lasso
# alpha tends 0 it indicates that Lasso and Ridge approximates to normal regression techniques 



# Checking whether data has any influential values 
# influence index plots
## Using regression model from statsmodels.formula.api
import statsmodels.formula.api as smf
formula = housing.columns[13]+"~"+"+".join(housing.columns[:13])
model=smf.ols(formula,data=housing).fit()

# For getting coefficients of the varibles used in equation
model.params

# P-values for the variables and R-squared value for prepared model
model.summary()
# Age and Indus

print (model.conf_int(0.05)) # 95% confidence interval

pred = model.predict(housing.iloc[:,:13]) # Predicted values of MEDV using the model
import statsmodels.api as sm
sm.graphics.influence_plot(model)
# index 380 AND 418 is showing high influence so we can exclude that entire row
# Studentized Residuals = Residual/standard deviation of residuals
plt.scatter(pred,model.resid_pearson);plt.xlabel("Fitted");plt.ylabel("residuals");plt.hlines(y=0,xmin=0,xmax=60)
plt.hist(model.resid_pearson)

housing_new = housing.drop(housing.index[[418]],axis=0)

model2=smf.ols(formula,data=housing_new).fit()

# For getting coefficients of the varibles used in equation
model2.params

# P-values for the variables and R-squared value for prepared model
model2.summary()
# Age and Indus

print (model2.conf_int(0.05)) # 95% confidence interval

pred2 = model2.predict(housing_new.iloc[:,:13]) # Predicted values of MEDV using the model


# Studentized Residuals = Residual/standard deviation of residuals
plt.scatter(pred2,model2.resid_pearson);plt.xlabel("Fitted");plt.ylabel("residuals");plt.hlines(y=0,xmin=0,xmax=60)
plt.hist(model2.resid_pearson)


import statsmodels.api as sm
# added variable plot for the final model
sm.graphics.plot_partregress_grid(model2)


######  Linearity #########
# Observed values VS Fitted values
plt.scatter(housing_new.MEDV,pred2,c="r");plt.xlabel("observed_values");plt.ylabel("fitted_values")

# Residuals VS Fitted Values 
plt.scatter(pred2,model2.resid_pearson,c="r"),plt.axhline(y=0,color='blue');plt.xlabel("fitted_values");plt.ylabel("residuals")


########    Normality plot for residuals ######
# histogram
plt.hist(model2.resid_pearson) # Checking the standardized residuals are normally distributed

# QQ plot for residuals 
import pylab          
import scipy.stats as st

# Checking Residuals are normally distributed
st.probplot(model2.resid_pearson, dist="norm", plot=pylab)


############ Homoscedasticity #######

# Residuals VS Fitted Values 
plt.scatter(pred2,model2.resid_pearson,c="r"),plt.axhline(y=0,color='blue');plt.xlabel("fitted_values");plt.ylabel("residuals")


# preparing the model on train data 

model_train = smf.ols(formula,data=train).fit()

# train_data prediction
train_pred = model_train.predict(train)

# train residual values 
train_resid  = train_pred - train.MEDV

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid))

# prediction on test data set 
test_pred = model_train.predict(test)

# test residual values 
test_resid  = test_pred - test.MEDV

# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid*test_resid))

