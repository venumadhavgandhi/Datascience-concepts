warnings.filterwarnings("ignore")
######
final_pred = final_ml.predict(Startdat)
errors = Startdat.Profit - final_pred
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
_ = ax.scatter(Startdat.Profit, errors)
###matched with R squared value with R code value
##Errors
#####overfitting or under fitting
### Splitting the data into train and test data 
from sklearn.model_selection import train_test_split
Strt_train,Strt_test  = train_test_split(Startdat,test_size = 0.3) # 30% test data

# preparing the model on train data 
model_train = smf.ols("Profit~Spend+Market",data=Strt_train).fit()

# train_data prediction
train_pred = model_train.predict(Strt_train)

# train residual values 
train_resid  = train_pred - Startdat.Profit

# RMSE value for train data 
train_rmse = np.sqrt(np.mean(train_resid*train_resid)) 

# prediction on test data set 
test_pred = model_train.predict(Strt_test)

# test residual values 
test_resid  = test_pred - Startdat.Profit

# RMSE value for test data 
test_rmse = np.sqrt(np.mean(test_resid*test_resid)) 