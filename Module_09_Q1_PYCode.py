import pandas as pd
import numpy as np

#Importing Data ##removing unnamed columns 
url_csv = 'E:\\Data_Science_Okv\\Datasets\\new\\Affairs.csv'
affairs1 = pd.read_csv(url_csv, index_col=0)
affairs1.head()
###convert into factors 
affairs1['affairs'] = (affairs1.naffairs > 0).astype(int) 
print(affairs1.isna().sum())
##model building 
logit_model = sm.logit('affairs ~ kids+vryunhap+unhap+avgmarr+hapavg+antirel+notrel+'
 'slghtrel+smerel+yrsmarr1+yrsmarr2+yrsmarr3+yrsmarr4+yrsmarr5',data = affairs1).fit()

#summary
logit_model.summary()
##predicting
predict1 = logit_model.predict(pd.DataFrame(affairs1))

from sklearn.metrics import confusion_matrix
y_prediction1 = np.where(predict1 > 0.5 ,1,0)

cnf_matrix1 = confusion_matrix(affairs1['affairs'], y_prediction1)
cnf_matrix1

# Model building2  ###Removing the unncorrelated featrues
import statsmodels.formula.api as sm
logit_model1 = sm.logit('affairs ~ vryunhap+unhap+avgmarr+hapavg+antirel+slghtrel+smerel+'
 'yrsmarr1+yrsmarr2',data = affairs1).fit()

#summary
logit_model1.summary()

predict2 = logit_model1.predict(pd.DataFrame(affairs1))
y_prediction2 = np.where(predict2 > 0.5 ,1,0)

from sklearn.metrics import confusion_matrix

cnf_matrix2 = confusion_matrix(affairs1['affairs'], y_prediction2)
cnf_matrix2
###check the matrics of confusion matrix
from sklearn.metrics import accuracy_score 
from sklearn.metrics import classification_report 

accuracy = accuracy_score(affairs1.affairs, predict2 > 0.5)
accuracy
print(classification_report(affairs1.affairs, predict2 > 0.5))
### ROC CURVE Genearion
import matplotlib.pyplot as plt 
from sklearn.metrics import roc_auc_score
from sklearn.metrics import roc_curve, auc
auc = roc_auc_score(affairs1.affairs, y_prediction2)
auc
fpr, tpr, thresholds = roc_curve(affairs1.affairs, y_prediction2)
def plot_roc_curve(fpr, tpr):
    plt.plot(fpr, tpr, color='orange', label='ROC')
    plt.plot([0, 1], [0, 1], color='darkblue', linestyle='--')
    plt.xlabel('False Positive Rate')
    plt.ylabel('True Positive Rate')
    plt.title('Receiver Operating Characteristic (ROC) Curve')
    plt.legend()
    plt.show()

plot_roc_curve(fpr, tpr)
