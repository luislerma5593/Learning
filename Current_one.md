# Exploratory Data Analysis

1. Explore (shape, columns, head, tail)
	* See frequencies with value_counts()
	
2. Clean and Validate (describe, info, compute if necessary)
	* Compute if necessary
	
3. Filter and Visualize
	* Histograms
	* Filter and see statistics

## General
```py
df.shape
df.columns
df.head()
df.tail()

```

### Clean and Validate
```py
df2=df.replace([a,b], np.NaN)
df.replace([a,b], np.NaN, inplace = True)
```

### Filter and Visualize
```py
plt.hist(col.dropna(), bins = x, histtype='step') - Cannot work with nans
plt.xlabel()
plt.ylabel()
plt.show()
```

## Distributions

### Probability Mass Function (PMF)
To see a distribution, the best is to  use a PMF (Probability Mass Function). It shows unique values, so we can see exactly where the peaks are, compared to an histogram, that put values into bins.

It is the probability that you get exactly x. PMF don't work well with a large amount of unique values
```py
pmf = Pmf(series, normalize = False) # Normalize converts to percentages form total
pmf.bar(label=x)
plt.show()
```

### Cumulative Distribution Function

Is the probability that you get value <= x, for a given value of x.

```py
cdf_fun = Cdf(series) 
cdf.plot()
plt.show()

probability = cdf_fun(value)
value = cdf_fun.inverse(probability)

# Select realinc
income = gss['realinc']
```

```py
norm.Pdf(series)
sns.kdeplot(sample) - Get a PDF (Density) from a PMF (Mass)
```

## Relationships

### Exploring relationships

When there are a lot of datapoints, we can use:

- Transparency (alpha)
- Marker smaller (markersize)
- Jittering  

```py
x_jitter = x + np.random.normal(0,2, size=len(brfss))
y_jitter = y + np.random.normal(0,2, size=len(brfss))
plt.plot(x_jitter,y_jitter, 'o', markersize = 1, alpha = 0.2)
plt.axis([x1,x2,y1,y2])
plt.show()
```

### Violin plots and Box plots
```py
data = df.dropna(subset = ['col1', 'col2'])
sns.violinplot(x = 'col1', y = 'col2', data=data, inner=None)
plt.show()

sns.boxplot(x='col1', y= 'col2', data=data, whis=10)
plt.show()

#Can add
plt.yscale('log')
```

### Coefficient of corrlation

This coefficient, only works for linear relationships. 

```py
df.corr() #Correlation matrix
```

### Simple linear regression

It's important to take a look at the slope of the linear regression, because the coefficient, doesn't give us this information.

```py
form scipy.stats import linregress

res = linregress(xs,ys) # Returns, slope, intercept, rvalue, pvalue, std

fx = np.array([xs.min(), xs.max()])
fy = res.intercept + res.slope*fx
plt.plot(fx, fy, '-')
```

## Multivariate relationships

- Regression is not simetric, so the regression of A onto B, is not the same that the regression on B onto A. 

- Regression alone cannot tell if A might cause B or if B might cause A.

```py
import statsmodels.fomrula.api as smf

# ols stands for "ordinary least squares"
results = smf.ols( 'A ~ B', data = df).fit() # Regress A as a function of B (y ~ x)
 
results.params # We get slope and intercept
```

### Multiple regression
```py
smf.ols('income ~ education + age', data=df).fit()

grouped = df.groupby('age')
mean_income_by_age = grouped['income'].mean()

plt.plot(mean_income_by_age, 'o', alpha = 0.5)
plt.xlabel('Age (years)')
plt.ylabel('Income (1986 $)')
plt.show()
```
%%%%%%%%%%%%%%%%#$%#$%#$%#% Scatter between age/Income
### Multiple regression adding a quadratic term

Because age has not a linear relationship with income, we can do the following, add age^2 to the regression:
```py
df['age2'] = gss['age']**2

model = smf.ols('income ~ educ + age + age2, data = df)
results = model.fit()
results.params
```

### Visualizing regression results

Sometimes the best way to understand a model is by looking at its predictions rather tan its parameters.     
```py

grouped = df.groupby('age')
mean_income_by_age = grouped['income'].mean()
plt.plot(mean_income_by_age, 'o', alpha = 0.5)

df['age'] = np.linspace(18,85)
df['age2'] =  df['age']**2

df['educ'] = 12
df['educ2'] = df['educ']**2
pred12 = results.predict(df)
plt.plot(df['age'], pred12, label='High School')

df['educ'] = 14
df['educ2'] = df['educ']**2
pred14 = results.predict(df)
plt.plot(df['age'], pred14, label='Associate')

df['educ'] = 16
df['educ2'] = df['educ']**2
pred16 = results.predict(df)
plt.plot(df['age'], pred16, label='Bachelor')

```

```py

```
### Examples
```py
#CDF
income = gss['realinc']

# Plot the CDFs
Cdf(income[high]).plot(label='High school')
Cdf(income[assc]).plot(label='Associate')
Cdf(income[bach]).plot(label='Bachelor')

# Label the axes
plt.xlabel('Income (1986 USD)')
plt.ylabel('CDF')
plt.legend()
plt.show()

---

# Evaluate the normal PDF
xs = np.linspace(2, 5.5)
ys = dist.pdf(xs)

# Plot the model PDF
plt.clf()
plt.plot(xs, ys, color='gray')

# Plot the data KDE
sns.kdeplot(log_income)

# Label the axes
plt.xlabel('log10 of realinc')
plt.ylabel('PDF')
plt.show()

---

# Drop rows with missing data
data = brfss.dropna(subset=['_HTMG10', 'WTKG3'])

# Make a box plot
sns.boxplot(x='WTKG3', y='_HTMG10', data=data, whis=10)

# Plot the y-axis on a log scale
plt.yscale('log')

# Remove unneeded lines and label axes
sns.despine(left=True, bottom=True)
plt.xlabel('Height in cm')
plt.ylabel('Weight in kg')
plt.show()

---

# Plot the scatter plot
plt.clf()
x_jitter = xs + np.random.normal(0, 0.15, len(xs))
plt.plot(x_jitter, ys, 'o', alpha=0.2)

# Plot the line of best fit
fx = np.array([xs.min(), xs.max()])
fy = res.slope * fx + res.intercept
plt.plot(fx, fy, '-', alpha=0.7)

plt.xlabel('Income code')
plt.ylabel('Vegetable servings per day')
plt.ylim([0, 6])
plt.show()

---

from scipy.stats import linregress
import statsmodels.formula.api as smf

# Run regression with linregress
subset = brfss.dropna(subset=['INCOME2', '_VEGESU1'])
xs = subset['INCOME2']
ys = subset['_VEGESU1']
res = linregress(xs, ys)
print(res)

# Run regression with StatsModels
results = smf.ols('INCOME2 ~ _VEGESU1', data = subset).fit()
print(results.params)

---

import statsmodels.formula.api as smf

# Add a new column with educ squared
gss['educ2'] = gss['educ']**2

# Run a regression model with educ, educ2, age, and age2
results = smf.ols('realinc ~ educ + educ2 + age + age2', data=gss).fit()

# Print the estimated parameters
print(results.params)

```




