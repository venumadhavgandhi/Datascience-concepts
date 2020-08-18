# Loading Universities data

library(readxl)
input <- read_excel(file.choose())
View(input)
mydata <- input[,c(1,3:8)]
View(mydata)
## the first column in mydata has university names
data <- mydata[,-1]
attach(data)
View(data)
?princomp
pcaObj<-princomp(data, cor = TRUE, scores = TRUE, covmat = NULL)

str(pcaObj)
summary(pcaObj)

loadings(pcaObj)

plot(pcaObj) # graph showing importance of principal components 

biplot(pcaObj)

plot(cumsum(pcaObj$sdev*pcaObj$sdev)*100/(sum(pcaObj$sdev*pcaObj$sdev)),type="b")

pcaObj$scores
pcaObj$scores[,1:3]

# Top 3 pca scores 
final<-cbind(input[,1],pcaObj$scores[,1:3])
View(final)

write.csv(final, file="Wine_PCA.csv")
