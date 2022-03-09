# Multiple linear regression model to analyze the number of cars sold. 
This project is a work in progress.
The objective of the project is to build a multiple linear regression model to predict the amount of cars sold in one year by the company of the user based on economic factors of Argentina in the last 20 years. As a secondary objective the goal is also to describe the relationship between some of this factors and the amount of units sold.
There are some preliminary analysis that can be found in the form of R scripts.
Based on those findings more variables were incorporated in the model and some interaction terms were introduced.
The final version of the complete model can be found in Rmarkdown form in ./scripts/sold_units_complete.Rmd which was used to do the analysis and present it to the user.

### Features description:
num_units: the amount of cars sold per year
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

###### Methodology and Results
To avoid structural colinearity the variables PIB, reserves and PIB_over_reserves are centered.
The normality of the residuals is analyzed using normal quantile quantile plots and the homoscedasticity is checked using plots of the residuals against the fitted values.
Outliers are detected using plots of the standarized residuals against the fitted values. The leverage of the observations is also checked to look particularly for high-leverage outliers.
To investigate multicolinearity pairwise plots of the variables, the correlation matrix of the predictors and its eigenvalues and the variance inflation factors are used.
In the final analysis first a model including all the predictors is built. It suffers as expected of great multicolinearity.
To reduce the complexity of the model and to do feature selection two methods are employed: 
 - Best subset selection is used although it is a computationally expensive technique since it is an exhaustive comparison of all the possible combinations. In the current model the number of observations is small as well as the number of features making it affordable. Adjusted R2 is the criteria used to select the subset of predictors.


# Challenges
Multicolinearity of the factors
Small sample
Removing the outlier in the model using best subset selection changes the coefficients but it doesn't change much the fit of the model.
Describing the relationships
Is is being developed in collaboration with the user. 