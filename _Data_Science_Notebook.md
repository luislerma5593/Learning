# AI

## General

Artificial Intelligence (AI) is a broad and constantly evolving field, which is divided into several subfields that focus on different techniques, methodologies and applications. Some of the most prominent subfields of AI are the following:

1. machine learning: this is the subfield of AI that focuses on the development of algorithms and statistical models that allow machines to learn from data. Within machine learning, other sub-areas can be distinguished such as supervised, unsupervised, reinforcement learning, etc.

2. Computer vision: This refers to the use of AI to analyze and understand images and videos, and extract useful information from them. The subfields of computer vision include object detection and recognition, image segmentation, 3D reconstruction, among others.

3. Natural language processing: This subfield of AI focuses on the understanding and generation of natural language by machines, such as machine translation, sentiment analysis, text generation, among others.

4. Robotics: This subfield of AI focuses on the design and development of autonomous or semi-autonomous robots that can perform complex tasks in varied environments. It includes areas such as autonomous navigation, motion control and manipulation, human-robot interaction, among others.

5. Knowledge-based reasoning: This is the subfield of AI that focuses on the representation, manipulation and use of knowledge and symbolic rules for problem solving.

6. Expert systems: This subfield of AI focuses on the creation of software systems that emulate the knowledge and experience of human experts in a particular field to help make decisions or solve complex problems.

7. Fuzzy logic: Refers to the use of fuzzy logic to model and solve problems involving uncertainty and ambiguity.


## Neural Networks

### Types of NN

* Single Neuron
	* Linear or logistic regression
	
* Feed-forward neural network
	* Non-linear classification and regression
	* There are just in one direction
	* No cycles

* Recurrent Neural Network
	* Can remember what it has seen before
	* Goes back (not in just one direction)

### CNN 

	* https://www.youtube.com/watch?v=V8j1oENVz00
	* Convolution layers, where there are used filters and produces "Features Maps" (which can be considered as images), where now they become the input for the following Convolution layer
	* When applying a convolution, there is an increase of resolution, because the output of a scaned area is just a single pixel
	* There are detections from detections received from prevoius layers. So, detections over detections, allow us to get more complex patterns
	* After many layers, it's needed to lower the resolution.
	* Each time, resolution is lowered, but the number of Feature Maps is incresaing (getting thicker), like: (||lll----)
	* There will be a moment, where there are detected enough patterns (feature maps) to use as individual inputs to the multi layer NN
	* There a lot of "simple" opeartins, which are the filters, and the only "learning" part is until the multi-layer, to learn the filters.

# Data Science 

## General Information

First:
1. Feature selection (correlation matrix)
2. Feature engineering
3. Data Leakege (Feature won't be available in production)

### Feature Engineering

1. Imputation
2. Handling outliers
3. Log transform (Qhen distribution is skewed)
4. One-hot encoding
5. Scaling (Normalization or Transformation)

For tuning the model:
	1. Feature Selection
	2. Feature Processing

In feature handling:
	1. Feature Generation 
	2. Feature Reduction

For feature processing:
* Missing values (Add, replace, remove)
* Scaling (Std, MinMax)
* Encoding (One hot encoding, dummy encoding)
* Numeric -> Categoric

### Explinability

* Partial depende plots
	- https://www.youtube.com/watch?v=uQQa3wQgG_s
	- It assumes that all features are independent
	- Simulation forcing a feature to every possible value in all rows and calculating the average probability.
	- Also works for complex
 
* Subpopulation analysis
	- Model predictions should be very similar among groups, else it colud be biased.
	- Shows the metrics across different subgroups.

* Individual explanations
	- Look in-depth for specific predictions
	- ICE: Faster
	- Shapley: Higher accuracy

## EDA

> Go to "EDA" in Python > Datacamp

1. Summary statistics
2. Cleaning and validating
	* Removing duplicates
	* Validating data types
	* Check for missing values
		* Drop if less than 5%
		* If more, impute mean, median, mode. Depending on context
		* If there's a column with not important info, delete it.
	* Replace
	* Handle outliers
		* Mean or median. Can be handled by groups
		* If they have a reason, keep them. If not accurate, remove them.
		* Can be removed based on a boxplot
	* Validate
3. Visualization
	* KDE if there are a lot vof values (for hues)
	* CDF for exploration
	* PMF is there is a small number of unique values
	KDE if there are a lot vof values
4. Correlations
5. Generating hypothesis
---
Other considerations
* Class imbalance can affect and may no be representative of entire population


## Machine Learning

### Steps in a project

> Go to "HR_Analytics" in Python > Datacamp

1. Analyze and clean data
	* Drop unnecessary columns
	* Convert into categories
	* See correlations

2. Test with different models
	* Choose type of model
		* Consider if you need explainability of variables
	* Use Grid Search

3. Evaluation
	* Consider Class Imbalance
	* Consider the appropiate metric 
	* Analyze "feature importance" if applicable
		* Remove features not gighly correlated

3. Train final model
	* Train with the best parameters
	* Review metrics once again


### Evaluation

For validation, there are two different ways:
1. Cross-fold (More robust but takes more time)
2. Hold out (Not that robust, but faster)

For evaluation, there are different tools, such as:
* Confusion matrix
	* Accuracy: Be careful when classes are not balanced
	* Precision: Positives correctly classified among positives classifications (TP/(TP+FP))
	* Recall: Correct positive classifications (TP/(TP+FN))
	* F1 combines precision and recall.
* ROC-AUC: Is the relation between recall/sensitivity (TP Rate) and 1-specificity (FP Rate). 
	* It's maximized when both recall/sensitivity and specificity are maximized.
* Metrics
	* MSE
	* R2

To modify the model in case it's needed to adjust the FP or FN, adjust the threshold

* Cross-valdiation
Cross-validation is particularly useful when the dataset is small, or when we want to make sure that the model generalizes well to new data.

### Metrics to evaluate a model

When evaluating the performance of a prediction model, there are several metrics that can be used to score the model. The choice of metrics depends on the specific problem being solved and the priorities of the stakeholders involved. Here are some commonly used metrics:

* Accuracy: This is a measure of how often the model makes correct predictions. It is calculated by dividing the number of correct predictions by the total number of predictions. This metric is useful when the classes are balanced.

* Precision: This measures the proportion of true positives (correctly predicted positive cases) among all the positive predictions made by the model. It is calculated by dividing the number of true positives by the sum of true positives and false positives. This metric is useful when the cost of a false positive is high.

* Recall: This measures the proportion of true positives among all the actual positive cases in the data. It is calculated by dividing the number of true positives by the sum of true positives and false negatives. This metric is useful when the cost of a false negative is high.

* F1 score: This is the harmonic mean of precision and recall. It combines both metrics to provide a single score. It is calculated as 2*(precision*recall)/(precision+recall). This metric is useful when both precision and recall are important.

* Area under the ROC curve (AUC-ROC): This metric measures the performance of the model across all possible thresholds. It is calculated by plotting the true positive rate against the false positive rate at different threshold levels and calculating the area under the resulting curve. This metric is useful when the cost of false positives and false negatives are roughly equal.

* Mean absolute error (MAE): This is a measure of the average absolute difference between the predicted and actual values. It is useful for regression problems.

* Root mean squared error (RMSE): This is a measure of the average squared difference between the predicted and actual values, taking the square root of the result. It is also useful for regression problems.

It is important to keep in mind that no single metric can capture the performance of a model fully. Different metrics provide different information about the model's performance, and it is essential to choose the right metrics based on the specific problem being solved and the priorities of the stakeholders involved.

Note: For imbalanced classes, it should be better to use other metrics than the accuracy. Also "resampling" is recomended

### Supervised models

* Regression
	* Linear
	* Multiple
	* Polynominal
	
* Classification
	* Logistic regression
	* Decision trees
	* Random forest
	
	
### Unsupervised models

* Clustering
	* K-Means
	* Hierarchical clustering

* Dimensionality reduction
	* PCA

	1. Standarization
	2. Optimization

	e.g.	PCA1 = x1*f1 + x2*f3+...
	
	
#### Regresssion models

Least squares, ridge and LASSO regressions are linear regression techniques used to model the relationship between an output variable and one or more predictor variables. Here I explain their main differences:

1. least squares regression: is a linear regression technique used to find the regression line that minimizes the sum of squared errors between the predictor variables and the output variable. It does not impose any additional restrictions on the regression coefficients, which means that there may be an overfit to the data if the predictor variables are highly correlated or if there are too many predictor variables in the model.

2. Ridge regression: is a linear regression technique used to reduce the variance of the regression coefficients when there is multicollinearity in the data (when the predictor variables are highly correlated). Ridge regression introduces an L2 constraint on the regression coefficients, which means that large coefficients are penalized and small coefficients are favored. This reduces the magnitude of the regression coefficients, which can help prevent overfitting to the data.

3. LASSO regression: is a linear regression technique used to select the most important predictor variables in the model and reduce the number of predictor variables when there are many. LASSO regression introduces an L1 constraint on the regression coefficients, which means that large coefficients are penalized and coefficients close to zero are favored. This can lead to the selection of more important predictor variables and the elimination of less important variables from the model.

In summary, while least squares regression is used to fit an unrestricted regression line, ridge regression and LASSO regression introduce restrictions on the regression coefficients to avoid overfitting and improve model accuracy. Ridge regression focuses on reducing the variance of the regression coefficients, while LASSO regression focuses on selecting important predictor variables and eliminating less important variables.

Translated with www.DeepL.com/Translator (free version)

### Models Results

* Overfitting
In this case, check if there's gonna be data leakage. Is there a column that we are not gonna have?
E.g. "Repeated" course column is classified depending on the grade, but the grade is known untill the end, so remove "Grade" feature from the model




## Time Series

### Types

* Univariate: Just 1 variable
* Multivariate: 2 or more variables (weight and height)

* Multiple univariate: 2 independent variables (weight from 2 different people)

### Formats

* Wide format: One column for each variable
	* Good for Manova or Anova.
	
* Long format: One column for the variable and another one for de identifier (weight and name(2 different) columns)
	* Good for Mixed Models or Survival Analysis.
	
### Components

1. Trend
	* Upward, downward, horizontal
	* Linear or non-linear
	
2. Seasonality 
	* Vacations
	* Seasons of the year
	
3. Cycle
	* When time series follow a non seasonal up and down pattern
	* Like recovery, prosperity, recesion, depresion in the business cycle
	* Varying frequencies
	
4. Random variation
	* Produced by war, earthquake, flood, famine
	
The additive model is the sum of all the components, and seasonality tends to stay constant over time.

The multiplicative model is the multiplication of the components and seasonality tends to increase over time.	

### Objectives

* Descriptive
	* Ploting and seeing main components

* Explanatory
	* In multivariate, to see if the changes in one variable explain the other one

* Forecasting
	* Uses observed values of a TS with a model to predict future values
	* There are multiple techinques like ARIMA

* Control
	* Try to control physical systems or business outcome
	* Like dropping flight ticket prices to keep customers
	
### Correlation betwee time series

* Pearsons: To compute lienar relationships
* Kendall Tau or Spearman: To compute non-linear relationships

## Recommendations for projects

In an excercise where it's needed to predict if a payment would be accepted or not, it's a good idea to add a window and analyze the pervious payments for each card. So it's needed to add a window and aggregarte te purchase amount (Min, Max, Avg), doing feature generation.


