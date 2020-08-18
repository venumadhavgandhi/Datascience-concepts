import numpy as np
import pandas as pd
#
from IPython.display import display
import matplotlib.pyplot as plt
#
from textblob import TextBlob
#
#%matplotlib inline
#
###Taking cleaned data
positive_sentence = "I love cheese. Truly, I feel very strongly about it: it is the best!"
neutral_sentence = "Cheese is made from milk. Yesterday, cheese was arrested. Here is some news."
negative_sentence = "Cheese is the worst! I hate it! With every fibre of my being!"
###Sentiment Analysis##
positive_blob = TextBlob(positive_sentence)
neutral_blob = TextBlob(neutral_sentence)
negative_blob = TextBlob(negative_sentence)
##output
print("Positive sentence: ", positive_blob.sentiment)
#Positive sentence:  Sentiment(polarity=0.6877777777777778, subjectivity=0.6177777777777778)
##greater than zero : postive
print("Neutral sentence: ", neutral_blob.sentiment)
#Neutral sentence:  Sentiment(polarity=0.0, subjectivity=0.0)
## equal to zero Neutral
print("Negative sentence: ", negative_blob.sentiment)
#Negative sentence:  Sentiment(polarity=-1.0, subjectivity=0.95)
## Poliarity -1: negatiove
#####final out ####

