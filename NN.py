import numpy as np
import pandas as pd

# Importing necessary models for implementation of ANN
from keras.models import Sequential
from keras.layers import Dense #, Activation,Layer,Lambda
a=100
from sklearn.model_selection import train_test_split
wbcd = pd.read_csv("c:\\Users\\asus\\Desktop\\Python Codes\\Neural Networks\\wbcd.csv")

wbcd.head(3)
wbcd.drop(["id"],axis=1,inplace=True) # Dropping the uncessary column 
wbcd.columns
wbcd.shape

wbcd.isnull().sum() # No missing values 

#  Malignant as 0 and Beningn as 1

wbcd.loc[wbcd.diagnosis=="B","diagnosis"] = 1
wbcd.loc[wbcd.diagnosis=="M","diagnosis"] = 0

wbcd.diagnosis.value_counts().plot(kind="bar")

train,test = train_test_split(wbcd,test_size = 0.3,random_state=42)

trainX = train.drop(["diagnosis"],axis=1)
trainY = train["diagnosis"]
testX = test.drop(["diagnosis"],axis=1)
testY = test["diagnosis"]

# 
test.diagnosis.value_counts()
# Preparing a function to define the structure ANN network 
# Number hidden neurons & Hidden Layers 
# Activation function 
# Optimizer - similar to that of gradient decent 
# loss - loss function 
# rmsprop - > Root mean sqaure prop 

def prep_model(hidden_dim):
    model = Sequential() # initialize 
    for i in range(1,len(hidden_dim)-1):
        if (i==1):
            model.add(Dense(hidden_dim[i],input_dim=hidden_dim[0],activation="relu"))
        else:
            model.add(Dense(hidden_dim[i],activation="relu"))
    # To define the dimensions for the output layer
    # activation - sigmoid 
    model.add(Dense(hidden_dim[-1],kernel_initializer="normal",activation="sigmoid"))
    # loss function -> loss parameter
    # algorithm to update the weights - optimizer parameter
    # accuracy - metric to display for 1 epoch
    model.compile(loss="binary_crossentropy",optimizer = "rmsprop",metrics = ["accuracy"])
    return model    


# giving input as list format which is referring to
# number of input features - 30
# number of hidden neurons in each hidden layer - 4  layers
# 50- hidden neurons - 1st hidden layer
# Number of dimensions for output layer  - last 
first_model = prep_model([30,50,40,20,1])

# Fitting ANN model with epochs = 700 
first_model.fit(np.array(trainX),np.array(trainY),epochs=10)



# predicting the probability values for each record
pred_train = first_model.predict(np.array(trainX))

# pd.Series - > convert list format Pandas Series data structure
pred_train = pd.Series([i[0] for i in pred_train])

disease_class = ["B","M"]
# converting series because add them as columns into data frame
pred_train_class = pd.Series(["M"]*398)
pred_train_class[[i>0.5 for i in pred_train]] = "B"

from sklearn.metrics import confusion_matrix
train["original_class"] = "M"
train.loc[train.diagnosis==1,"original_class"] = "B"
train.original_class.value_counts()

# Two way table format 
confusion_matrix(pred_train_class,train.original_class)

# Calculating the accuracy using mean function from numpy 
# we need to reset the index values of train data as the index values are random numbers
np.mean(pred_train_class==pd.Series(train.original_class).reset_index(drop=True))

# 2 way table 
pd.crosstab(pred_train_class,pd.Series(train.original_class).reset_index(drop=True))

# Predicting for test data 
pred_test = first_model.predict(np.array(testX))

pred_test = pd.Series([i[0] for i in pred_test])
pred_test_class = pd.Series(["M"]*171)

pred_test_class[[i>0.5 for i in pred_test]] = "B"
test["original_class"] = "M"
test.loc[test.diagnosis==1,"original_class"] = "B"
test.original_class.value_counts()
temp = pd.Series(test.original_class).reset_index(drop=True)
np.mean(pred_test_class==pd.Series(test.original_class).reset_index(drop=True)) # 97.66
len(pred_test_class==pd.Series(test.original_class).reset_index(drop=True))
confusion_matrix(pred_test_class,temp)
#pd.crosstab(pred_test_class,test.original_class)

# to show the count of each category with respect to other category 
pd.crosstab(test.original_class,pred_test_class).plot(kind="bar")



########################## Neural Network for predicting continuous values ###############################

# Reading data 
Concrete = pd.read_csv("c:\\Users\\asus\\Desktop\\Python Codes\\Neural Networks\\concrete.csv")
Concrete.head()

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

column_names = list(Concrete.columns)
predictors = column_names[0:8]
target = column_names[8]

first_model = prep_model([8,50,1])
first_model.fit(np.array(Concrete[predictors]),np.array(Concrete[target]),epochs=10)
pred_train = first_model.predict(np.array(Concrete[predictors]))
pred_train = pd.Series([i[0] for i in pred_train])
rmse_value = np.sqrt(np.mean((pred_train-Concrete[target])**2))
import matplotlib.pyplot as plt
plt.plot(pred_train,Concrete[target],"bo")
np.corrcoef(pred_train,Concrete[target]) # we got high correlation 
