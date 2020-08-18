import pandas as pd
import numpy as np

data = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\Randomforest\\iris.csv")
data.head(15)

data['Species'].unique()
data['Species'].value_counts()
colnames = list(data.columns)
type(data.columns)
predictors = colnames[:4]
target = colnames[5]

# Splitting data into training and testing data set
from sklearn.model_selection import train_test_split
train,test = train_test_split(data,test_size = 0.2)

from sklearn.tree import DecisionTreeClassifier as DT

help(DT)
model = DT(criterion = 'entropy')
model.fit(train[predictors],train[target])

# Prediction on Train Data
preds = model.predict(train[predictors])
pd.crosstab(train[target],preds,rownames=['Actual'],colnames=['Predictions'])

np.mean(preds==train[target]) # Train Data Accuracy


# Prediction on Test Data
preds = model.predict(test[predictors])
pd.crosstab(test[target],preds,rownames=['Actual'],colnames=['Predictions'])

np.mean(preds==test[target]) # Test Data Accuracy 

