# Numpy

```py
np.array() - Creates an array
arr.reshape(rows,cols) - New shape to the array
np.hstack((a1,a2)) - Combine arrays horizontally
np.vstack((a1,a2)) - Combine arrays vertically
np.concatenate((a1,a2)) - Concatentes arrays (Can use axis = 0/1)
array.sum( axis = 0/1) 
array.min()
array.max()
array.mean()
np.nanmean(x) - Calculates the mean ignoring NaNs
np.isna(x) - Return True or False
df.dropna(how = any/all)
df.fillna(x)
np.around(array,n) - Round the numbers of an array

# Random

np.random.seed() - Set seed
np.random.rand() - Generates a random number between 0 and 1
np.random.randint(min,max-1) - Random intteger


np.logical_and(x,y)
np.logical_or(x,y)

np.linalg.inv() - Return inverse when det != 0
np.linalg.pinv() -Return inverse when det != 0 or pseudo inverse when det = 0

np.sin(x) - Creates the values for y from x

np.linspace(a,b,c) - Creates c numbers from a to b 
```

```py
# Example to get two numbers in one line

n, p = [int(x) for x in input().split()]
```

# Pandas

```py

df.index = [a,b,c,...]
pd.read_csv("...", index_col = 0, parse_dates=["date_col"])

df.head()
df.tail()
df.info() - Shows Column names and Data types
df.describe() - Describe df
df.min()
df.max()
df.mean()
df.quantile([0.25 0.5 0.74 1])
df.median()
df.var()
df.std()
df.mode()
df.sum()

#Cumulatives
df.cumsum() 
df.cummax()
df.cummin()
df.cumprod()

df.drop_duplicates(subset=cols)

df["letters"].isin([x,y])

df[col].sort_values()
df[col].sort_index()

df.groupby("col").mean()
df.groupby("col")["col2"].agg([min, max])

# Same
df.groupby(col1)[col2]
df.pivot_table(values=col2, index=col1, aggfunc = x) - Can add columns = y, fill_value = 0, margins = True (totals)

# Categorical
df["col"].value_counts() - Count ocurrencies (Can use sort, normalize)
df["col"].describe() - Count, unique, top, freq

#Dictionaries
del(dict["x"]) - Delete an item from a dictionary

# DataFrames
df.set_index(col)
df.reset_index(drop = True) - To undo
df.set_index(pd.Index(["2","4","6","8","10"]))
df.loc[[index_1, index_2]]

```

### Summary Statistic
```py
df[col].agg([x,y,z])

```

List - Order matters
Dictionary - When you need a lookup table

## For loop
```py
for key, value in dict.items(): - Dictionary
for val in np.nditer(my_array): - Numpy array}

for lab,row in df.iterrows(): - DataFrame

for lab, row in cars.iterrows(): - DataFrame 
    cars.loc[lab, "COUNTRY"] = str(row["country"]).upper()
#OR
cars["COUNTRY"] = cars["country"].apply(str.upper)

```

# Matplotlib

## Introduction

```py
plt.style.use('ggplot') - Change style as R

plt.plot(x,y)

plt.hist(x)
- bins = number_of_bins
- range = (min, max)
- density = True/False (probability)
- alpha = 0-1 // For transparency

plt.boxplot(x)

plt.barplot(x,y)
- bottom = df.x
- yerr = df.error

plt.barh(x,y)
plt.scatter(x, y, c='m')

plt.title('Lab') - Title
plt.xlabel('x') - X Label
plt.ylabel('y') - Y Label
plt.yticks([a,b,c,...]) - Add labels/values to axis
plt.grid(True)

plt.plot(..., label	 = "Leg_1")
plt.legend() - Add legend

Example
plt.legend(["Female","Male"])

plt.text(x_cord,y_cord,text) - Add a text
plt.xlim() - X limit
plt.ylim() - Y limit
plt.show() - Show a plot

plt.savefig("Img.png")

df.plot(kind = 'scatter',x = 'x',y = 'y') - Plot with Pandas
df.plot(kind = "hist"...) - Histogram
df.plot(kind = "bar"...)
df.plot(kind="line", x="x", y="y")
- rot = degrees


plt.plot(x, y, c='b'); - Plot x and y
plt.axvline(x.mean(), c='y') - Vertical line

plt.plot(..., linestyle = "--") #Or next to the color (plt.plot(x, np.cos(x), 'r--'...))
plt.scatter(..., marker='<', color='b') - Change the marker and the color

https://matplotlib.org/stable/api/markers_api.html

```

### Colors

```py
plt.plot(...,color = "Orange")

k for black 
r for red
b for blue
g for green
c for cyan
```

### Linestyles
```py
plt.plot(..., linestyle = 2)

-
--
-.
:
```

### Markers
```py
plt.plot(..., marker = "x")

w
s
o
d
*
h
```

### Style
```py
plt.style.use("x")

fivethirtyeight
ggplot
seabron
default
```


### Create a figure
```py
import matplotlib.pyplot as plt
fig = plt.figure()  #First fig
ax = plt.axes()     #Then axes
plt.savefig('fig.png')
plt.show()
```

### Examples
```py
avocados_2016.isna().sum().plot(kind = "bar")
```
---

## Data visualization with Matplotlib (Datacamp object oriented)

### Lineplot
```py
# Base format

fig, ax = plt.subplots()

#fig, ax = plt.subplots(figsize(x,y))
fig.set_size_inches([x,y])

ax.plot(x,y,
				marker = "o"
				linestyle = "--"
				color = "r")
ax.set_xlabel()
ax.set_ylabel()
ax.tick_params("x"/"y", colors="blue")
ax.set_xticklabels(df.index, rotation = 90)
ax.set_title()	
ax.annotate( "text", 
			  xy=(pd.Timestamp("yyyy-mm-dd",  y),
			  xytext = (pd.Timestamp("yyyy-mm-dd",y),
			  arrowprops = {
							  "arrowstyle":"->",
							  "color":"gray"} )
plt.show()		
```

### Stacked Bar plot format
```py
fig, ax = plt.subplots()

ax.bar(df.index, df["gold"], label="Gold")
ax.bar(df.index, df['silver'], bottom = df['gold'], label="Silver")
ax.bar(df.index, df['bronze'], bottom = df['gold'] + df['silver'], label="Bronze")
ax.set_xticklabels(df.index, rotation = 90)
ax.legend()
plt.show()
```

### To add an error bar
```py
ax.bar( "Rowing",
		rowing['Height'].mean(),
		yerr=rowing['Height'].std())
```

### Error bars to plots
```py
ax.errorbar( df['Month'],
			 df['AVG'],
			 yerr=df['std'])
```

### Boxplot
```py
fig, ax = plt.subplots()

ax.boxplot([df["col"],df2["col"]])
ax.set_xticklabels(["lab_1","lab2"])
ax.set_ylabel('ylab')
plt.show()
```

### Histogram
```py
fig, ax = plt.subplots()

ax.hist(	df['col'], 
			label=['lab'], 
			bins = n_bins / bins=[n1,n2,n3,n4],
			histtype="step")
ax.set_xlabel("lab")
ax.set_ylabel("# of observations")
ax.legend()
plt.show()
```

### Scatter plots
```py
fig, ax = plt.subplots()

ax.scatter(	df['var1'],
			df['var2'],
			color = "r",
			label='lab',
			c=df.index)
plt.show()
```

### Small multiples
```py
fig, ax = plt.subplots(a,b, sharey=True, sharex=True)
ax[0,0].plot()
```

### Time-series
```py
pd.read_csv(..., parse_dates=["date"]) / To identify correctly as date
ax.plot(df.index, df["col"])

# Using twin axes

ax2=ax.twinx()
ax2.plot(..., color="r")
ax2.set_ylabel(..., color="r")
```


#### Plot time-series function
```py
def plot_timeseries(axes, x, y, color, xlabel, ylabel):  # axes = ax

  axes.plot(x, y, color=color)
  axes.set_xlabel(xlabel)
  axes.set_ylabel(ylabel, color=color)
  axes.tick_params('y', colors=color)
```

### Examples
```py
fig, ax = plt.subplots()

# Plot the CO2 levels time-series in blue
plot_timeseries(ax, climate_change.index, climate_change["co2"], 'blue', "Time (years)", 'CO2 levels')

# Create an Axes object that shares the x-axis
ax2 = ax.twinx()

# Plot the relative temperature data in red
plot_timeseries(ax2, climate_change.index, climate_change['relative_temp'], 'red', 'Time (years)', "Relative temp (Celsius)")

# Annotate point with relative temperature >1 degree
ax2.annotate(">1 degree", xy=(pd.Timestamp('2015-10-06'), 1) ,xytext=(pd.Timestamp('2008-10-06'), -0.2), arrowprops={'arrowstyle':'->', 'color':'gray'})

plt.show()
```

### Styles 
```py
plt.style.use("default")
- fivethirtyeight
- grayscale (for black and white)
- ggplot
- seabron
- bmh
- seaborn-colorblind
- tableau-colorblind10
- Solarize_Light2
```

### Share visuaizations 

```py
fig.set_size_inches([x,y])

fig.savefig('name.png') - Lower quality 
fig.savefig('name.jpg') - Better quality
fig.savefig('name.svg') - Vector graphic, for ilustration softwares

ls - To list the files inside the directory

# Parameters
- quality = x
- dpi = 300 (Dots per inch, 300 is high quality)
```

### Automating figures
```py
fig, ax = plt.subplots()

# Loop over the different sports branches
for sport in sports:
  # Extract the rows only for this sport
  sport_df = summer_2016_medals[summer_2016_medals["Sport"] == sport]
  # Add a bar for the "Weight" mean with std y error bar
  ax.bar( sport, 
          sport_df["Weight"].mean(), 
          yerr=sport_df["Weight"].std())

ax.set_ylabel("Weight")
ax.set_xticklabels(sports, rotation=90)

# Save the figure to file
plt.show()
```

---
# Joining data with pandas

## Join / Merge

#### Parameters
- indicators = True/False - Return Both, only left or only right (tables)

### Inner Join
Matching values in both tables
```py
df1.merge(df2, on = "col") 
df1.merge(df2, on = "col")\.merge(df3, on = "col") - Merge 3 tables or more (adding "\")
# Parameters
suffixes = ("_suf1","_suf2") - Add suffixes to the new columns
on = ["col1","col2"]
```
### Left Join
Return all rows in left table, and just the values in the right table where key columns match
```py
df1.merge(df2, on = "col", how = "left") 
```

### Right Join
Return all rows in right table, and just the values in the left table where key columns match
```py
df1.merge(df2, how = "right", left_on= "id", right_on= "x_id") 
```

### Outer Join
Return all rows in both tables
```py
df1.merge(df2, on = "col", how = "outer", suffixes = ["_s2","_s1"]) 
```

### Self Join
Joining a table to itself
```py
df1.merge(df2, left_on = "sequel", right_on = "id", suffixes = ["_org",_seq"]) // Adding the sequels to the movies
```

### Examples
```py
print(licenses_zip_ward.groupby("alderman").agg({'income':'median'})) - With aggregations

# If merging with indexes, set left/right_index = True

#Use
merge > groupby > aggregations
```

### Semi Join
Returns intersection (similar to inner), but just values from left table
```py
df1.merge(df2, on= "col")
df1[df1["colx"].isin(genres_tracks["colx"])]
```

### Anti Join
Returns the left table, excluding intersection
```py
# Merge employees and top_cust
empl_cust = employees.merge(top_cust, on='srid', 
                                 how='left', indicator=True)

# Select the srid column where _merge is left_only
srid_list = empl_cust.loc[empl_cust['_merge'] == 'left_only', 'srid']

# Get employees not working with top customers
print(employees[employees["srid"].isin(srid_list)])
```
---

## Concatenate

Combining vertically

- df.concat()
- df.append()

#### Parameters
- ignore_index = True/False
- keys = ["a","b","c"]
- sort = True/False - Sort columns in alphabetical order
- join = "inner"/"outer"

With merge()

- validate = 
			'one_to_one'
			'one_to_many'
			'many_to_one'
			'many_to_many'

with concat()

- verify_integrity = 
						False - Default
						True - Check if there are duplicate indexes, and raise an error

```py
pd.concat([df1, df2, df3], join = "inner", sort=True, keys = ["a","b","c"] )

df1.append([df2,df3], sort=False)
```

## Other merges for time-series

### pd.merge_ordered()

- pd.merge_ordered(df1,df2)
- Default is "outer"
- Data is ordered
- Good for time-series data

#### Parameters

- fill_method = 
				"ffill" - Forward fill, which fills the missing value with the prevoius one

#### Examples

```py
pd.merge_ordered(gdp,pop, how="inner", on = ["country","date"], fill_method="ffill")

```

### pd.merge_asof()

- Is like an ordered left join. Match on the nearest lower key column and not exact matches.
- "On" columns, must be sorted
- Used mainly for process which dates may not match exactly, or stock values

#### Parameters

- direction = 
				"forward" - Use de nearest greater key
				"backward" - Use de nearest lower key
				"nearest" - Use de nearest key

## .query()

It´s like a WHERE in SQL

- df.query("col >= 10" or type == "adjective" ")
- Can use "and" or "or"

## df.melt()

There exist wide format and long format

```py

df2 = df.melt( id_vars = "year", var_name="month", value_name="unempl_rate")
```

#### Parameters

- id_vars
- value_vars
- var_name
- value_name

##### Example
```py
# unpivot everything besides the year column
ur_tall = ur_wide.melt( id_vars = "year", var_name="month", value_name="unempl_rate")

# Create a date column using the month and year columns of ur_tall
ur_tall['date'] = pd.to_datetime(ur_tall['year'] + '-' + ur_tall['month'])
```

---

# Machine Learning
```py
df.corr().round(x) - Creates a correlation matrix

model.intercept_ - To get the intercept_
model.coef_ - To get the coefficient/slope
model.score() - R-squared
```
## Linear Regressión

To evalutae you cane either use:
- MSE
- R-squared

Compare different models

## Classification

KN Neighbors Classifier
- https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html

## Clustering 

### Clustering methods
- https://scikit-learn.org/stable/modules/clustering.html#overview-of-clustering-methods

### Pre-processing
- https://scikit-learn.org/stable/auto_examples/preprocessing/plot_scaling_importance.html


## Other

```py
is_recession = ['r' if s=='recession' else 'g' for s in gdp_recession['econ_status']] - List with expressions
```










