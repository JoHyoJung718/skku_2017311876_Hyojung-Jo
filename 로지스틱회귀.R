install.packages(c("caret","e1071"))
library(caret)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(gridExtra)
library(MASS)
library(glmnet)
library(boot)
library(data.table)


data <- read.csv(file="data.csv", header=TRUE, sep=",")
data <- data[,-1]

#train/test data 나누기 (8:2) train123개 test31개
set.seed(0) #for reproducibility
train <- sample(1:nrow(data), size=0.8*nrow(data),replace=FALSE)
test <- (-train)


train <- data[train,]
test <- data[test,]


#모델만들기
result <- glm(매출액 ~ .,
                 family=binomial(link="logit"), data=train)

summary(result)

#성능평가
fitted.results <- predict(result,newdata=subset(test,select=c(1,2,3,4,5,6,7)),type='response')
fitted.results<-ifelse(fitted.results > 0.5,1,0)

misClasificError <-mean(fitted.results != test$매출액)

print(paste('Accuracy',1-misClasificError))



#유의하지 않은 변수 제거
reduced.model = step(result, direction="backward")
summary(reduced.model)
result <- reduced.model


