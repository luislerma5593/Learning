# Data Visualization with Seaborn

## General
```py
import seabron as sns
import matplotlib.pyplot as plt

sns.scatterplot(x,y)
sns.show()
```

## Types
```py
sns.scattetplot(x=x,y=y)

sns.countplot(	x = 'Col', data = df)	 #Counts automatically
				
sns.relplot(..., 
				kind= 'scatter'/'line', # Used for relations between 2 quantitative variables, can use lineplot or scatterplot
				col/row = 'var', # Create a sepparte column/row according to this cualtiative varaible
				col_wrap = x,
				col_order = list) #To wrap into x columns
				
sns.catplot(...,
				data = df,
				kind='count'/'bar'/'box'/'point'
				order = order_list,
				ci=None)
			
```
## Parameters
```py
x
y
data #Expects the dataframe
hue #Subgroups
size #Subgroups
style #Subgroups
hue_order =  ['Yes','No'] #Expects the order
palette = hue_colors #Expect a dictionary
col #Subgroups
row #Subgroups
col_wrap
col_order
alpha #To set the transparency {[0-1]
markers = True/False #Set a marker
dashes = True/False
ci #Confidence interval

#Boxplot
sym=¨¨ #To omit the outliers
whis = x/percentiles #To modify the whiskers (instead of 1.5 IQR)

#Pointplot
join = True/False #To show the lines that join different categories
estimator #To change the calculated value insted of mean (like median from numpy)
capsize #To add caps to the confidence intervals
ci
```

## Examples of plots

### Scatterplot
```py
import matplotlib.pyplot as plt
import seaborn as sns

sns.scatterplot(x="absences", y="G3", 
                data=student_data, 
                hue="location",
                hue_order=['Rural', 'Urban'])

plt.show()
```

### Countplot
```py
import matplotlib.pyplot as plt
import seaborn as sns

palette_colors = {'Rural': "green", 'Urban': "blue"}

sns.countplot(x='school', data=student_data, hue='location', palette = palette_colors)
plt.show()
```

### Relplot (Relational plot, 2 quantitative variables)

Allows creating subplots with `col` and `row` parameters

```py
#Scatterplot

sns.relplot(x="G1", 
			y="G3", 
            data=student_data,
            kind="scatter", 
            col="schoolsup",
            col_order=["yes", "no"],
            row="famsup",
            row_order=["yes", "no"])

sns.relplot(x='acceleration',
            y='mpg',
            data=mpg,
            kind='scatter',
            hue='origin',
            style='origin')

----------
#Lineplot

import matplotlib.pyplot as plt
import seaborn as sns

sns.relplot(x="model_year", y="horsepower", 
            data=mpg, kind="line", 
            ci=None, style="origin", 
            hue="origin",
            markers=True,
            dashes=False)

plt.show()
```

### Catplot (Categorical plot, 1 categorical variable)

Allows creating subplots with `col` and `row` parameters

```py
#Countplot

sns.catplot(y="Internet usage", data=survey_data,
            kind="count",
            col='Age Category')

plt.show()

---
#Barplot

category_order = ["<2 hours", 
                  "2 to 5 hours", 
                  "5 to 10 hours", 
                  ">10 hours"]

sns.catplot(x="study_time", y="G3",
            data=student_data,
            kind="bar",
            order=category_order,
            ci=None) #Confidence intervals off

plt.show()
```

### Boxplot (Categorical)
```py
study_time_order = ["<2 hours", "2 to 5 hours", 
                    "5 to 10 hours", ">10 hours"]

sns.catplot(x='study_time',
            y='G3',
            data=student_data,
            kind='box',
            order=study_time_order)
			whis=[5, 95] #Set whiskers to extend to 5th and 95th percentiles
plt.show()
```

### Point plots (Categorical)
```py
sns.catplot(x="famrel", y="absences",
			data=student_data,
            kind="point",
            capsize=0.2,
            join=False)
            
plt.show()
```

```py

```

