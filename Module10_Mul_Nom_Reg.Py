### Multinomial Regression ####
import pandas as pd
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
studnts = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\new\\mdata.csv")
studnts.head(10)

studnts.describe()
studnts.prog.value_counts()
#academic    105
#vocation     50
#general      45
##convert  them into dummy
studnts['fem'] =studnts.female.map({'female':1 ,'male':0})
studnts['mal'] =studnts.female.map({'male':1 ,'female':0})
#
studnts['ses_low'] =studnts.ses.map({'low':1 ,'middle':0 , 'high':0})
studnts['ses_middle'] =studnts.ses.map({'middle':1 ,'low':0 , 'high':0})
studnts['ses_high'] =studnts.ses.map({'high':1 ,'middle':0 , 'low':0})
#
studnts['schtpe_pub'] =studnts.schtyp.map({'public':1 ,'private':0})
studnts['schtpe_pri'] =studnts.schtyp.map({'private':1 ,'public':0})
#
studnts['enroll'] =studnts.honors.map({'enrolled':1 ,'not enrolled':0})
studnts['not_enroll'] =studnts.honors.map({'not enrolled':1 ,'enrolled':0})
#
studnts.head(10)

# Boxplot of independent variable distribution for each category of choice 

sns.boxplot(x="prog",y="read",data=studnts)
sns.boxplot(x="prog",y="write",data=studnts)
sns.boxplot(x="prog",y="math",data=studnts)
sns.boxplot(x="prog",y="science",data=studnts)


# Scatter plot for each categorical choice of car

sns.stripplot(x="prog",y="read",jitter=True,data=studnts)
sns.stripplot(x="prog",y="write",jitter=True,data=studnts)
sns.stripplot(x="prog",y="math",jitter=True,data=studnts)
sns.stripplot(x="prog",y="science",jitter=True,data=studnts)

# Scatter plot between each possible pair of independent variable and also histogram for each independent variable 
#sns.pairplot(Stds,hue="prog") # With showing the category of each car choice in the scatter plot
sns.pairplot(studnts) # Normal

# Correlation values between each independent features
studnts.corr()
studnts.columns
##Removing the column names which are not using in the process
std1 = studnts.drop(['id','female','ses','schtyp','honors'],axis = 1)
std1.drop(std1.columns[std1.columns.str.contains('unnamed', case=False)],
          axis=1, inplace=True)
std1.columns
#Predicting with complete data
#model = LogisticRegression(multi_class="multinomial",solver="newton-cg").fit(std1.prog)
# ‘multinomial’ option is supported only by the ‘lbfgs’ and ‘newton-cg’ solvers
model1 = LogisticRegression(multi_class="multinomial",solver="newton-cg").fit(std1.iloc[:,1:],std1.iloc[:,0])
stdmodel1 = model1.predict(std1.iloc[:,1:])
accuracy_score(std1.iloc[:,0],stdmodel1)
##62.5% same like R code
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix,accuracy_score

print(classification_report(std1.iloc[:,0],stdmodel1))
#     precision    recall  f1-score   support
#
#    academic       0.69      0.83      0.75       105
#     general       0.39      0.20      0.26        45
#    vocation       0.58      0.58      0.58        50
#
#    accuracy                           0.62       200
#   macro avg       0.55      0.54      0.53       200
#weighted avg       0.59      0.62      0.60       200
print(confusion_matrix(std1.iloc[:,0],stdmodel1))
#got same like R oce 
#[[87 10  8]
# [23  9 13]
# [17  4 29]]
###splitting date set and tested 
train,test = train_test_split(std1,test_size = 0.2)

model = LogisticRegression(multi_class="multinomial",solver="newton-cg").fit(train.iloc[:,1:],train.iloc[:,0])

train_predict = model.predict(train.iloc[:,1:]) # Train predictions 
test_predict = model.predict(test.iloc[:,1:]) # Test predictions

# Train accuracy 
accuracy_score(train.iloc[:,0],train_predict) # 67.5%
# Test accuracy 
accuracy_score(test.iloc[:,0],test_predict) # 55.0%
##########################################
