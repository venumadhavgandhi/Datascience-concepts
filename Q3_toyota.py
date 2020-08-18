import pandas as pd 
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
# loading the data
Toyota = pd.read_csv("D:\\360digiTMG\\supervised\\mod 8 losso ridge regression\\Datasets (2)\\ToyotaCorolla.csv",encoding="latin",index_col=0)

# to get top 6 rows
Toyota.head(6) # to get top n rows use cars.head(10)

# Correlation matrix 
Toyota.corr()

# columns names
Toyota.columns
Toyota.shape

# Checking whether we have any missing values or not 
Toyota.isnull().sum() # there are no missing values 

# pick the required columns and drop the remaining columns 
data=Toyota[['Price','Age_08_04','KM','HP','cc','Doors','Gears','Quarterly_Tax','Weight']]

# Basic EDA
plt.scatter(x=np.arange(1436),y=data.Price)
plt.scatter(x=data.KM,y=data.Price,c="b");plt.xlabel("hd");plt.ylabel("Price")
plt.hist(data.KM) #  right skewed 
plt.hist(data.Price) # right skewed 

# Checking whether we have any missing values or not 
data.isnull().sum() # there are no missing values 

data.head(4)

# Statistical measurements
data.describe()
pd.plotting.scatter_matrix(data.iloc[:,1:9]) #; -> also used for plotting all in one graph

# preparing model considering all the variables using sklearn library
from sklearn.linear_model import LinearRegression
         
# Preparing model                  
LR1 = LinearRegression()
LR1.fit(data.iloc[:,1:9],data.Price)
# Getting coefficients of variables               
LR1.coef_
LR1.intercept_

# Adjusted R-Squared value
LR1.score(data.iloc[:,1:9],data.Price) #0.8637627463428192
pred1 = LR1.predict(data.iloc[:,1:9])

# Rmse value
np.sqrt(np.mean((pred1-data.Price)**2)) # 1338.258423620152

# Residuals Vs Fitted Values
plt.scatter(x=pred1,y=(pred1-data.Price));plt.xlabel("Fitted");plt.ylabel("Residuals");plt.hlines(y=0,xmin=0,xmax=60)
# Checking normal distribution 
plt.hist(pred1-data.Price)

# Predicted Vs Price
plt.scatter(x=pred1,y=data.Price);plt.xlabel("Predicted");plt.ylabel("Actual")
plt.bar(height = pd.Series(LR1.coef_),x=list(range(1,9)))

np.corrcoef(data.KM,data.Price) # -0.56996016
np.corrcoef(data.cc,data.Price) # 0.1263892

### Let us split our entire data set into training and testing data sets
from sklearn.model_selection import train_test_split
train,test = train_test_split(data,test_size=0.2)

### Preparing Ridge regression model for getting better weights on independent variables 
from sklearn.linear_model import Ridge

RM1 = Ridge(alpha = 0.4,normalize=True)
RM1.fit(train.iloc[:,1:9],train.Price)
# Coefficient values for all the independent variables
RM1.coef_
RM1.intercept_
plt.bar(height = pd.Series(RM1.coef_),x=pd.Series(data.columns[1:9]))
RM1.alpha # 0.4
pred_RM1 = RM1.predict(train.iloc[:,1:9])
# Adjusted R-Squared value 
RM1.score(train.iloc[:,1:9],train.Price) #  0.8364676128321539
# RMSE
np.sqrt(np.mean((pred_RM1-train.Price)**2)) # 1494.0588790940508


### Running a Ridge Regressor of set of alpha values and observing how the R-Squared, train_rmse and test_rmse are changing with change in alpha values
train_rmse = []
test_rmse = []
R_sqrd = []
alphas = np.arange(0,100,0.05)
for i in alphas:
    RM = Ridge(alpha = i,normalize=True)
    RM.fit(train.iloc[:,1:9],train.Price)
    R_sqrd.append(RM.score(train.iloc[:,1:9],train.Price))
    train_rmse.append(np.sqrt(np.mean((RM.predict(train.iloc[:,1:9]) - train.Price)**2)))
    test_rmse.append(np.sqrt(np.mean((RM.predict(test.iloc[:,1:9]) - test.Price)**2)))
    
    
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
LassoM1.fit(train.iloc[:,1:9],train.Price)
# Coefficient values for all the independent variables
LassoM1.coef_
LassoM1.intercept_
plt.bar(height = pd.Series(LassoM1.coef_),x=pd.Series(data.columns[1:9]))
LassoM1.alpha #  0.01
pred_LassoM1 = LassoM1.predict(train.iloc[:,1:9])
# Adjusted R-Squared value 
LassoM1.score(train.iloc[:,1:9],train.Price) # 0.8700477363192989
# RMSE
np.sqrt(np.mean((pred_LassoM1-train.Price)**2)) # 1331.8574646879433


### Running a LASSO Regressor of set of alpha values and observing how the R-Squared, train_rmse and test_rmse are changing with change in alpha values
train_rmse = []
test_rmse = []
R_sqrd = []
alphas = np.arange(0,30,0.05)
for i in alphas:
    LRM = Lasso(alpha = i,normalize=True,max_iter=500)
    LRM.fit(train.iloc[:,1:9],train.Price)
    R_sqrd.append(LRM.score(train.iloc[:,1:9],train.Price))
    train_rmse.append(np.sqrt(np.mean((LRM.predict(train.iloc[:,1:9]) - train.Price)**2)))
    test_rmse.append(np.sqrt(np.mean((LRM.predict(test.iloc[:,1:9]) - test.Price)**2)))
    
    
#### Plotting train_rmse,test_rmse,R_Squared values with respect to alpha values
# Alpha vs R_Squared values
plt.scatter(x=alphas,y=R_sqrd);plt.xlabel("alpha");plt.ylabel("R_Squared")

# Alpha vs train rmse
plt.scatter(x=alphas,y=train_rmse);plt.xlabel("alpha");plt.ylabel("train_rmse")

# Alpha vs test rmse
plt.scatter(x=alphas,y=test_rmse);plt.xlabel("alpha");plt.ylabel("test_rmse")
plt.legend(("alpha Vs R_Squared","alpha Vs train_rmse","alpha Vs test_rmse"))


# Checking whether data has any influential values 
# influence index plots
## Using regression model from statsmodels.formula.api
import statsmodels.formula.api as smf
formula = data.columns[0]+"~"+"+".join(data.columns[1:9])
model=smf.ols(formula,data=data).fit()

# For getting coefficients of the varibles used in equation
model.params

# P-values for the variables and R-squared value for prepared model
model.summary()

print(model.conf_int(0.05)) # 95% confidence interval

pred = model.predict(data.iloc[:,1:9]) # Predicted values of Price using the model
import statsmodels.api as sm
sm.graphics.influence_plot(model)
#remove influencing values

# Studentized Residuals = Residual/standard deviation of residuals
plt.scatter(pred,model.resid_pearson);plt.xlabel("Fitted");plt.ylabel("residuals");plt.hlines(y=0,xmin=0,xmax=60)
plt.hist(model.resid_pearson)


######  Linearity #########
# Observed values VS Fitted values
plt.scatter(data.Price,pred1,c="r");plt.xlabel("observed_values");plt.ylabel("fitted_values")

# Residuals VS Fitted Values 
plt.scatter(pred1,model.resid_pearson,c="r"),plt.axhline(y=0,color='blue');plt.xlabel("fitted_values");plt.ylabel("residuals")


########    Normality plot for residuals ######
# histogram
plt.hist(model.resid_pearson) # Checking the standardized residuals are normally distributed

# QQ plot for residuals 
import pylab          
import scipy.stats as st

# Checking Residuals are normally distributed
st.probplot(model.resid_pearson, dist="norm", plot=pylab)


############ Homoscedasticity #######

# Residuals VS Fitted Values 
plt.scatter(pred1,model.resid_pearson,c="r"),plt.axhline(y=0,color='blue');plt.xlabel("fitted_values");plt.ylabel("residuals")


# preparing the model on train data 

model_train = smf.ols(formula,data=train).fit()

# train_data prediction
train_pred = model_train.predict(train)

# train residual values 
train_resid  = train_pred - train.Price

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid))

# prediction on test data set 
test_pred = model_train.predict(test)

# test residual values 
test_resid  = test_pred - test.Price

# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid*test_resid))
