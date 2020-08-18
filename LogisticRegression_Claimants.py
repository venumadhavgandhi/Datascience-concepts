import pandas as pd
import numpy as np

#Importing Data
elec1 = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\election_data.csv")
elec1.head()
print(elec1.isna().sum())
elec1 = elec1.dropna()
print(elec1.isna().sum())
##removing unncames columns 
#url_csv = 'E:\\Data_Science_Okv\\Datasets\\new\\Affairs.csv'
#affairs1 = pd.read_csv(url_csv, index_col=0)
#affairs1.head()
#affairs1['affairs'] = (affairs1.naffairs > 0).astype(int) 
# Imputating the missing values           
# claimants = claimants1.apply(lambda x:x.fillna(x.value_counts().index[0]))


### Splitting the data into train and test data 
#from sklearn.model_selection import train_test_split
#train_data,test_data = train_test_split(affairs1,test_size = 0.3) # 30% test data

# Model building 
import statsmodels.formula.api as sm
import scipy as sp
from scipy import linalg

elec1 = elec1.rename(columns = {"Election-id":"Election_id"})
elec1 = elec1.rename(columns = {"Amount Spent":"Amount_Spent"})
elec1 = elec1.rename(columns = {"Popularity Rank":"Popularity_Rank"})

elec1.drop(["Election_id"],axis=1,inplace = True)

elec1.head() 

logit_model = sm.logit('Result~Year+Amount_Spent+Popularity_Rank',data = elec1).fit(method='bfgs')

#summary
logit_model.summary()

predict1 = logit_model.predict(pd.DataFrame(elec1))

from sklearn.metrics import confusion_matrix

y_prediction1 = np.where(predict1 > 0.9 ,1,0)

cnf_matrix1 = confusion_matrix(elec1.Result, y_prediction1)
cnf_matrix1

# Model building2  ###Removing the unncorrelated featrues
#import statsmodels.formula.api as sm
##logit_model1 = sm.logit('y~balance+housing+loan+duration+campaign+previous+poutfailure+poutother+'
#'poutsuccess+con_cellular+con_telephone+divorced+married+joadmin+jomanagement+joretired+jostudent+'              
#'jotechnician+jounemployed',data = bank1).fit()

#summary
#logit_model1.summary()

#predict2 = logit_model1.predict(pd.DataFrame(bank1))

#y_prediction2 = np.where(predict2 > 0.7 ,1,0)

#from sklearn.metrics import confusion_matrix

#cnf_matrix2 = confusion_matrix(bank1['y'], y_prediction2)
#cnf_matrix2
##Getting same data like R - 
#from pandas_ml import ConfusionMatrix
#predict = logit_model.predict(pd.DataFrame(test_data))

#from sklearn.metrics import confusion_matrix

#cnf_matrix = confusion_matrix(test_data['affairs'], predict > 0.5 )
#cnf_matrix


#predict1 = logit_model.predict(pd.DataFrame(affairs1))

#from sklearn.metrics import confusion_matrix

#cnf_matrix1 = confusion_matrix(affairs1['affairs'], predict1 > 0.5 )
#cnf_matrix1
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
