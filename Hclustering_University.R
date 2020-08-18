
#input <- readWorksheet(loadWorkbook("E:/Universities_Clustering.xlsx"),sheet=1)
#mydata <- input[1:25,c(1,3:8)]
# Load data as mydata

normalized_data <- scale(mydata[,2:7]) #excluding the university name columnbefore normalizing
d <- dist(normalized_data, method = "euclidean") # distance matrix
fit <- hclust(d, method="complete")
?hclust
plot(fit) # display dendrogram
plot(fit, hang=-1)
groups <- cutree(fit, k=3) # cut tree into 3 clusters

?cutree
rect.hclust(fit, k=3, border="red")
?rect.hclust

membership<-as.matrix(groups)

final <- data.frame(mydata, membership)

final1 <- final[,c(ncol(final),1:(ncol(final)-1))]

?write.xlsx

write.csv(final1, file="final.csv")

getwd()
