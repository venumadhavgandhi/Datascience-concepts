import pandas as pd
#pandas is used for data manipulation
import numpy as np
#numpy is used for numerical data
from sklearn.model_selection import train_test_split
#used for splitting the data into train and test datasets
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import VotingClassifier
#A Voting Classifier is a machine learning model that trains on an ensemble of numerous models and predicts an output (class) based on their highest probability.

#import dataset
data=pd.read_csv("D:/360digiTMG/unsupervised/mod20 AdaBoost/Datasets (3)/wbcd.csv")

data.head()

#remove id column and seperate the data into source varibles and target variable
df_x=data.iloc[:,2:32]
df_y=data.iloc[:,1]

#divide the data into train and test datasets
x_train,x_test,y_train,y_test=train_test_split(df_x,df_y,test_size=0.2,random_state=4)#divide data randomly
y_test.head()

#decisoin tree
dt=DecisionTreeClassifier()#storing the classifier in dt

#fitting the model
dt.fit(x_train,y_train)

dt.score(x_test,y_test)##checking the score like accuracy
# 0.9122807017543859

dt.score(x_train,y_train)
# 1.0

#Random Forest clssifier: it is a ensemble of Decision tree 
rf = RandomForestClassifier(n_estimators=10) # n_estimator number of tree in the forest 
rf.fit(x_train,y_train) #fitting the random forest model 

rf.score(x_test,y_test) #doing the accuracy of the test model 
#0.9210526315789473


rf.score(x_train,y_train) #doing the accuracy of the train model 
#0.9934065934065934

#Bagging - Gradient 
bg = BaggingClassifier(DecisionTreeClassifier(), max_samples=0.5,max_features=1.0, n_estimators=20)
bg.fit(x_train,y_train) #fitting the model 



bg.score(x_test,y_test) #test accuracy
#0.9298245614035088


bg.score(x_train,y_train) #train accuracy 
# 0.9912087912087912

# <h4> Boosting - Ada Boost </h4>


#Ada boosting 
ada = AdaBoostClassifier(DecisionTreeClassifier(),n_estimators=10,learning_rate=1)
ada.fit(x_train,y_train)



ada.score(x_test,y_test)
#0.9210526315789473



ada.score(x_train,y_train)
# 1.0

# <h4> Voting Classifier </h4>


from sklearn.linear_model import LogisticRegression #importing logistc regression
from sklearn.svm import SVC #importing Svm 


lr = LogisticRegression() 
dt = DecisionTreeClassifier()
svm = SVC(kernel= 'poly', degree=2)



evc = VotingClassifier(estimators=[('lr',lr),('dt',dt),('svm',svm)],voting='hard')



evc.fit(x_train,y_train)
#0.9298245614035088

evc.score(x_test,y_test)
# 1.0


evc.score(x_train,y_train)
#0.9912087912087912



