### Multinomial Regression ####
import pandas as pd
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score
Cars = pd.read_csv("C:\\Users\\asus\\Desktop\\Python Codes\\Multinomial Regression\\new_cars.csv")
Cars.head(10)

Cars.describe()
Cars.choice.value_counts()

# Boxplot of independent variable distribution for each category of choice 
sns.boxplot(x="choice",y="cost.car",data=Cars)
sns.boxplot(x="choice",y="cost.carpool",data=Cars)
sns.boxplot(x="choice",y="cost.bus",data=Cars)
sns.boxplot(x="choice",y="cost.rail",data=Cars)
sns.boxplot(x="choice",y="time.car",data=Cars)
sns.boxplot(x="choice",y="time.bus",data=Cars)
sns.boxplot(x="choice",y="time.rail",data=Cars)


# Scatter plot for each categorical choice of car
sns.stripplot(x="choice",y="cost.car",jitter=True,data=Cars)
sns.stripplot(x="choice",y="cost.carpool",jitter=True,data=Cars)
sns.stripplot(x="choice",y="cost.carpool",jitter=True,data=Cars)
sns.stripplot(x="choice",y="cost.rail",jitter=True,data=Cars)
sns.stripplot(x="choice",y="time.cars",jitter=True,data=Cars)
sns.stripplot(x="choice",y="time.bus",jitter=True,data=Cars)
sns.stripplot(x="choice",y="time.rail",jitter=True,data=Cars)

# Scatter plot between each possible pair of independent variable and also histogram for each independent variable 
sns.pairplot(Cars,hue="choice") # With showing the category of each car choice in the scatter plot
sns.pairplot(Cars) # Normal

# Correlation values between each independent features
Cars.corr()


train,test = train_test_split(Cars,test_size = 0.2)

# ‘multinomial’ option is supported only by the ‘lbfgs’ and ‘newton-cg’ solvers
model = LogisticRegression(multi_class="multinomial",solver="newton-cg").fit(train.iloc[:,1:],train.iloc[:,0])

train_predict = model.predict(train.iloc[:,1:]) # Train predictions 
test_predict = model.predict(test.iloc[:,1:]) # Test predictions

# Train accuracy 
accuracy_score(train.iloc[:,0],train_predict) # 69.8%
# Test accuracy 
accuracy_score(test.iloc[:,0],test_predict) # 67.032%

