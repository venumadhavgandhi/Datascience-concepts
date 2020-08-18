import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
from pandas import Series, DataFrame
from sklearn.model_selection import train_test_split
import seaborn as sns
data=pd.read_csv("D:/360digiTMG/supervised/mod 8 losso ridge regression/Datasets (2)/50_Startups.csv")
data.head()

# creating dummy variables to convert categorical into numeric values
mylist = list(data.select_dtypes(include=['object']).columns)

dummies = pd.get_dummies(data[mylist], prefix= mylist)

data.drop(mylist, axis=1, inplace = True)

X = pd.concat([data,dummies], axis =1 )

# Statistical measurements
X.describe()
pd.plotting.scatter_matrix(X)

# preparing model considering all the variables using sklearn library
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score

x=X.drop(["Profit"],axis=1)
y=X["Profit"].values.reshape(-1,1)

LR=LinearRegression()
LR.fit(x,y)
# Getting coefficients of variables               
LR.coef_
LR.intercept_

# Adjusted R-Squared value
LR.score(x,y) # 0.9507524843355148
pred1 = LR.predict(x)

# Rmse value
np.sqrt(np.mean((pred1-y)**2)) # 8854.761029414496

# Residuals Vs Fitted Values
plt.scatter(x=pred1,y=(pred1-y));plt.xlabel("Fitted");plt.ylabel("Residuals");plt.hlines(y=0,xmin=0,xmax=60)
# Checking normal distribution 
plt.hist(pred1-y)

# Predicted Vs MEDV
plt.scatter(x=pred1,y=y);plt.xlabel("Predicted");plt.ylabel("Actual")

from sklearn.model_selection import GridSearchCV
#For ridge regression, we introduce GridSearchCV. This will allow us to automatically perform 5-fold cross-validation with a range of different regularization parameters in order to find the optimal value of alpha.
from sklearn.linear_model import Ridge

ridge=Ridge()
parameters={'alpha': [1e-15,1e-10,1e-8,1e-4,1e-3,1e-2,1,5,10,20]}
ridge_regressor=GridSearchCV(ridge,parameters,scoring='neg_mean_squared_error',cv=5)
ridge_regressor.fit(x,y)

print(ridge_regressor.best_params_)
#{'alpha': 20}
print(ridge_regressor.best_score_)
#-97940997.5126576

from sklearn.linear_model import Lasso
lasso=Lasso()
parameters={'alpha': [1e-15,1e-10,1e-8,1e-4,1e-3,1e-2,1,5,10,20]}
lasso_regressor=GridSearchCV(lasso,parameters,scoring='neg_mean_squared_error',cv=5)
lasso_regressor.fit(x,y)

print(lasso_regressor.best_params_)
#{'alpha': 20}
print(lasso_regressor.best_score_)
#-102772500.47432792

