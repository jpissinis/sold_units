# Multiple linear regression model to analyze the number of cars sold. 
This project is a work in progress.
The objective of the project is to build a multiple linear regression model to better understand and describe the relationship between the amount of cars sold by the company of the user in a year and some of the economic factors of Argentina, as well as building a model useful to predict the amount of units sold. 
There are some preliminary analysis that can be found in the form of R scripts using baseline models.
Based on those findings more variables were incorporated in the model and some interaction terms were introduced.
The final version of the complete model can be found in Rmarkdown form in ./scripts/sold_units_complete.Rmd which was used to do the analysis and present it to the user.

### Features description:
num_units: number of cars sold in a year.
itcrb: real exchange rate between Argentina and USA in average through time. 
imported_cars: dollars in Millions destined to the car and auto parts imports
semiconductor_crisis: worldwide semiconductor shortage (dichotomous variable)
devaluacion_interanual: Annual Devaluation Rate of the Local Currency (ARS) from January to December.
inflation: annual Inflation rate from Jan to December (note: during 6 years the rate hasn't been taken from the Governmental Agency due to the lack of robustness and intervention of the Agency.
import_restriction: restrictions imposed by the Government in order to import goods (dichotomous variable)
PIB: gross domestic product of Argentina in Millions of dollars in current prices.
reserves: national reserves.
PIB_over_reserves: calculated using PIB/reserves.
exchange_difference: difference between the official exchange rate between US Dollar and Argentinean Peso (determined by the government) and the real exchange rate.
industry_trade_balance_difference: 

### Methodology and Results
To avoid structural colinearity the variables PIB, reserves and PIB_over_reserves are centered.
The normality of the residuals is analyzed using normal quantile quantile plots and the homoscedasticity is checked using plots of the residuals against the fitted values.
Outliers are detected using plots of the standarized residuals against the fitted values. The leverage of the observations is also checked to look particularly for high-leverage outliers.
To investigate multicollinearity pairwise plots of the variables, the correlation matrix of the predictors and its eigenvalues and the variance inflation factors are used.
In the final analysis first a model including all the predictors is built. It suffers as expected of great multicollinearity.
To reduce the complexity of the model by using feature selection two methods are employed: 
 - Best subset selection is used although it is a computationally expensive technique since it is an exhaustive comparison of all the possible combinations. In the current model the number of observations is small as well as the number of features making it affordable. Adjusted R2 is the criteria used to select the subset of predictors.
 - LASSO regularization is employed. The best value for lambda is chosen using cross-validation based on the mean squared error.
The model selected using best subset selection is tested using cross-validation.
The MSE and RMSE are used to compare the models. The results are very similar for both of them with the RMSE being around 50000 sold units.
 
### Challenges
multicollinearity: this is one of the main challenges of the model. It is expected to find high correlation between different economic factors, since it is known that they are intricately connected with one another. So it comes as no surprise that the model including all the predictors has high multicollinearity. For this reason this model does not offer much evidence about the relationship between the predictors and the amount of units sold, even the overall direction (the sign of the coefficients) swing drastically. Furthermore, this is a problem that extends also to the other models. In this application it is very hard to use inference to describe the isolated impact of each of the included variables. 
Applying best subset selection it is possible to build a model that is less complex and shows less multicollinearity but the results about the estimated coefficients must be interpreted carefully before jumping to conclusions about the underlying relationships. The included predictors seem to have a significant contribution to the model but they are still correlated to the excluded variables which makes it difficult to evaluate their isolated relationships.
As it is also known LASSO regression is a great regularization method and it shows good results for variable selection but it makes it difficult to draw conclusions of the coefficients through inference.
- Small sample: counting with only 20 samples in the dataset is a limitation that must be considered in every step of the process. It makes the estimations more imprecise and it decreases the power of the model.
-Outliers: an outlier was identified in the best subset model which also has a high leverage, indicating that it has a big impact on the model. Removing the outlier in the model does not seem to have a great impact on the overall fit of the model but it seems to change the coefficients significantly

## Future perspectives
We are currently working on a model to do predictions on a monthly basis using similar variables. This will be more useful for day to day tasks and will greatly increase the amount of datapoints available.