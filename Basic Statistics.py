2 + 2 # Function F9
# works as calculator

# Python Libraries (Packages)
# pip install <package name> - To install library (package), execute the code in Command prompt
# pip install pandas

import pandas as pd

# Read data into Python
education = pd.read_csv("E:\Data_Science_Okv\Datasets/education.csv")

# C:\Users\ExcelR\Desktop\education.csv - this is windows default file path with a '\'
# C:\\Users\\ExcelR\\Desktop\\education.csv - change it to '\\' to make it work in Python

#Exploratory Data Analysis
#Measures of Central Tendency / First moment business decision
education.workex.mean() # '$' is used to refer to the variables within object
education.workex.median()
education.workex.mode()

from scipy import stats
stats.mode(education.workex)

# Measures of Dispersion / Second moment business decision
education.workex.var() # variance
education.workex.std()#standard deviation
range = max(education.workex) - min(education.workex) # range
range
x = max(education.workex)
x
x = min(education.workex)
x


#Third moment business decision
education.workex.skew()

#Fourth moment business decision
education.workex.kurt()

#Graphical Representation
import matplotlib.pyplot as plt # mostly used for visualization purposes 
import numpy as np

plt.bar(height = education.gmat, x = np.arange(1,774,1)) # initializing the parameter

plt.hist(education.gmat) #histogram

plt.boxplot(education.gmat) #boxplot

#Normal Quantile-Quantile Plot
import scipy.stats as stats
import pylab

# Checking Whether data is normally distributed
stats.probplot(education.gmat, dist="norm",plot=pylab)

stats.probplot(education.workex,dist="norm",plot=pylab)

#transformation to make workex variable normal
import numpy as np
stats.probplot(np.log(education.workex),dist="norm",plot=pylab)

#z-distribution
# cdf => cumulative distributive function; # similar to pnorm in R
stats.norm.cdf(740,711,29)  # given a value, find the probability

# ppf => Percent point function; # similar to qnorm in R
stats.norm.ppf(0.975,0,1) # given probability, find the Z value

#t-distribution
stats.t.cdf(1.98,139) # given a value, find the probability; # similar to pt in R
stats.t.ppf(0.975, 139) # given probability, find the t value; # similar to qt in R

help(stats.t.ppf) 
