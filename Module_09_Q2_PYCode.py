import pandas as pd
import numpy as np

#Importing Data bank dataset
bank1 = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\bank_data.csv")
bank1.head()
print(bank1.isna().sum())
# Model building - renaming few columns to process correctly 
import statsmodels.formula.api as sm
bank1 = bank1.rename(columns = {"joadmin.":"joadmin"})
bank1 = bank1.rename(columns = {"joblue.collar":"joblue_collar"})
bank1 = bank1.rename(columns = {"joself.employed":"joself_employed"})
bank1.head() 
print(bank1.isna().sum()) 
logit_model = sm.logit('y ~ age+default+balance+housing+loan+duration+campaign+pdays+previous+poutfailure+poutother+'
'poutsuccess+con_cellular+con_telephone+divorced+married+joadmin+joblue_collar+joentrepreneur+johousemaid'
'+jomanagement+joretired+joself_employed+joservices+jostudent+jotechnician+jounemployed',data = bank1).fit()

#summary
logit_model.summary()

predict1 = logit_model.predict(pd.DataFrame(bank1))

from sklearn.metrics import confusion_matrix

y_prediction1 = np.where(predict1 > 0.7 ,1,0)

cnf_matrix1 = confusion_matrix(bank1['y'], y_prediction1)
cnf_matrix1

# Model building2  ###Removing the unncorrelated featrues
import statsmodels.formula.api as sm
logit_model1 = sm.logit('y~balance+housing+loan+duration+campaign+previous+poutfailure+poutother+'
'poutsuccess+con_cellular+con_telephone+divorced+married+joadmin+jomanagement+joretired+jostudent+'              
'jotechnician+jounemployed',data = bank1).fit()

#summary
logit_model1.summary()

predict2 = logit_model1.predict(pd.DataFrame(bank1))

y_prediction2 = np.where(predict2 > 0.7 ,1,0)

from sklearn.metrics import confusion_matrix

cnf_matrix2 = confusion_matrix(bank1['y'], y_prediction2)
cnf_matrix2
##Getting same data like R - 
# metrics of confusio matrix
from sklearn.metrics import accuracy_score 
from sklearn.metrics import classification_report 

accuracy = accuracy_score(bank1.y, predict2 > 0.7)
accuracy
print(classification_report(bank1.y, predict2 > 0.7))

##ROC curve
import matplotlib.pyplot as plt 
from sklearn.metrics import roc_auc_score
from sklearn.metrics import roc_curve, auc
auc = roc_auc_score(bank1.y, y_prediction2)
auc
fpr, tpr, thresholds = roc_curve(bank1.y, y_prediction2)
def plot_roc_curve(fpr, tpr):
    plt.plot(fpr, tpr, color='orange', label='ROC')
    plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend()
    plt.show()

plot_roc_curve(fpr, tpr)
