install.packages("SentimentAnalysis")
library(SentimentAnalysis)
install.packages("SnowballC")
library("SnowballC")
#####inpuit the data
documents <- c("Wow, I really like the new light sabers!",
               "That book was excellent.",
               "R is a fantastic language.",
               "The service in this restaurant was miserable.",
               "This is neither positive or negative.",
               "The waiter forget about my dessert -- what poor service!")
####Analyze sentiment
sentiment <- analyzeSentiment(documents)
## Extract dictionary-based sentiment according to the QDAP dictionary
sentiment$SentimentQDAP
# View sentiment direction (i.e. positive, neutral and negative)
convertToDirection(sentiment$SentimentQDAP)
##+1 postive, 0 nutral, -1 negative
response <- c(+1, +1, +1, -1, 0, -1)
compareToResponse(sentiment, response)
##reults mentioned in the analyis document.
compareToResponse(sentiment, convertToBinaryResponse(response))
###visualization
plotSentimentResponse(sentiment$SentimentQDAP, response)
###