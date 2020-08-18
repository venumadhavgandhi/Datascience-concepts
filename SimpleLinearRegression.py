# For reading data set
# importing necessary libraries
import pandas as pd # deals with data frame  
import numpy as np  # deals with numerical values

wcat = pd.read_csv("E:\Data_Science_Okv\Datasets/wc-at.csv")

import matplotlib.pylab as plt #for different types of plots

plt.scatter(x=wcat['Waist'], y=wcat['AT'],color='green')# Scatter plot

np.corrcoef(wcat.Waist, wcat.AT) #correlation

help(np.corrcoef)

import statsmodels.formula.api as smf

model = smf.ols('AT ~ Waist', data=wcat).fit()
model.summary()


pred1 = model.predict(pd.DataFrame(wcat['Waist']))
pred1
print (model.conf_int(0.01)) # 99% confidence interval

res = wcat.AT - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)
rmse

######### Model building on Transformed Data

# Log Transformation
# x = log(waist); y = at
plt.scatter(x=np.log(wcat['Waist']),y=wcat['AT'],color='brown')
np.corrcoef(np.log(wcat.Waist), wcat.AT) #correlation

model2 = smf.ols('AT ~ np.log(Waist)',data=wcat).fit()
model2.summary()

pred2 = model2.predict(pd.DataFrame(wcat['Waist']))
pred2
print(model2.conf_int(0.01)) # 99% confidence level

res2 = wcat.AT - pred2
sqres2 = res2*res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)
rmse2
# Exponential transformation
plt.scatter(x=wcat['Waist'], y=np.log(wcat['AT']),color='orange')

np.corrcoef(wcat.Waist, np.log(wcat.AT)) #correlation

model3 = smf.ols('np.log(AT) ~ Waist',data=wcat).fit()
model3.summary()

pred_log = model3.predict(pd.DataFrame(wcat['Waist']))
pred_log
pred3 = np.exp(pred_log)
pred3
print(model3.conf_int(0.05)) # 99% confidence level

res3 = wcat.AT - pred3
sqres3 = res3*res3
mse3 = np.mean(sqres3)
rmse3 = np.sqrt(mse3)
rmse3

