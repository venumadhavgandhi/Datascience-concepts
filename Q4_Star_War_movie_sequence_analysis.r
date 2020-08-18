install.packages("RWeka")
install.packages("tidyverse")
install.packages("tm")
install.packages("wordcloud")
install.packages("tidytext")
install.packages("wordcloud2")
install.packages("reshape2")
install.packages("radarchart")
install.packages("NLP")
install.packages("rJava")
library(tidyverse)
library(NLP)
library(tm)
library(wordcloud)
library(wordcloud2)
library(tidytext)
library(reshape2)
library(radarchart)
library(rJava)
library(RWeka)
library(slam)
library(topicmodels)
###load the data
ep4<-readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeIV.txt")
ep5<-readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeV.txt")
ep6<-readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeVI.txt")
####episode 4 data cleaning
mydata.corpus4 <- Corpus(VectorSource(ep4))
mydata.corpus4 <- tm_map(mydata.corpus4, removePunctuation) 
my_stopwords <- c(stopwords('english'),"the", "due", "are", "not", "for", "this", "and",  "that", "there", "new", "near", "beyond", "time", "from", "been", "both", "than",  "has","now", "until", "all", "use", "two", "ave", "blvd", "east", "between", "end", "have", "avenue", "before",    "just", "mac", "being",  "when","levels","remaining","based", "still", "off", "over", "only", "north", "past", "twin", "while","then")
mydata.corpus4 <- tm_map(mydata.corpus4, removeWords, my_stopwords)
mydata.corpus4 <- tm_map(mydata.corpus4, removeNumbers) 
####episode 5 data cleaning
mydata.corpus5 <- Corpus(VectorSource(ep5))
mydata.corpus5 <- tm_map(mydata.corpus5, removePunctuation) 
my_stopwords <- c(stopwords('english'),"the", "due", "are", "not", "for", "this", "and",  "that", "there", "new", "near", "beyond", "time", "from", "been", "both", "than",  "has","now", "until", "all", "use", "two", "ave", "blvd", "east", "between", "end", "have", "avenue", "before",    "just", "mac", "being",  "when","levels","remaining","based", "still", "off", "over", "only", "north", "past", "twin", "while","then")
mydata.corpus5 <- tm_map(mydata.corpus5, removeWords, my_stopwords)
mydata.corpus5 <- tm_map(mydata.corpus5, removeNumbers) 
####episode 6 data cleaning
mydata.corpus6 <- Corpus(VectorSource(ep6))
mydata.corpus6 <- tm_map(mydata.corpus6, removePunctuation) 
my_stopwords <- c(stopwords('english'),"the", "due", "are", "not", "for", "this", "and",  "that", "there", "new", "near", "beyond", "time", "from", "been", "both", "than",  "has","now", "until", "all", "use", "two", "ave", "blvd", "east", "between", "end", "have", "avenue", "before",    "just", "mac", "being",  "when","levels","remaining","based", "still", "off", "over", "only", "north", "past", "twin", "while","then")
mydata.corpus6 <- tm_map(mydata.corpus6, removeWords, my_stopwords)
mydata.corpus6 <- tm_map(mydata.corpus6, removeNumbers) 
#####
# build a term-document matrix - ep4
mydata.dtm4 <- TermDocumentMatrix(mydata.corpus4)
mydata.dtm4
##
dim(mydata.dtm4)
##
dtm4 <- as.DocumentTermMatrix(mydata.dtm4)
rowTotals <- apply(dtm4 , 1, sum)
dtm.new4   <- dtm4[rowTotals> 0, ]
dtm.new4
# build a term-document matrix- ep5
mydata.dtm5 <- TermDocumentMatrix(mydata.corpus5)
mydata.dtm5
##
dim(mydata.dtm5)
##
dtm5 <- as.DocumentTermMatrix(mydata.dtm5)
rowTotals <- apply(dtm5 , 1, sum)
dtm.new5   <- dtm5[rowTotals> 0, ]
dtm.new5 
# build a term-document matrix- ep6
mydata.dtm6 <- TermDocumentMatrix(mydata.corpus6)
mydata.dtm6
##
dim(mydata.dtm6)
##
dtm6 <- as.DocumentTermMatrix(mydata.dtm6)
rowTotals <- apply(dtm6 , 1, sum)
dtm.new6   <- dtm6[rowTotals> 0, ]
dtm.new6 
###############topic extraction for episode 4
lda <- LDA(dtm.new4, 10) # find 10 topics
term <- terms(lda, 5) # first 5 terms of every topic
term
#
tops <- terms(lda)
tb <- table(names(tops), unlist(tops))
tb <- as.data.frame.matrix(tb)

cls <- hclust(dist(tb), method = 'ward.D2')
par(family = "HiraKakuProN-W3")
plot(cls)
###############topic extraction -5 
lda <- LDA(dtm.new5, 10) # find 10 topics
term <- terms(lda, 5) # first 5 terms of every topic
term
#
tops <- terms(lda)
tb <- table(names(tops), unlist(tops))
tb <- as.data.frame.matrix(tb)

cls <- hclust(dist(tb), method = 'ward.D2')
par(family = "HiraKakuProN-W3")
plot(cls)
###############topic extraction -6 
lda <- LDA(dtm.new6, 10) # find 10 topics
term <- terms(lda, 5) # first 5 terms of every topic
term
#
tops <- terms(lda)
tb <- table(names(tops), unlist(tops))
tb <- as.data.frame.matrix(tb)

cls <- hclust(dist(tb), method = 'ward.D2')
par(family = "HiraKakuProN-W3")
plot(cls)
####################### Emotion miningfor episode 4 ##############################
install.packages("syuzhet")
library(syuzhet)
install.packages("reticulate")
library(reticulate)
install.packages("tidytext")
library(tidytext)
###Episopde 4 analysis
my_example_text4 <- readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeIV.txt")
s_v <- get_sentences(my_example_text4)
#
sentiment_vector <- get_sentiment(s_v, method = "bing")
##head(sentiment_vector)

afinn_s_v <- get_sentiment(s_v, method = "afinn")
##head(afinn_s_v)

nrc_vector <- get_sentiment(s_v, method="nrc")
##head(nrc_vector)
sum(sentiment_vector)
mean(sentiment_vector)
summary(sentiment_vector)
# plot
plot(sentiment_vector, type = "l", main = "Plot Trajectory",
     xlab = "Narrative Time", ylab = "Emotional Valence")
abline(h = 0, col = "red")

# To extract the sentence with the most negative emotional valence
negative <- s_v[which.min(sentiment_vector)]

# and to extract the most positive sentence
positive <- s_v[which.max(sentiment_vector)]

# more depth for episode 4
poa_v<-my_example_text4
poa_sent <- get_sentiment(poa_v, method="bing")
plot(
  poa_sent, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# percentage based figures
percent_vals <- get_percentage_values(poa_sent)

plot(
  percent_vals, 
  type="l", 
  main="Throw the ring in the volcano Using Percentage-Based Means", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

ft_values <- get_transformed_values(
  poa_sent, 
  low_pass_size = 3, 
  x_reverse_len = 100,
  scale_vals = TRUE,
  scale_range = FALSE
)

plot(
  ft_values, 
  type ="h", 
  main ="LOTR using Transformed Values", 
  xlab = "Narrative Time", 
  ylab = "Emotional Valence", 
  col = "red"
)

# categorize each sentence by eight emotions
nrc_data <- get_nrc_sentiment(s_v)

# subset

sad_items <- which(nrc_data$sadness > 0)
head(s_v[sad_items])

# To view the emotions as a barplot
barplot(sort(colSums(prop.table(nrc_data[, 1:8]))), horiz = T, cex.names = 0.7,
        las = 1, main = "Emotions", xlab = "Percentage",
        col = 1:8)
######################## Emotion miningfor episode 5 ##############################
##
my_example_text5 <- readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeV.txt")
s_v <- get_sentences(my_example_text5)
##
sentiment_vector <- get_sentiment(s_v, method = "bing")
##head(sentiment_vector)

afinn_s_v <- get_sentiment(s_v, method = "afinn")
##head(afinn_s_v)

nrc_vector <- get_sentiment(s_v, method="nrc")

poa_v<-my_example_text5
poa_sent <- get_sentiment(poa_v, method="bing")
plot(
  poa_sent, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# percentage based figures
percent_vals <- get_percentage_values(poa_sent)

plot(
  percent_vals, 
  type="l", 
  main="Throw the ring in the volcano Using Percentage-Based Means", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

ft_values <- get_transformed_values(
  poa_sent, 
  low_pass_size = 3, 
  x_reverse_len = 100,
  scale_vals = TRUE,
  scale_range = FALSE
)

plot(
  ft_values, 
  type ="h", 
  main ="LOTR using Transformed Values", 
  xlab = "Narrative Time", 
  ylab = "Emotional Valence", 
  col = "red"
)

# categorize each sentence by eight emotions
nrc_data <- get_nrc_sentiment(s_v)

# subset

sad_items <- which(nrc_data$sadness > 0)
#head(s_v[sad_items])

# To view the emotions as a barplot
barplot(sort(colSums(prop.table(nrc_data[, 1:8]))), horiz = T, cex.names = 0.7,
        las = 1, main = "Emotions", xlab = "Percentage",
        col = 1:8)
# More depth for episode 6##########
poa_v<-my_example_text6
poa_sent <- get_sentiment(poa_v, method="bing")
plot(
  poa_sent, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# percentage based figures
percent_vals <- get_percentage_values(poa_sent)

plot(
  percent_vals, 
  type="l", 
  main="Throw the ring in the volcano Using Percentage-Based Means", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

ft_values <- get_transformed_values(
  poa_sent, 
  low_pass_size = 3, 
  x_reverse_len = 100,
  scale_vals = TRUE,
  scale_range = FALSE
)

plot(
  ft_values, 
  type ="h", 
  main ="LOTR using Transformed Values", 
  xlab = "Narrative Time", 
  ylab = "Emotional Valence", 
  col = "red"
)

# categorize each sentence by eight emotions
nrc_data <- get_nrc_sentiment(s_v)

# subset

sad_items <- which(nrc_data$sadness > 0)
head(s_v[sad_items])

# To view the emotions as a barplot
barplot(sort(colSums(prop.table(nrc_data[, 1:8]))), horiz = T, cex.names = 0.7,
        las = 1, main = "Emotions", xlab = "Percentage",
        col = 1:8)
####################### Emotion miningfor episode 6 ##############################
my_example_text6 <- readLines("E:\\Data_Science_Okv\\Send_Review\\NLP\\SW_EpisodeVI.txt")
s_v <- get_sentences(my_example_text6)
##
sentiment_vector <- get_sentiment(s_v, method = "bing")
##head(sentiment_vector)
#
afinn_s_v <- get_sentiment(s_v, method = "afinn")
##head(afinn_s_v)
#
nrc_vector <- get_sentiment(s_v, method="nrc")
#
s_v <- get_sentences(my_example_text6)
##
sentiment_vector <- get_sentiment(s_v, method = "bing")
##head(sentiment_vector)

afinn_s_v <- get_sentiment(s_v, method = "afinn")
##head(afinn_s_v)

nrc_vector <- get_sentiment(s_v, method="nrc")
#
poa_v<-my_example_text6
poa_sent <- get_sentiment(poa_v, method="bing")
plot(
  poa_sent, 
  type="h", 
  main="Example Plot Trajectory", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

# percentage based figures
percent_vals <- get_percentage_values(poa_sent)

plot(
  percent_vals, 
  type="l", 
  main="Throw the ring in the volcano Using Percentage-Based Means", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence", 
  col="red"
)

ft_values <- get_transformed_values(
  poa_sent, 
  low_pass_size = 3, 
  x_reverse_len = 100,
  scale_vals = TRUE,
  scale_range = FALSE
)

plot(
  ft_values, 
  type ="h", 
  main ="LOTR using Transformed Values", 
  xlab = "Narrative Time", 
  ylab = "Emotional Valence", 
  col = "red"
)

# categorize each sentence by eight emotions
nrc_data <- get_nrc_sentiment(s_v)

# subset

sad_items <- which(nrc_data$sadness > 0)
#head(s_v[sad_items])

# To view the emotions as a barplot
barplot(sort(colSums(prop.table(nrc_data[, 1:8]))), horiz = T, cex.names = 0.7,
        las = 1, main = "Emotions", xlab = "Percentage",
        col = 1:8)
###end#######