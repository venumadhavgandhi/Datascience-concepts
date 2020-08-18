import pandas as pd
import matplotlib.pyplot as plt
import statsmodels.graphics.tsaplots as tsa_plots
from statsmodels.tsa.arima_model import ARIMA

Amtrak = pd.read_csv("F:\\DS\\Python Codes\\Final\\Forecasting\\Amtrak.csv")
Amtrak.rename(columns={"Ridership ('000)":"Ridership"},inplace=True)  

tsa_plots.plot_acf(Amtrak.Ridership,lags=12)
tsa_plots.plot_pacf(Amtrak.Ridership,lags=12)


model1=ARIMA(Amtrak.Ridership,order=(1,1,6)).fit(disp=0)
model2=ARIMA(Amtrak.Ridership,order=(1,1,5)).fit(disp=0)
model1.aic
model2.aic

p=1
q=0
d=1
pdq=[]
aic=[]
for q in range(7):
    try:
        model=ARIMA(Amtrak.Ridership,order=(p,d,q)).fit(disp=0)

        x=model.aic

        x1= p,d,q
               
        aic.append(x)
        pdq.append(x1)
    except:
        pass
            
keys = pdq
values = aic
d = dict(zip(keys, values))
print (d)
