# Multiple linear regression model to analyze the number of cars sold. 
This project is a work in progress.
The objective of the project is to build a multiple linear regression model to better understand and describe the relationship between the amount of cars sold by the company of the user in a year and some of the economic factors of Argentina, as well as building a model useful to predict the amount of units sold. 
There are some preliminary analysis that can be found in the form of R scripts using baseline models.
Based on those findings more variables were incorporated in the model and some interaction terms were introduced.
The final version of the complete model can be found in Rmarkdown form in ./scripts/sold_units_complete.Rmd which was used to do the analysis and present it to the user.

### Features description:
num_units:
itcrb:
imported_cars:
semiconductor_crisis: 
devaluacion_interanual:
inflation: 
import_restriction:
PIB:
reserves:
PIB_over_reserves:
exchange_difference:
industry_trade_balance_difference:

### Methodology and Results
To avoid structural colinearity the variables PIB, reserves and PIB_over_reserves are centered.
The normality of the residuals is analyzed using normal quantile quantile plots and the homoscedasticity is checked using plots of the residuals against the fitted values.
Outliers are detected using plots of the standarized residuals against the fitted values. The leverage of the observations is also checked to look particularly for high-leverage outliers.
To investigate multicolinearity pairwise plots of the variables, the correlation matrix of the predictors and its eigenvalues and the variance inflation factors are used.
In the final analysis first a model including all the predictors is built. It suffers as expected of great multicolinearity.
To reduce the complexity of the model by using feature selection two methods are employed: 
 - Best subset selection is used although it is a computationally expensive technique since it is an exhaustive comparison of all the possible combinations. In the current model the number of observations is small as well as the number of features making it affordable. Adjusted R2 is the criteria used to select the subset of predictors.
 - LASSO regularization is employed. The best value for lambda is chosen using cross-validation based on the mean squared error.
The model selected using best subset selection is tested using cross-validation.
The MSE and RMSE are used to compare the models. The results are very similar for both of them with the RMSE being around 50000 sold units.
 
### Challenges
Multicolinearity of the factors: this is on of the main challenges of the model. It is expected to find high correlation between different economic factors, since it is known that they are intricately connected with one another. So it comes as no surprise that the model including all the predictors has high multicolinearity. For this reason this model does not offer much evidence about the relationship between the predictors and the amount of units sold. Furthermore this is a problem that extends also to the other models. In this application it is very hard to use inference to describe the isolated impact of each of the included variables. 
Applying best subset selection it is possible to build a model that is less complex and shows less multicolinearity but the results about the estimated coefficients must be interpreted carefully before jumping to conclusions about the underlying relationships. The included predictors seem to have a significant contribution to the model but they are still correlated to the excluded variables which makes it difficult to evaluate their isolated relationships.
- Small sample
- Removing the outlier in the model using best subset selection changes the coefficients but it doesn't change much the fit of the model.