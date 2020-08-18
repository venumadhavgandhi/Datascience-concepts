import pandas as pd # deals with data frame  
import numpy as np  # deals with numerical values
import matplotlib.pylab as plt #for different types of plots
import statsmodels.formula.api as smf

calrs = pd.read_csv("E:\Data_Science_Okv\Datasets/calories_consumed.csv")
calrs
calrs.columns = "weight","cal"
calrs
#####*without any trasnformation
plt.scatter(x=calrs['cal'], y=calrs['weight'],color='green')# Scatter plot
##
np.corrcoef(calrs.cal, calrs.weight) #correlation
##0.94699101
help(np.corrcoef)
##
model = smf.ols('weight ~ cal', data=calrs).fit()
model.summary()
###R-squared:                       0.897
pred1 = model.predict(pd.DataFrame(calrs['cal']))
pred1
print (model.conf_int(0.05)) # 95% confidence interval

res = calrs.weight - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)
print("remse of module is ", rmse)
###103.30250194726932
####exponenital
plt.scatter(x=calrs['cal'], y=np.log(calrs['weight']),color='green')
###
np.corrcoef(calrs.cal, np.log(calrs.weight))

##[0.93680369
model2= smf.ols('(np.log(weight)) ~ cal',data=calrs).fit()
model2.summary()
model2.conf_int(0.05)
## 0.878
pred_log = model2.predict(pd.DataFrame(calrs['cal']))
pred_log
pred2 = np.exp(pred_log)
pred2
print(model2.conf_int(0.05)) # 95% confidence level

res2 = calrs.weight - pred2
sqres2 = res2*res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)
print("remse of module is ", rmse2)

####log transformation
plt.scatter(x=np.log(calrs['cal']),y=calrs['weight'],color='brown')
np.corrcoef(np.log(calrs.cal), calrs.weight) #correlweightion
##0.8987252
model3 = smf.ols('weight ~ np.log(cal)',data=calrs).fit()
model3.summary()
### R-squared:                       0.808
pred3 = model3.predict(pd.DataFrame(calrs['cal']))
pred3
print(model3.conf_int(0.05)) # 99% confidence level

res3 = calrs.weight - pred3
sqres3 = res3*res3
mse3 = np.mean(sqres3)
rmse3 = np.sqrt(mse3)
###141.00

##Question 2: Delivery_time -> Predict delivery time using sorting time 
deltme = pd.read_csv("E:\Data_Science_Okv\Datasets/delivery_time.csv")
deltme
deltme.columns = "Dtime","Stime"
deltme


#####*without any trasnformation
plt.scatter(x=deltme['Stime'], y=deltme['Dtime'],color='green')# Scatter plot

np.corrcoef(deltme.Stime, deltme.Dtime) #correlation
##0.82599726
help(np.corrcoef)

model = smf.ols('Dtime ~ Stime', data=deltme).fit()
model.summary()
###R-squared:                       0.682
pred1 = model.predict(pd.DataFrame(deltme['Stime']))
pred1
print (model.conf_int(0.05)) # 95% confidence interval

res = deltme.Dtime - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)
print("remse of module is ", rmse)
### 2.7916503270617654
####exponenital
plt.scatter(x=deltme['Stime'], y=np.log(deltme['Dtime']),color='green')

np.corrcoef(deltme.Stime, np.log(deltme.Dtime))
##[0.8431
model2= smf.ols('np.log(Dtime) ~ Stime',data=deltme).fit()
model2.summary()
## 0.711
pred_log = model2.predict(pd.DataFrame(deltme['Stime']))
pred_log
pred2 = np.exp(pred_log)
pred2
print(model2.conf_int(0.05)) # 95% confidence level

res2 = deltme.Stime - pred2
sqres2 = res2 * res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)
print("remse of module is ", rmse2)
###10.57
####log transformation
plt.scatter(x=np.log(deltme['Stime']),y=deltme['Dtime'],color='brown')
np.corrcoef(np.log(deltme.Stime), deltme.Dtime) #correlDtimeion
##0.83
model3 = smf.ols('Dtime ~ np.log(Stime)',data=deltme).fit()
model3.summary()
### R-squared:                       0.6954
pred3 = model3.predict(pd.DataFrame(deltme['Stime']))
pred3
print(model3.conf_int(0.05)) # 99% confidence level

res3 = deltme.Dtime - pred3
sqres3 = res3*res3
mse3 = np.mean(sqres3)
rmse3 = np.sqrt(mse3)
###2.73

##Question 3: Build a prediction model for Churn_out_rate
empdata = pd.read_csv("E:\Data_Science_Okv\Datasets/emp_data.csv")
empdata
empdata.columns = "Shike","Crate"
empdata
#####*without any trasnformation
plt.scatter(x=empdata['Crate'], y=empdata['Shike'],color='green')# Scatter plot
np.corrcoef(empdata.Crate, empdata.Shike) #correlation
##91172162
help(np.corrcoef)

model = smf.ols('Shike ~ Crate', data=empdata).fit()
model.summary()
###R-squared:                       0.8312
pred1 = model.predict(pd.DataFrame(empdata['Crate']))
pred1
print (model.conf_int(0.05)) # 95% confidence interval

res = empdata.Shike - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)
print("remse of module is ", rmse)
###  35.8926351027664
####exponenital
plt.scatter(x=empdata['Crate'], y=np.log(empdata['Shike']),color='green')

np.corrcoef(empdata.Crate, np.log(empdata.Shike))
##92120773
model2= smf.ols('np.log(Shike) ~ Crate',data=empdata).fit()
model2.summary()
## 0.849
pred_log = model2.predict(pd.DataFrame(empdata['Crate']))
pred_log
pred2 = np.exp(pred_log)
pred2
print(model2.conf_int(0.05)) # 95% confidence level

res2 = empdata.Crate - pred2
sqres2 = res2 * res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)
print("remse of module is ", rmse2)
###1617.7177591443817
####log transformation
plt.scatter(x=np.log(empdata['Crate']),y=empdata['Shike'],color='brown')
np.corrcoef(np.log(empdata.Crate), empdata.Shike) #correlShikeion
##0.93463607
model3 = smf.ols('Shike ~ np.log(Crate)',data=empdata).fit()
model3.summary()
### R-squared:                       0.874
pred3 = model3.predict(pd.DataFrame(empdata['Crate']))
pred3
print(model3.conf_int(0.05)) # 99% confidence level

res3 = empdata.Shike - pred3
sqres3 = res3*res3
mse3 = np.mean(sqres3)
rmse3 = np.sqrt(mse3)
rmse3
###31.06952064024442
##Question 4: Salary_hike -> Build a prediction model for Salary_hike.
empdt = pd.read_csv("E:\Data_Science_Okv\Datasets/Salary_Data.csv")
empdt
empdt.columns = "Exp","Salry"
empdt


#####*without any trasnformation
plt.scatter(x=empdt['Exp'], y=empdt['Salry'],color='green')# Scatter plot

np.corrcoef(empdt.Exp, empdt.Salry) #correlation
##  0.97824162
help(np.corrcoef)

model = smf.ols('Salry ~ Exp', data=empdt).fit()
model.summary()
###R-squared:                    0.957
pred1 = model.predict(pd.DataFrame(empdt['Exp']))
pred1
print (model.conf_int(0.05)) # 95% confidence interval

res = empdt.Salry - pred1
sqres = res*res
mse = np.mean(sqres)
rmse = np.sqrt(mse)
print("remse of module is ", rmse)
### 5592.043608760662
####exponenital
plt.scatter(x=empdt['Exp'], y=np.log(empdt['Salry']),color='green')

np.corrcoef(empdt.Exp, np.log(empdt.Salry))
##0.96
model2= smf.ols('np.log(Salry) ~ Exp',data=empdt).fit()
model2.summary()
##  0.849
pred_log = model2.predict(pd.DataFrame(empdt['Exp']))
pred_log
pred2 = np.exp(pred_log)
pred2
print(model2.conf_int(0.05)) # 95% confidence level

res2 = empdt.Exp - pred2
sqres2 = res2 * res2
mse2 = np.mean(sqres2)
rmse2 = np.sqrt(mse2)
print("remse of module is ", rmse2)
###1687.5909092341487
####log transformation
plt.scatter(x=np.log(empdt['Exp']),y=empdt['Salry'],color='brown')
np.corrcoef(np.log(empdt.Exp), empdt.Salry) #correlSalryion
##0.92406108
model3 = smf.ols('Salry ~ np.log(Exp)',data=empdt).fit()
model3.summary()
### R-squared:                       .854
pred3 = model3.predict(pd.DataFrame(empdt['Exp']))
pred3
print(model3.conf_int(0.05)) # 99% confidence level

res3 = empdt.Salry - pred3
sqres3 = res3*res3
mse3 = np.mean(sqres3)
rmse3 = np.sqrt(mse3)
rmse3
## 10302.893706228306



