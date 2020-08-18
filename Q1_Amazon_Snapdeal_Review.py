# -*- coding: utf-8 -*-
"""
Created on Wed Jul 22 18:12:09 2020

@author: VENUMADHAV
"""
import os
import requests   # Importing requests to extract content from a url
from bs4 import BeautifulSoup as bs # Beautifulsoup is for web scrapping...used to scrap specific content 
import re 
wash_reviews=[]

### Extracting reviews from Amazon website ################
for i in range(1,100):
  ip=[]  
  url="https://www.amazon.in/Samsung-Fully-Automatic-WA62M4100HY-TL-Imperial/product-reviews/B0747XV38N/ref=cm_cr_othr_d_paging_btm_1?showViewpoints=1&pageNumber="+str(i)
  response = requests.get(url)
  soup = bs(response.content,"html.parser")# creating soup object to iterate over the extracted content 
  reviews = soup.findAll("span",attrs={"class","a-size-base review-text review-text-content"})# Extracting the content under specific tags  
  for i in range(len(reviews)):
    ip.append(reviews[i].text)  
  wash_reviews=wash_reviews+ip  # adding the reviews of one page to empty list which in future contains all the reviews

# writng reviews in a text file 
with open("Washing_python.txt","w",encoding='utf8') as output:
    output.write(str(wash_reviews))
    
os.getcwd()

########### Extracting reviews from snapdeal website ##############
###Washing machine cover
wcover_snapdeal=[]
url1 = "https://www.snapdeal.com/product/eretailer-single-pvc-5kg-to/672058046051/reviews?page="
url2 = "&sortBy=RECENCY&vsrc=rcnt#defRevPDP"
### Extracting reviews from Amazon website ################
for i in range(1,10):
  ip=[]  
  base_url = url1+str(i)+url2
  response = requests.get(base_url)
  soup = bs(response.content,"html.parser")# creating soup object to iterate over the extracted content 
  temp = soup.findAll("div",attrs={"class","user-review"})# Extracting the content under specific tags  
  for j in range(len(temp)):
    ip.append(temp[j].find("p").text)
  wcover_snapdeal=wcover_snapdeal+ip  # adding the reviews of one page to empty list which in future contains all the reviews

### Removing repeated reviews 
wcover_snapdeal = list(set(wcover_snapdeal))

# Writing reviews into text file 
with open("wcover_snapdeal.txt","w",encoding="utf-8") as snp:
    snp.write(str(wcover_snapdeal))
os.getcwd()