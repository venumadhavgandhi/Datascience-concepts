# -*- coding: utf-8 -*-
"""
Created on Fri Aug  7 08:11:50 2020

@author: THE PC
"""
import numpy as np
import pandas as pd
# Importing necessary models for implementation of ANN
from keras.models import Sequential
from keras.layers import Dense #, Activation,Layer,Lambda
a=100
from sklearn.model_selection import train_test_split
startup = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\NNetwork\\50_Startups.csv")
startup1 = pd.get_dummies(startup,columns=["State"])
startup1.head()
startup1.columns
startup1.columns = ['RDSpend', 'Admin','MSpend','Profit','California','Florida','NewYork']
startup1.columns
startup2 = startup1[['RDSpend', 'Admin','MSpend','California','Florida','NewYork','Profit']]
startup2.head()

def prep_model(hidden_dim):
    model = Sequential()
    for i in range(1,len(hidden_dim)-1):
        if (i==1):
            model.add(Dense(hidden_dim[i],input_dim=hidden_dim[0],kernel_initializer="normal",activation="relu"))
        else:
            model.add(Dense(hidden_dim[i],activation="relu"))
    # for the output layer we are not adding any activation function as 
    # the target variable is continuous variable 
    model.add(Dense(hidden_dim[-1]))
    # loss ---> loss function is means squared error to compare the output and estimated output
    # optimizer ---> adam
    # metrics ----> mean squared error - error for each epoch on entire data set 
    model.compile(loss="mean_squared_error",optimizer="adam",metrics = ["mse"])
    return (model)
##
column_names = list(startup2.columns)
predictors = column_names[0:6]
target = column_names[6]

first_model = prep_model([6,50,1])
first_model.fit(np.array(startup2[predictors]),np.array(startup2[target]),epochs=10)
pred_train = first_model.predict(np.array(startup2[predictors]))
pred_train = pd.Series([i[0] for i in pred_train])
rmse_value = np.sqrt(np.mean((pred_train-startup2[target])**2))
import matplotlib.pyplot as plt
plt.plot(pred_train,startup2[target],"bo")
np.corrcoef(pred_train,startup2[target]) # we got high correlation 
