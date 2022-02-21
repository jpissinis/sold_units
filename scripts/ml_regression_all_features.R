#Importing the packages
library(readr)
library(car)
library(glmnet)
library(leaps)
#Importing the data
file_path<-"./raw/sold_units_all_features.csv"
sold_units<-read_csv(file_path)

#Renaming the columns
my_names<-c("year","num_units","itcrb","import_restriction","exchange",
            "inflation","reserves","PIB")
names(sold_units)<-my_names

#Building the model
sold_units_model<-lm(sold_units[,-1])
summary(sold_units_model)

#Pairwise plots of the features
pairs(sold_units[,-1])

#Analyzing the residuals
plot(fitted(sold_units_model),residuals(sold_units_model))
qqnorm(residuals(sold_units_model))

#Looking for outliers and high leverage points
plot(fitted(sold_units_model),residuals(sold_units_model))
plot(fitted(sold_units_model),rstandard(sold_units_model))
plot(hatvalues(sold_units_model))
abline(h=length(coef(sold_units_model))/nrow(sold_units)*2, col = "red",lty = 2)
plot(rstandard((sold_units_model)))

#Looking for colinearity
cor(sold_units[,c("itcrb","import_restriction","exchange","inflation",
                  "reserves","PIB")])
vif(sold_units_model)
eigen(cor(sold_units[,c("itcrb","import_restriction","exchange","inflation",
                        "reserves","PIB")]))

#feature selection
#Applying best subset selection
sold_units_subsets<-regsubsets(sold_units[,-1]$num_units~.,sold_units[,-1])
summary(sold_units_subsets)
plot(summary(sold_units_subsets)$adjr2)
plot (sold_units_subsets, scale = "adjr2")
plot (sold_units_subsets, scale = "r2")
which.max(summary(sold_units_subsets)$adjr2)
coef(sold_units_subsets, which.max(summary(sold_units_subsets)$adjr2))
names(coef(sold_units_subsets, which.max(summary(sold_units_subsets)$adjr2)))
#building the best two models
sold_units_model_best3<-lm(sold_units[,c("num_units","itcrb","exchange",
                                         "inflation")])
sold_units_model_best4<-lm(sold_units[,c("num_units","import_restriction",
                                         "inflation","reserves","PIB")])

#analyzing the model with 3 predictors
summary(sold_units_model_best3)

#Analyzing the residuals
plot(fitted(sold_units_model_best3),residuals(sold_units_model_best3))
qqnorm(residuals(sold_units_model_best3))

#Looking for outliers and high leverage points
plot(fitted(sold_units_model_best3),residuals(sold_units_model_best3))
plot(fitted(sold_units_model_best3),rstandard(sold_units_model_best3))
plot(hatvalues(sold_units_model_best3))
abline(h=length(coef(sold_units_model_best3))/nrow(sold_units_model_best3)*2,
       col = "red",lty = 2)
plot(rstandard((sold_units_model_best3)))
#Looking for colinearity
cor(sold_units[,c("itcrb","exchange","inflation")])
vif(sold_units_model_best3)
eigen(cor(sold_units[,c("itcrb","exchange","inflation")]))

#analyzing the model with 4 predictors
summary(sold_units_model_best4)

#Analyzing the residuals
plot(fitted(sold_units_model_best4),residuals(sold_units_model_best4))
qqnorm(residuals(sold_units_model_best4))

#Looking for outliers and high leverage points
plot(fitted(sold_units_model_best4),residuals(sold_units_model_best4))
plot(fitted(sold_units_model_best4),rstandard(sold_units_model_best4))
plot(hatvalues(sold_units_model_best4))
abline(h=length(coef(sold_units_model_best4))/nrow(sold_units)*2, col = "red",lty = 2)
plot(rstandard((sold_units_model_best4)))

#Looking for colinearity
cor(sold_units[,c("import_restriction","inflation","reserves","PIB")])
vif(sold_units_model_best4)
eigen(cor(sold_units[,c("import_restriction","inflation","reserves","PIB")]))

#applying LASSO
sold_units_lasso<-glmnet(as.matrix(sold_units[,-1][,-1]),
                         as.matrix(sold_units[,2]),alpha=1)
sold_units_lasso

#selecting lambda using cross-validation
cv_sold_units_lasso<- cv.glmnet(as.matrix(sold_units[,-1][,-1]),
                                as.matrix(sold_units[,2]),alpha=1,
                                grouped = FALSE)
plot(cv_sold_units_lasso)
best_lambda <- cv_sold_units_lasso$lambda.min
best_lambda
sold_units_lasso_best<-glmnet(as.matrix(sold_units[,3:8]), 
                              as.matrix(sold_units[,2]), alpha = 1,
                              lambda = best_lambda)
sold_units_lasso_best
coef(sold_units_lasso_best)

