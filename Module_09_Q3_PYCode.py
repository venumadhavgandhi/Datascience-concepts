import pandas as pd
import numpy as np

#Importing election Data
elec1 = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\election_data.csv")
elec1.head()
print(elec1.isna().sum())
elec1 = elec1.dropna()
print(elec1.isna().sum())

# Model building 
import statsmodels.formula.api as sm
import scipy as sp
from scipy import linalg

elec1 = elec1.rename(columns = {"Election-id":"Election_id"})
elec1 = elec1.rename(columns = {"Amount Spent":"Amount_Spent"})
elec1 = elec1.rename(columns = {"Popularity Rank":"Popularity_Rank"})

elec1.drop(["Election_id"],axis=1,inplace = True)

elec1.head() 
##to avoid singlur matrix error and exceed no of iteration
logit_model = sm.logit('Result~Year+Amount_Spent+Popularity_Rank',data = elec1).fit(method='bfgs')

#summary
logit_model.summary()

predict1 = logit_model.predict(pd.DataFrame(elec1))

from sklearn.metrics import confusion_matrix

y_prediction1 = np.where(predict1 > 0.9 ,1,0)

cnf_matrix1 = confusion_matrix(elec1.Result, y_prediction1)
cnf_matrix1

##Getting same data like R - 

from sklearn.metrics import accuracy_score 
from sklearn.metrics import classification_report 

accuracy = accuracy_score(elec1.Result, predict1 > 0.9)
accuracy
print(classification_report(elec1.Result, predict1 > 0.9))


import matplotlib.pyplot as plt 
from sklearn.metrics import roc_auc_score
from sklearn.metrics import roc_curve, auc
auc = roc_auc_score(elec1.Result, y_prediction1)
auc
fpr, tpr, thresholds = roc_curve(elec1.Result, y_prediction1)
def plot_roc_curve(fpr, tpr):
    plt.plot(fpr, tpr, color='orange', label='ROC')
    plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend()
    plt.show()

plot_roc_curve(fpr, tpr)
