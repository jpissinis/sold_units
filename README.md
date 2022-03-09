## Multiple linear regression model to analyze the number of cars sold. 
This project is a work in progress.
The objective of the project was to build a multiple linear regression model to predict the amount of cars sold in one year by the company of the user based on economic factors of Argentina in the last 20 years. As a secondary objective the goal was also to describe the relationship between some of this factors and the amount of units sold.
There are some preliminary analysis that can be found in the form of R scripts.
Based on those findings more variables were incorporated in the model.
The final version of the complete model can be found in Rmarkdown form in ./scripts/sold_units_complete.Rmd which was used to do the analysis and present it to the user.

# Features description:
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

# Methodology and Results


# Challenges
Multicolinearity of the factors
Small sample
Removing the outlier in the model using best subset selection changes the coefficients but it doesn't change much the fit of the model.
Describing the relationships
Is is being developed in collaboration with the user. 