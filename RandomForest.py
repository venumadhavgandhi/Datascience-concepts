import pandas as pd
import numpy as np

wbcd = pd.read_csv("C:\\Datasets_BA\\Python Scripts\\wbcd.csv")

wbcd = wbcd.iloc[:,1:32] # Excluding id column

# converting B to Benign and M to Malignant 
wbcd['diagnosis'] = np.where(wbcd['diagnosis'] == 'B','Benign ',wbcd['diagnosis'])
wbcd['diagnosis'] = np.where(wbcd['diagnosis'] == 'M','Malignant ',wbcd['diagnosis'])

# Splitting data into training and testing data set
from sklearn.model_selection import train_test_split
train,test = train_test_split(wbcd,test_size = 0.2)

X_train = np.array(train.ix[:,1:31]) # Input
X_test = np.array(test.ix[:,1:31]) # Input
Y_train = np.array(train['diagnosis']) # Output
Y_test = np.array(test['diagnosis']) # Output

# Normalization function 
def norm_func(i):
    x = (i-i.min())	/ (i.max()-i.min())
    return (x)

# Normalized data frame (considering the numerical part of data)
train_n = norm_func(train.iloc[:,1:])
train_n.describe()

test_n = norm_func(test.iloc[:,1:])
test_n.describe()

from sklearn.ensemble import RandomForestClassifier

rfmodel = RandomForestClassifier(n_estimators=15)

rfmodel.fit(X_train,Y_train)


# Train Data Accuracy
train["rf_pred"] = rfmodel.predict(X_train)
train_acc = np.mean(train["diagnosis"]==train["rf_pred"])
train_acc

# Test Data Accuracy
test["rf_pred"] = rfmodel.predict(X_test)
test_acc = np.mean(test["diagnosis"]==test["rf_pred"])
test_acc 
