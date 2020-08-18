# Load the Data
# credit.csv

credit <- read.csv(file.choose())

##Exploring and preparing the data ----
str(credit)

# look at the class variable
table(credit$default)

credit_rand <- credit[order(runif(1000)), ]
str(credit_rand)
credit_rand$default <- as.factor(credit_rand$default)

# split the data frames
credit_train <- credit_rand[1:900, ]
credit_test  <- credit_rand[901:1000, ]

# check the proportion of class variable
prop.table(table(credit_rand$default))
prop.table(table(credit_train$default))
prop.table(table(credit_test$default))

str(credit_train)


credit_train$checking_balance <- as.factor(credit_train$checking_balance)
levels(credit_train$default) <- make.names(levels(credit_train$default))

# Step 3: Training a model on the data
install.packages("C50")
library(C50)
credit_model <- C5.0(credit_train[,-17], credit_train$default)

# Display detailed information about the tree
summary(credit_model)

# Step 4: Evaluating model performance
# On Training Dataset
train_res <- predict(credit_model, credit_train)
train_acc <- mean(credit_train$default==train_res)
train_acc

test_res <- predict(credit_model, credit_test)
test_acc <- mean(credit_test$default==test_res)
test_acc

# cross tabulation of predicted versus actual classes
library(gmodels)
CrossTable(credit_test$default, test_res, prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))

