############ WBCD #################
# Read the dataset
wbcd <- read.csv(file.choose())

#First colum in dataset is id which is not required so we will be taking out
wbcd <- wbcd[-1]

#table of diagonis B <- 357 and M <- 212
table(wbcd$diagnosis)

# Replace B with Benign and M with Malignant. Diagnosis is factor with 2 levels that is B and M. We also replacing these two entery with Benign and Malignat
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B","M"), labels = c("Benign","Malignant"))

# table or proportation of enteries in the datasets. What % of entry is Bengin and % of entry is Malignant
round(prop.table(table(wbcd$diagnosis))*100,1)

#Create a function to normalize the data
norm <- function(x){ 
     return((x-min(x))/(max(x)-min(x)))
}

#Apply the normalization function to wbcd dataset
wbcd_n <- as.data.frame(lapply(wbcd[2:31], norm))

# create training and test data
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

# create labels for training and test data
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]


# Building a random forest model on training data 
install.packages("randomForest")
library(randomForest)

wbcd_forest <- randomForest(wbcd_train_labels~.,data=wbcd_train,importance=TRUE)
plot(wbcd_forest)

# Train Data Accuracy
train_acc <- mean(wbcd_train_labels==predict(wbcd_forest))
train_acc

# Test Data Accuracy
test_acc <- mean(wbcd_test_labels==predict(wbcd_forest, newdata=wbcd_test))
test_acc

varImpPlot(wbcd_forest)
