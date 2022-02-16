#Importing the packages
library(readr)
library(car)

#Importing the data
file_path<-"./raw/sold_units.csv"
sold_units<-read.csv(file_path)

#Renaming the columns
my_names<-c("year","num_units","exchange","itcrb")
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
abline(h=3/nrow(sold_units)*2, col = "red",lty = 2)
plot(rstandard((sold_units_model)))

#Looking for colinearity
cor(sold_units[,c("exchange","itcrb")])
vif(sold_units_model)
eigen(cor(sold_units[,c("exchange","itcrb")]))