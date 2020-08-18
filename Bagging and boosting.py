
# coding: utf-8

# In[106]:


import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import BaggingClassifier
from sklearn.ensemble import AdaBoostClassifier
from sklearn.ensemble import VotingClassifier


# In[85]:


data = pd.read_csv("C:/Users/suri/Desktop/Python codes/Final/Decision Tree/iris.csv") #importing the dataset 
data.head() #seeting the head of the data


# In[86]:


df_x = data.iloc[:,:4] #dividing the i/p and o/p variebale
df_y = data.iloc[:,4]


# In[115]:


x_train,x_test,y_train,y_test= train_test_split(df_x,df_y,test_size=0.2, random_state= 4) #dividing the data randomly
y_test.head()


# In[88]:


#decision tree
dt = DecisionTreeClassifier() #storing the classifer in dt


# In[89]:


dt.fit(x_train,y_train) #fitting te model 


# In[90]:


dt.score(x_test,y_test) #checking the score like accuracy


# In[91]:


dt.score(x_train,y_train)
#so our model is overfitting 


# In[92]:


#Random Forest clssifer: it is a ensemble of Decision tree 
rf = RandomForestClassifier(n_estimators=10) # n_estimator number of tree in the forest 
rf.fit(x_train,y_train) #fitting the random forest model 


# In[93]:


rf.score(x_test,y_test) #doing the accuracy of the test model 


# In[94]:


rf.score(x_train,y_train) #doing the accuracy of the train model 


# In[95]:


#Bagging - Gradient 
bg = BaggingClassifier(DecisionTreeClassifier(), max_samples=0.5,max_features=1.0, n_estimators=20)
bg.fit(x_train,y_train) #fitting the model 


# In[96]:


bg.score(x_test,y_test) #test accuracy


# In[97]:


bg.score(x_train,y_train) #train accuracy 


# <h4> Boosting - Ada Boost </h4>

# In[100]:


#Ada boosting 
ada = AdaBoostClassifier(DecisionTreeClassifier(),n_estimators=10,learning_rate=1)
ada.fit(x_train,y_train)


# In[101]:


ada.score(x_test,y_test)


# In[102]:


ada.score(x_train,y_train)


# <h4> Voting Classifier </h4>

# In[104]:


from sklearn.linear_model import LogisticRegression #importing logistc regression
from sklearn.svm import SVC #importing Svm 


# In[105]:


lr = LogisticRegression() 
dt = DecisionTreeClassifier()
svm = SVC(kernel= 'poly', degree=2)


# In[107]:


evc = VotingClassifier(estimators=[('lr',lr),('dt',dt),('svm',svm)],voting='hard')


# In[108]:


evc.fit(x_train,y_train)


# In[109]:


evc.score(x_test,y_test)


# In[110]:


evc.score(x_train,y_train)

