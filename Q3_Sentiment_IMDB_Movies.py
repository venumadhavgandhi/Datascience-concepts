###Installed from command prompt
##pip install wordcloud
##conda install -c conda-forge wordcloud
import requests   # Importing requests to extract content from a url
from bs4 import BeautifulSoup as bs # Beautifulsoup is for web scrapping...used to scrap specific content 
import re 
import matplotlib.pyplot as plt
from wordcloud import WordCloud
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
#
from textblob import TextBlob
##########################    
IMDB = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\NLP\\IMDB Dataset.csv")
#IMDB = pd.read_csv("E:\\Data_Science_Okv\\Datasets\\NLP\\IMDB Dataset.csv",header=None)
# Joinining all the reviews into single paragraph 
ip_rev_string=[] 
###  
ip=[]
##Polarity
## equal zero Neutral, less than 0 - negative , greater than zero - postive
for i in range(0,49999):
    sentmnt = TextBlob(str(IMDB.iloc[i,0:1]))
    ip.insert(i,sentmnt.sentiment)

with open("Sentiment_polarity_Q3.txt","w",encoding='utf8') as output:
    output.write(str(ip))
 ###
ip_rev_string=[]             
for i in range(0,49999):
   ip_rev_string.append(list(IMDB.iloc[i,0:1]))
   #ip_rev_string.append(ip[i+1])
####
ip_rev_string1= str(ip_rev_string)
##
# Removing unwanted symbols incase if exists
ip_rev_string1 = re.sub("[^A-Za-z" "]+"," ",ip_rev_string1).lower()
ip_rev_string1 = re.sub("[0-9" "]+"," ",ip_rev_string1)
#
# words that contained in iphone 7 reviews
ip_reviews_words = ip_rev_string1.split(" ")

with open("E:\\Data_Science_Okv\\Datasets\\NLP\\stop.txt","r") as sw:
    stopwords = sw.read()

stopwords = stopwords.split("\n")
##
ip_reviews_words = [w for w in ip_reviews_words if not w in stopwords]
# Joinining all the reviews into single paragraph 
ip_rev_string = " ".join(ip_reviews_words)

# WordCloud can be performed on the string inputs. That is the reason we have combined 
# entire reviews into single paragraph
# Simple word cloud


wordcloud_ip = WordCloud(
                      background_color='black',
                      width=1800,
                      height=1400
                     ).generate(ip_rev_string)

plt.imshow(wordcloud_ip)

# positive words # Choose the path for +ve words stored in system
with open("E:\\Data_Science_Okv\\Datasets\\NLP\\\positive-words.txt","r") as pos:
  poswords = pos.read().split("\n")
  
#poswords = poswords[36:]
# negative words  Choose path for -ve words stored in system
with open("E:\\Data_Science_Okv\\Datasets\\NLP\\negative-words.txt","r") as neg:
  negwords = neg.read().split("\n")

#negwords = negwords[37:]

# negative word cloud
# Choosing the only words which are present in negwords
ip_neg_in_neg = " ".join ([w for w in ip_reviews_words if w in negwords])

wordcloud_neg_in_neg = WordCloud(
                      background_color='black',
                      width=1800,
                      height=1400
                     ).generate(ip_neg_in_neg)

plt.imshow(wordcloud_neg_in_neg)

# Positive word cloud
# Choosing the only words which are present in positive words
ip_pos_in_pos = " ".join ([w for w in ip_reviews_words if w in poswords])
wordcloud_pos_in_pos = WordCloud(
                      background_color='black',
                      width=1800,
                      height=1400
                     ).generate(ip_pos_in_pos)

plt.imshow(wordcloud_pos_in_pos)
##