data
train
test

factor(data)

library(rpart)
library(rpart.plot)

tree <- rpart(매출액 ~., data=train)
tree

rpart.plot(tree)
summary(tree)

predict(tree, test, type = "class")
test$매출액

(tt <- table(test$매출액, predict(tree, test, type = "class")))

str(train)
train$매출액 <- as.factor(train$매출액)
